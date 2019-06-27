import logging
logging.basicConfig(level=logging.DEBUG)

import os
import time
import sys
import subprocess
import psutil

# HACK!!!
SPECIAL_CASES = {"facialexpression_node": ["-device", "0"]}

class Launcher:
    def __init__(self, script, workingdir, args=None):

        self.workingdir = workingdir
        self.script = script
        self.name = script.split("/")[-1]
        self.prettyname = self.name.replace("_", " ").split(".py")[0]

        self.reachable=True
        self.desc = ""

        self.args = args if args else {}

        self.has_args = bool(self.args)

        self.readytolaunch=True

        self.pid = None

        self.isrunning()
        if(self.pid):
            logging.warn("Launch file <%s> is already running. Fine, I'm attaching myself to it." % self.name)

    def __repr__(self):
        return self.name


    def setarg(self, arg, value):

        logging.info("Setting arg <%s> to <%s> for %s" % (arg, str(value), self.prettyname))
        self.args[arg] = value

    def make_rl_cmd(self):
        argcmd = [a + " " + str(v) for a,v in self.args.items()]

        if self.name in SPECIAL_CASES:
            argcmd = SPECIAL_CASES[self.name]

        return [os.path.join(self.workingdir, self.name)] + argcmd


    def start(self, stdout=sys.stdout, stderr=sys.stderr, env=None):

        if self.isrunning():
            logging.warn("Script <%s> is already running. PID: %d" % (self.name, self.pid))
            return

        if self.reachable and self.readytolaunch:
            cmd = self.make_rl_cmd()
            logging.info("****************************")
            logging.info("Executing:")
            logging.info(" ".join(cmd))
            self.pid = subprocess.Popen(cmd, stdout=stdout, stderr=stderr, env=env, cwd=self.workingdir).pid
            logging.info("Checking everything is ok...")
            time.sleep(0.5)

            if not self.isrunning():
                logging.warning("Warning: script %s has died just after starting!" % str(self.name))
            else:
                logging.info("Process started with PID %s." % str(self.pid))

            logging.info("****************************")

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

        #TODO update to work with Katie's scripts
        existing_processes = []
        for proc in psutil.process_iter():
            try:
                pinfo = proc.as_dict(attrs=['pid', 'name','cmdline'])
                if pinfo["name"].endswith("py") and len(pinfo["cmdline"]) > 3:
                    existing_processes.append(pinfo)
            except psutil.NoSuchProcess:
                pass

        for p in existing_processes:
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
            gone, still_alive = psutil.wait_procs(children, timeout=5)

            for p in still_alive:
                p.kill()

            proc.terminate()
            gone, still_alive = psutil.wait_procs([proc], timeout=5)

            if not still_alive:
                logging.info("%s stopped." % self.name)

            for p in still_alive:
                logging.warning("%s not stopped! Killing it." % self.name)
                p.kill()


