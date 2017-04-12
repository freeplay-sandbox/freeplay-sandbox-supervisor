#!/usr/bin/env python
# -*- coding: UTF-8 -*-


from itertools import imap
from flup.server.fcgi import WSGIServer
import urlparse
from jinja2 import Environment, PackageLoader

import os
import rospy
import rosnode
import roslaunch
import roslaunch.xmlloader 
from roslaunch.core import RLException
from roslaunch.config import load_config_default 

from rospkg import RosPack
from rospkg.common import ResourceNotFound

import threading 
import time

import ast

uuid = roslaunch.rlutil.get_or_generate_uuid(None, False)
roslaunch.configure_logging(uuid)

#rospy.init_node('freeplay_sandbox_supervisor')

package = "freeplay_sandbox"

rp = RosPack()

class Launcher:
    def __init__(self, launchfile):
        self.launchfile = launchfile
        self.name = launchfile.split("/")[-1].split(".launch")[0]
        self.prettyname = self.name.replace("_", " ")

        self.launcher = roslaunch.parent.ROSLaunchParent(uuid, [self.launchfile])

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
            self.args[arg] = [doc, value, type(value).__name__]

        self.has_args = bool(self.args)
        self.readytolaunch = self.checkargs()

    def checkargs(self):
        """Check whether all the arguments are defined
        """
        for k,v in self.args.items():
            if v[1] == None:
                return False
        return True

    def setarg(self, arg, value):

        rospy.loginfo("Setting arg <%s> to <%s> for %s" % (arg, str(value), self.prettyname))
        if self.args[arg][2] == "bool":
            # special case for checkboxes: checked == 'on'; unchecked == 'off'
            self.args[arg][1] = True if value.lower() == "true" else False
        else:
            self.args[arg][1] = value

        rospy.loginfo(str(self.args[arg]))

        self.readytolaunch = self.checkargs()


    def start(self):

        if self.reachable and self.readytolaunch:
            self.launcher.start()

launchers = []

for root, dirs, files in os.walk(rp.get_path(package)):
    for file in files:
        if file.endswith(".launch"):
             launchers.append(Launcher(os.path.join(root, file)))


env = Environment(loader=PackageLoader('freeplay_sandbox_supervisor', 'tpl'))
supervisor_tpl = env.get_template('supervisor.tpl')
launcher_tpl = env.get_template('launcher.tpl')

def fixencoding(s):
    return s.encode("utf-8")

def getlauncher(name):
    launcher = None
    for l in launchers:
        if l.name == name:
            launcher = l
            break
    return launcher

def process_launch(options):
    launchfile = options["launch"][0]

    launcher = getlauncher(launchfile)
    if launcher is None:
        rospy.logwarn("Attempting to launch inexistant %s" % launchfile)
        return False

    rospy.loginfo("Attempting to launch %s" % launcher.launchfile)

    launcher.start()

def records(path, options):

    if "action" in options:
        if "start" in options["action"]:
            return process_launch(options)
        elif "setarg" in options["action"]:
            launcher = getlauncher(options["launch"][0])
            launcher.setarg(options["arg"][0],
                            options.get("value", [None])[0])
            return launcher_tpl.generate(launcher=launcher, showargs=True)



    pingable, unpingable = rosnode.rosnode_ping_all()
    return supervisor_tpl.generate(path=path,
                          launchers=launchers,
                          nodes_ok=pingable, 
                          nodes_ko=unpingable)

def app(environ, start_response):

    rospy.loginfo("Incoming request!")
    start_response('200 OK', [('Content-Type', 'text/html')])

    path = environ["PATH_INFO"].decode("utf-8")

    options = urlparse.parse_qs(environ["QUERY_STRING"])
    #rospy.loginfo("Options passed:\n%s" % str(options))


    return imap(fixencoding, records(path,options))

if __name__ == '__main__': 
    rospy.loginfo("Starting to serve...")

    WSGIServer(app, bindAddress = ("127.0.0.1", 8080)).run()

    for launcher in launchers:
        launcher.shutdown()

    rospy.loginfo("Bye bye.")

