#!/usr/bin/python

import sys
import string

translate_layer = { '1':'NM', '2':'NP', '3':'ND' }

for x in sys.stdin.readlines():
  if x[-1]=='\n':
    x = x[:-1]
  if x[-1]=='\r':
    x = x[:-1]
  if x[0]==';':
    continue
  r = string.split(x,',')
  layer,x,y,name = r[0],int(r[1]),int(r[2]),r[3]
  layer = translate_layer[layer]
  print '%s %d %d %s' % (name,x,y,layer)
