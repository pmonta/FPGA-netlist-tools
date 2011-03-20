#!/usr/bin/python

import sys
import cairo
import string
import re

def parse_polygon(s):
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

def draw_polygon(ctx,p,color,scale=1.0):
  if color==1:
    ctx.set_source_rgb(1,1,1)
  else:
    ctx.set_source_rgb(0,0,0)
  x,y = p[0]
  ctx.move_to(scale*x,scale*y)
  for x,y in p[1:]:
    ctx.line_to(scale*x,scale*y)
  ctx.close_path()
  ctx.fill()

X,Y = sys.argv[1],sys.argv[2]
X,Y = int(X),int(Y)
try:
  scale = sys.argv[3]
  scale = float(scale)
except:
  scale = 1.0

surface = cairo.ImageSurface(cairo.FORMAT_RGB24, X, Y)

ctx = cairo.Context(surface)
ctx.set_fill_rule(cairo.FILL_RULE_EVEN_ODD)

draw_polygon(ctx,[(0,0),(0,X),(Y,X),(Y,0)],1)

lines = sys.stdin.readlines()

for x in lines:
  (p,color) = parse_polygon(x)
  if color==0:
    draw_polygon(ctx,p,color,scale)

for x in lines:
  (p,color) = parse_polygon(x)
  if color==1:
    draw_polygon(ctx,p,color,scale)

surface.write_to_png("out.png")
