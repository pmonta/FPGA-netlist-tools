#!/usr/bin/python

#
# analyze.py <directory containing javascript netlist files>
#
# Analyze the 6502 netlist
#
# Peter Monta
# November 2010
#

import sys
from netlist_javascript import *
from util import *

def find_parallel_components(p,c1,c2):
  r = []
  for c in p.components(c1):
    if p.type(c)!='t':
      continue
    (gate,source,drain) = p.nodes(c)
    if (source==c1 and drain==c2) or (source==c2 and drain==c1):
      r.append(c)
  return r

def find_series_component(p,c,node):
  x = p.components(node)
  if len(x)!=2:
    return None
  if c==x[0]:
    z = x[1]
  else:
    z = x[0]
  if p.type(z)!='t':
    return None
  (g,s,d) = p.nodes(z)
  if node!=s and node!=d:
    return None
  return z

def detect_gates(p):
  while 1:
    new = 0
    for c in p.components():
      if not p.component_exists(c):
        continue
      if p.type(c)!='t':
        continue
      (g,s,d) = p.nodes(c)
      x = set(find_parallel_components(p,s,d))
      if len(x)>1:
        new = 1
        gates = ['or']
        for cc in x:
          (g,s,d) = p.nodes(cc)
          gates.append(g)
        p.add_component(new_name('g'),'t',(tuple(gates),s,d))
        for cc in x:
          p.remove_component(cc)
    for c in p.components():
      if not p.component_exists(c):
        continue
      if p.type(c)!='t':
        continue
      (g,s,d) = p.nodes(c)
      x = find_series_component(p,c,d)
      if not x:
        x = find_series_component(p,c,s)
        s,d = d,s
      if x:
        new = 1
        (gg,ss,dd) = p.nodes(x)
        if d==dd:
          ss,dd = dd,ss
        gates = ['and',g,gg]
        p.remove_component(c)
        p.remove_component(x)
        p.remove_node(d)
        p.add_component(new_name('g'),'t',(tuple(gates),s,dd))
    if not new:
      break

def clean_netlist(p):
  j = 0
  ngnd = p.name_to_node('vss')
  for c in p.components():
    if p.type(c)=='t':
      (g,s,d) = p.nodes(c)
      if g==ngnd:
        p.remove_component(c)
        j = j + 1
  print 'removed %d transistors with gate tied to vss' % j

#
# main program
#

p = read_netlist_from_javascript(dir=sys.argv[1])
clean_netlist(p)
print_summary(p)

detect_gates(p)
print_summary(p)

print_verilog_spice_netlist(p,'chip_6502.v')
