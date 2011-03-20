#!/usr/bin/python

import sys
import string
import re

def read_tweaks(filename):
  tlist = []
  f = open(filename,"r")
  for x in f.readlines():
    s = string.split(x)
    tlist.append((s[0],s[1]))
  f.close()
  return tlist

  z = re.compile(r'.*points="(.*)".*')
  t = z.match(s)
  t = t.group(1)
  t = string.replace(t,',',' ')
  r = string.split(t,' ')
  n = len(r)/2
  p = []
  for i in xrange(0,n):
    x = int(r[2*i])
    y = int(r[2*i+1])
    p.append((x,y))
  if s.count('black'):  # 'negative polygon'
    color = 1
  else:
    color = 0
  return p,color


tlist = read_tweaks(sys.argv[1])

x = sys.stdin.read()

for (old,new) in tlist:
  n = x.count(old)
  if n!=1:
    print 'not exactly one instance of ',old
    sys.exit(1)
  x = x.replace(old,new)

sys.stdout.write(x)
