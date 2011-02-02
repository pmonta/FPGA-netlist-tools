#!/usr/bin/python

import sys

def print_polygon(g):
  x1,x2,y1,y2 = g
  x1 = (4*x1/10) + 160
  x2 = (4*x2/10) + 160
  y1 = (4*(10000-y1)/10)
  y2 = (4*(10000-y2)/10)
  if x1>x2:
    x1,x2 = x2,x1
  if y1>y2:
    y1,y2 = y2,y1
  x1,x2 = x1-2 , x2+2
  y1,y2 = y1-2 , y2+2
  print '<polygon points="%d,%d %d,%d %d,%d %d,%d" />' % (x1,y1,x2,y1,x2,y2,x1,y2)

for p in sys.stdin.readlines():
  if p[0]!='[':
    continue
  p = eval(p[:-3])
  gate = p[4]
  print_polygon(gate)
