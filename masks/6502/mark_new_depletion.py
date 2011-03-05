#!/usr/bin/python

import sys
import string
import re

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

def dep_nodes():
  r = []
  f = open("dep")
  for x in f.readlines():
    x = string.split(x)
    node = x[1]
    node = node[1:]
    node = sanitize(node)
    r.append(node)
  f.close()
  return r

read_nodenames("../../visual6502/nodenames.js")
deps = dep_nodes()

for x in sys.stdin.readlines():
  if x[0]=='M':
    y = string.split(x)
    g,s,d = y[2],y[1],y[3]
    if d!='Vdd':
      s,d = d,s
    if d=='Vdd' and s in deps:
      x = x.replace('efet','dfet')
  sys.stdout.write(x)
