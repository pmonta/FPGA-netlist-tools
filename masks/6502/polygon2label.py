#!/usr/bin/python

import re
import string
#import cairo

subs = {'vcc':'Vdd!', 'vss':'GND!'}

nodenames = {}

def sanitize(s):
  s = s.replace(r'.',r'_')
  s = s.replace(r'/',r'_')
  s = s.replace(r'+',r'_')
  s = s.replace(r'-',r'_')
  s = s.replace(r'#',r'n')
  s = s.replace(r'(',r'_')
  s = s.replace(r')',r'_')
  if s[0] in ['0','1','2','3','4','5','6','7','8','9']:
    s = 'n_' + s
  if nodenames.has_key(s):
    s = nodenames[s]
  if subs.has_key(s):
    s = subs[s]
  return s

def read_nodenames(filename):
  r = []
  f = open(filename,'r')
  for x in f.readlines():
    m = re.match(r"(\w+):[ ]*(\d+),.*",x)
    if not m:
      m = re.match(r'"(.+)":[ ]*(\d+),.*',x)
    if m:
      name = sanitize(m.group(1))
      node = sanitize(m.group(2))
      if name[0]=='t':
        name = '_'+name
      nodenames[node] = name
  f.close()

def interior_point(p):
  return p[0]

def parse_polygon(t):
  t = string.replace(t,',',' ')
  r = string.split(t,' ')
  n = len(r)/2
  p = []
  for i in xrange(0,n):
    x = int(r[2*i])
    y = int(r[2*i+1])
    p.append((x,y))
  return p

def print_label(p,name,layer):
  (x,y) = p
  print '%s %d %d %s' % (name,x,y,layer)

import sys

read_nodenames("../../visual6502/nodenames.js")

n = set([])

for m in re.finditer(r'<polygon points="([^"]*)"><desc>([0-9]*)</desc></polygon>',sys.stdin.read()):
  p = m.group(1)
  node = sanitize(m.group(2))
  if node not in n:
    n.add(node)
    print_label(interior_point(parse_polygon(p)),node,"ND")
