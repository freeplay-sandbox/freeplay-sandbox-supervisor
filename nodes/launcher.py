import rospy

import roslaunch
import roslaunch.xmlloader 
from roslaunch.core import RLException
from roslaunch.config import load_config_default 
from rospkg.common import ResourceNotFound

uuid = roslaunch.rlutil.get_or_generate_uuid(None, False)
roslaunch.configure_logging(uuid)

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

