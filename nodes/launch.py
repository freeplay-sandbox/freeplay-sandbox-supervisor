#!/usr/bin/env python
# -*- coding: UTF-8 -*-


from itertools import imap
from flup.server.fcgi import WSGIServer
import urlparse
from jinja2 import Environment, PackageLoader

import os
import rospy
import rosnode

from rospkg import RosPack

import threading 
import time

import ast

from launcher import Launcher


#rospy.init_node('freeplay_sandbox_supervisor')

package = "freeplay_sandbox"

rp = RosPack()


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

