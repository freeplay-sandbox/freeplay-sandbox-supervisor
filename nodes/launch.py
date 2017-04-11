#!/usr/bin/env python
# -*- coding: UTF-8 -*-

import logging; logger = logging.getLogger("main")
FORMAT = '%(asctime)s - %(levelname)s: %(message)s'
logging.basicConfig(format=FORMAT, level=logging.DEBUG)

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

        self.args = loader.root_context.resolve_dict.get('arg_doc', {}) 

    def start(self):

        if self.reachable:
            self.launcher.start()

launchers = []

for root, dirs, files in os.walk(rp.get_path(package)):
    for file in files:
        if file.endswith(".launch"):
             launchers.append(Launcher(os.path.join(root, file)))


env = Environment(loader=PackageLoader('freeplay_sandbox_supervisor', 'tpl'))
tpl = env.get_template('supervisor.tpl')

def fixencoding(s):
    return s.encode("utf-8")

def process_launch(options):
    launchfile = options["launch"][0]

    launcher = None
    for l in launchers:
        if l.name == launchfile:
            launcher = l
            break
    if launcher is None:
        logger.warning("Attempting to launch inexistant %s" % launchfile)
        return False

    logger.info("Attempting to launch %s" % launcher.launchfile)

    launcher.start()

def records(path, options):

    if "launch" in options:
        return process_launch(options)



    pingable, unpingable = rosnode.rosnode_ping_all()
    return tpl.generate(path=path,
                        launchers=launchers,
                        nodes_ok=pingable, 
                        nodes_ko=unpingable)

def app(environ, start_response):

    logger.info("Incoming request!")
    start_response('200 OK', [('Content-Type', 'text/html')])

    path = environ["PATH_INFO"].decode("utf-8")

    options = urlparse.parse_qs(environ["QUERY_STRING"])


    return imap(fixencoding, records(path,options))

if __name__ == '__main__': 
    logger.info("Starting to serve...")

    WSGIServer(app, bindAddress = ("127.0.0.1", 8080)).run()

    for launcher in launchers:
        launcher.shutdown()

    logger.info("Bye bye.")

