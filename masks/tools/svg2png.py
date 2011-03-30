#!/usr/bin/python

import sys
import cairo
import string
import re

def parse_path_list(t):
  x,y = 0,0
  p = []
  state = 'moveto'
  for term in string.split(t):
    if term=='z':
      p.append(('fill',))
    elif term=='l':
      state = 'lineto'
    elif term=='M':
      x,y = 0,0
      state = 'moveto'
    elif term=='m':
      state = 'moveto'
    else:
      dxy = string.split(term,',')
      dx,dy = float(dxy[0]),float(dxy[1])
      x = x + dx
      y = y + dy
      p.append((state,x,y))
      state = 'lineto'
  return p

def parse_point_list(t):
  t = string.replace(t,',',' ')
  r = string.split(t,' ')
  n = len(r)/2
  p = []
  for i in xrange(0,n):
    x = float(r[2*i])
    y = float(r[2*i+1])
    p.append((x,y))
  return p

def parse_polygon(s):
  z = re.compile(r'<polygon.*?points="(.*?)"',re.DOTALL)
  t = z.search(s)
  if not t:
    return None
  t = t.group(1)
  return parse_point_list(t)

def parse_path(s):
  z = re.compile(r'<path.*?d="(.*?)"',re.DOTALL)
  t = z.search(s)
  if not t:
    return None
  t = t.group(1)
  return parse_path_list(t)

def parse_rect(s):  
  z = re.compile(r'<rect.*?width="(.*?)".*?height="(.*?)".*?x="(.*?)".*?y="(.*?)"',re.DOTALL)
  t = z.search(s)
  if not t:
    return None
  width,height,x,y = float(t.group(1)),float(t.group(2)),float(t.group(3)),float(t.group(4))
  return [(x,y),(x+width,y),(x+width,y+height),(x,y+height)]

def parse_contact(s):  
  z = re.compile(r'<use.*?x="(.*?)".*?y="(.*?)".*?width="(.*?)".*?height="(.*?)"',re.DOTALL)
  t = z.search(s)
  if not t:
    return None
  width,height,x,y = float(t.group(3)),float(t.group(4)),float(t.group(1)),float(t.group(2))
  return [(x,y),(x+width,y),(x+width,y+height),(x,y+height)]

def draw_path(ctx,p,color,scale=1.0):
  if color==1:
    ctx.set_source_rgb(1,1,1)
  else:
    ctx.set_source_rgb(0,0,0)
  for t in p:
    if t[0]=='fill':
      ctx.close_path()
    elif t[0]=='moveto':
      ctx.move_to(scale*t[1],scale*t[2])
    elif t[0]=='lineto':
      ctx.line_to(scale*t[1],scale*t[2])
    else:
      print 'unknown path term: '+t
  ctx.fill()

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

#
# main program
#

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

draw_polygon(ctx,[(0,0),(0,Y),(X,Y),(X,0)],1)

for y in re.finditer(r'.*<[^>]*>',sys.stdin.read()):
  y = y.group(0)
  p = parse_polygon(y)
  if p:
    draw_polygon(ctx,p,0,scale)
  else:
    p = parse_rect(y)
    if p:
      draw_polygon(ctx,p,0,scale)
    else:
      p = parse_contact(y)
      if p:
        draw_polygon(ctx,p,0,scale)
      else:
        p = parse_path(y)
        if p:
          draw_path(ctx,p,0,scale)
        else:
          print 'unknown element type: '+y

surface.write_to_png("out.png")
