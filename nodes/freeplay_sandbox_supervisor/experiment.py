import datetime
import errno
import hashlib

import re
import os
import os.path

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

    def __init__(self, age, gender, otherdetails):
        self.age = int(age)
        self.gender = gender
        self.otherdetails = otherdetails

    def __repr__(self):
        """ Not guaranteed to be unique!
        """
        return "participant-" + "+".join([str(self.age), self.gender])

    def __str__(self):
        desc = "  - age: %d\n  - gender: %s\n  - details:\n" % (self.age, self.gender)
        for k,v in self.otherdetails.items():
            desc += "   - " + k + ": " + v + "\n"
        return desc

class Experiment:

    def __init__(self, demographics):

        print(str(demographics))

        self.condition = demographics["condition"][0]

        self.purple = Participant(demographics["purple-age"][0],
                                  demographics["purple-gender"][0],
                                  {"tablet-familiarity": demographics["purple-tablet-familiarity"][0]})

        self.yellow = None
        if self.condition == CHILDCHILD:
            self.yellow = Participant(demographics["yellow-age"][0],
                                    demographics["yellow-gender"][0],
                                    {"tablet-familiarity": demographics["yellow-tablet-familiarity"][0]})

        self.date = datetime.datetime.now()

        self.path = os.path.join(BASE_PATH, make_valid_pathname(self.date))
        mkdir(self.path)
        self.save_experiment_details()

    def save_experiment_details(self):

        with open(os.path.join(self.path, "experiment.yaml"), 'w') as expe:
            expe.write("# Freeplay sandbox experiment -- recorded on the " + str(self.date))
            expe.write("\n")
            expe.write("- date: %s\n" % str(self.date))
            expe.write("- condition: %s\n" % self.condition)
            expe.write("- purple-participant:\n" + str(self.purple))
            if self.condition == CHILDCHILD:
                expe.write("- yellow-participant:\n" + str(self.yellow))

    def __hash__(self):
        return hash(str(self.date))

    def __repr__(self):
        return "experiment-" + hashlib.sha1(str(self.date)).hexdigest()

