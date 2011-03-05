#!/usr/bin/python

import sys

for x in sys.stdin.readlines():
  x = x.replace(r'**FLOATING',r';**FLOATING')
  sys.stdout.write(x)
