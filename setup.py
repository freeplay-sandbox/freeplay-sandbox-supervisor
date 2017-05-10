#!/usr/bin/env python
 # -*- coding: utf-8 -*-

import os
from distutils.core import setup

def readme():
    with open('README.md') as f:
        return f.read()

setup(name='freeplat_sandbox_supervisor',
      version="0.1.0",
      license='BSD',
      description='Web interface to control the freeplay sandbox experiment',
      long_description=readme(),
      classifiers=[
        'License :: OSI Approved :: BSD License',
        'Programming Language :: Python :: 2.7',
      ],
      author='Séverin Lemaignan',
      author_email='severin.lemaignan@plymouth.ac.uk',
      requires=['flup', 'jinja2','rospy'],
      package_dir = {'': 'nodes'},
      packages=['freeplay_sandbox_supervisor'],
      package_data={'freeplay_sandbox_supervisor': ['tpl/*.tpl']},
      scripts=['nodes/supervisor']
      )
