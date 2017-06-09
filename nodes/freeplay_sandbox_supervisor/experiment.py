import datetime
import errno
import hashlib

from collections import OrderedDict

import re
import os
import os.path

import rospy

CHILDCHILD="childchild"
CHILDROBOT="childrobot"

BASE_PATH = os.path.join(os.path.expanduser("~"),"freeplay_sandox","data")

def mkdir(path):
    try:
        os.makedirs(path)
    except OSError as exc:  # Python >2.5
        if exc.errno == errno.EEXIST and os.path.isdir(path):
            pass
        else:
            raise

def make_valid_pathname(value):
    """
    Normalizes string, converts to lowercase, removes non-alpha characters,
    and converts spaces to hyphens.

    Based on: http://stackoverflow.com/a/295466/828379
    """
    import unicodedata

    value = unicode(value)
    value = unicodedata.normalize('NFKD', value).encode('ascii', 'ignore')
    value = unicode(re.sub('[^\w\s-]', '', value).strip().lower())
    value = unicode(re.sub('[-\s]+', '-', value))
    return value

class Participant:

    def __init__(self, condition, color):
        now = datetime.datetime.now()
        self.id = "%4d-%02d-%02d-%02d:%02d-%s%d" % (now.year, now.month, now.day, now.hour, now.minute, color, 1 if condition == CHILDCHILD else 2)

    def setdetails(self, age, gender, otherdetails):
        self.age = int(age)
        self.gender = gender
        self.otherdetails = otherdetails

    def __repr__(self):
        return "participant-" + self.id

    def __str__(self):
        desc = "  - id: %s\n  - age: %d\n  - gender: %s\n  - details:\n" % (self.id, self.age, self.gender)
        for k,v in self.otherdetails.items():
            desc += "    - " + k + ": " + v + "\n"
        return desc

class Experiment:

    def __init__(self, cdt):

        self.condition = cdt

        self.date = datetime.datetime.now()
        self.rostime = None

        self.markers = OrderedDict()

        self.path = os.path.join(BASE_PATH, make_valid_pathname(self.date))
        mkdir(self.path)

        os.environ["ROS_LOG_DIR"] = os.path.join(self.path, "logs")

        self.purple = Participant(cdt, 'p')
        self.yellow = Participant(cdt, 'y')

        # used to store extra informations on the experiment that might have been
        # added to the tablet interface
        self.extras = {}

    def save_demographics(self, demographics):


        self.purple.setdetails(demographics["purple-age"][0],
                               demographics["purple-gender"][0],
                               {"tablet-familiarity": demographics["purple-tablet-familiarity"][0]})

        if self.condition == CHILDCHILD:
            self.yellow.setdetails(demographics["yellow-age"][0],
                                   demographics["yellow-gender"][0],
                                   {"tablet-familiarity": demographics["yellow-tablet-familiarity"][0]})

        self.save_experiment_details()

    def save_experiment_details(self):

        with open(os.path.join(self.path, "experiment.yaml"), 'w') as expe:
            expe.write("# Freeplay sandbox experiment -- recorded on the " + str(self.date))
            expe.write("\n")
            expe.write("- timestamp: %s\n" % str(self.rostime))
            expe.write("- condition: %s\n" % self.condition)
            expe.write("- purple-participant:\n" + str(self.purple))
            if self.condition == CHILDCHILD:
                expe.write("- yellow-participant:\n" + str(self.yellow))
            if self.markers:
                expe.write("- markers:\n")
                for mtime, mtype in self.markers.items():
                    expe.write("  - %s: %s\n" % (str(mtime), mtype))
            if self.extras:
                expe.write("- extras:\n")
                for key, value in self.extras.items():
                    expe.write("  - %s: %s\n" % (str(key), str(value)))

    def start(self):

        self.rostime = rospy.Time.now()

    def __hash__(self):
        return hash(str(self.date))

    def __repr__(self):
        return "experiment-" + hashlib.sha1(str(self.date)).hexdigest()

    def add_marker(self, mtype):

        mtime = rospy.Time.now() - self.rostime
        self.markers[str(mtime.to_sec())] = mtype

        self.save_experiment_details()

        return str(mtime.secs)

    def add_extra(self, key, value):

        self.extras[key] = value
        self.save_experiment_details()

