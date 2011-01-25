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

def draw_polygon(ctx,p,color):
  if color==1:
    ctx.set_source_rgb(1,1,1)
  else:
    ctx.set_source_rgb(0,0,0)
  x,y = p[0]
  ctx.move_to(x,y)
  for x,y in p[1:]:
    ctx.line_to(x,y)
  ctx.close_path()
  ctx.fill()

surface = cairo.ImageSurface(cairo.FORMAT_RGB24, 4000, 4000)

ctx = cairo.Context(surface)
ctx.set_fill_rule(cairo.FILL_RULE_EVEN_ODD)

draw_polygon(ctx,[(0,0),(0,4000),(4000,4000),(4000,0)],1)

for x in sys.stdin.readlines():
  (p,color) = parse_polygon(x)
  draw_polygon(ctx,p,color)

surface.write_to_png("out.png")
