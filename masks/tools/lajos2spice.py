#!/usr/bin/python

import sys
import string

print "* SPICE3 converted from Lajos's format"
print ''

i = 0

for x in sys.stdin.readlines():
  r = string.split(x,',')
  if r[0]=='T':
    g = r[4]
    s = r[5]
    d = r[6]
    print 'M%d %s %s %s GND efet' % (i,s,g,d)
    i = i + 1
  elif r[0]=='R':
    g = r[4]
    s = r[4]
    d = r[5]
    print 'M%d %s %s %s GND efet' % (i,s,g,d)
    i = i + 1
  elif r[0]=='C':
    pass
  else:
    print 'unknown component %s' % r[0]
