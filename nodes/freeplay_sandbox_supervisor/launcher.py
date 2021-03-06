import time
import sys
import subprocess
import psutil

import rospy

import roslaunch
import roslaunch.xmlloader 
from roslaunch.core import RLException
from roslaunch.config import load_config_default 
from rospkg.common import ResourceNotFound

class Launcher:
    def __init__(self, package, launchfile):

        self.package = package

        self.launchfile = launchfile
        self.name = launchfile.split("/")[-1].split(".launch")[0]
        self.prettyname = self.name.replace("_", " ")

        self.reachable=True
        self.desc = ""

        loader = roslaunch.xmlloader.XmlLoader(resolve_anon=False) 
        try:
            config = load_config_default([self.launchfile],
                                        None, 
                                        loader=loader, 
                                        verbose=False, 
                                        assign_machines=False) 

        except ResourceNotFound as e:
            pass
        except RLException as e:
            pass

        # contains default values + documentation
        self.args = {}
        for arg, v in loader.root_context.resolve_dict.get('arg_doc', {}).items():
            doc, value = v

            ################
            # manual type checking (!!) -- ast.literal_eval fails badly on strings like '/dev/video1'
            if value:
                try:
                    value = int(value)
                except ValueError:
                    try:
                        value = float(value)
                    except ValueError:
                        if value.lower() == "false": value = False
                        elif value.lower() == "true": value = True
            ################
            self.args[arg] = {"doc":doc,
                              "value": value, 
                              "type": type(value).__name__, 
                              "default_value": True
                             }

        self.has_args = bool(self.args)
        self.readytolaunch = self.checkargs()

        self.pid = None

        self.isrunning()
        if(self.pid):
            rospy.logwarn("Launch file <%s> is already running. Fine, I'm attaching myself to it." % self.name)

    def checkargs(self):
        """Check whether all the arguments are defined
        """
        for k,v in self.args.items():
            if v["value"] == None:
                return False
        return True

    def setarg(self, arg, value):

        rospy.loginfo("Setting arg <%s> to <%s> for %s" % (arg, str(value), self.prettyname))
        if self.args[arg]["type"] == "bool":
            # special case for checkboxes: checked == 'on'; unchecked == 'off'
            self.args[arg]["value"] = True if (value is True or value.lower() == "true") else False
        else:
            self.args[arg]["value"] = value

        self.args[arg]["default_value"] = False # manually modified value!

        rospy.loginfo(str(self.args[arg]))

        self.readytolaunch = self.checkargs()

    def make_rl_cmd(self):
        argcmd = [a + ":=" + str(v["value"]) for a,v in self.args.items() if not v["default_value"]]
        return ["roslaunch", self.package, self.name + ".launch"] + argcmd


    def start(self, stdout=sys.stdout, stderr=sys.stderr, env=None):

        if self.isrunning():
            rospy.logwarn("Launch file <%s> is already running. PID: %d" % (self.name, self.pid))
            return

        if self.reachable and self.readytolaunch:
            cmd = self.make_rl_cmd()
            rospy.loginfo("****************************")
            rospy.loginfo("Executing:")
            rospy.loginfo(" ".join(cmd))
            rospy.loginfo("****************************")
            self.pid = subprocess.Popen(cmd, stdout=stdout, stderr=stderr, env=env).pid

    def isrunning(self):
        """Returns true if this launch file is running, False otherwise

        Set or update self.pid accordingly.

        Attention! The process might have been started by someone else! (like on the command-line)
        """
        proc = None

        if self.pid:
            try:
                proc = psutil.Process(self.pid)
                if proc.status() != psutil.STATUS_ZOMBIE:
                    return True
                else:
                    # cleanup zombie processes
                    self.shutdown(force=True)

            except psutil.NoSuchProcess:
                self.pid = None

        roslaunch_processes = []
        for proc in psutil.process_iter():
            try:
                pinfo = proc.as_dict(attrs=['pid', 'name','cmdline'])
                if pinfo["name"] == "roslaunch" and len(pinfo["cmdline"]) > 3:
                    roslaunch_processes.append(pinfo)
            except psutil.NoSuchProcess:
                pass

        for p in roslaunch_processes:
            if  p["cmdline"][2] == self.package \
            and p["cmdline"][3] == self.name + ".launch":
                self.pid = p["pid"]

        return True if self.pid is not None else False

    def shutdown(self, force=False):
        """Properly terminate the roslaunch process, starting with all the children, and
        then the main process.
        Kill them if necessary.

        TODO: how does that work with nodes marked as 'respawn'?
        """
        if force or self.isrunning():
            psutil.Process(self.pid).terminate()

            proc = psutil.Process(self.pid)
            children = psutil.Process(self.pid).children()

            for p in children:
                p.terminate()
            gone, still_alive = psutil.wait_procs(children, timeout=15)
            for p in still_alive:
                p.kill()

            proc.terminate()
            gone, still_alive = psutil.wait_procs([proc], timeout=15)
            for p in still_alive:
                p.kill()


