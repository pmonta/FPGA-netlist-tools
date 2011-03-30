#!/usr/bin/python

import sys
import string

d = {}

for x in sys.stdin.readlines():
  if x[0]=='+':
    pass
  elif x[0]=='C':
    pass
  elif x[0]!='M':
    sys.stdout.write(x)
  else:
    r = string.split(x)
#    if r[2]==r[1] or r[2]==r[3]:
#      continue
    if r[1]==r[3]:
#      print 'cap',r[1]
      continue
    if d.has_key((r[1],r[2],r[3])) or d.has_key((r[3],r[2],r[1])):
      continue
    d[(r[1],r[2],r[3])] = 1
    x = string.replace(x,'Vdd','vcc')
    x = string.replace(x,'GND','vss')
    sys.stdout.write(x)
