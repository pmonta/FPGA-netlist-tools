import re
from netlist import *
from util import *

#
# read in the Javascript-format netlists
#

def read_transdefs(filename):
  r = []
  f = open(filename,'r')
  for x in f.readlines():
    m = re.match(r".*'(\w+)', (\d+), (\d+), (\d+).*",x)
    if m:
      name = m.group(1)
      gate = m.group(2)
      source = m.group(3)
      drain = m.group(4)
      if source==drain:
        print 'omitting %s, source tied to drain' % name
      else:
        r.append((name,gate,source,drain))
  return r

def read_nodenames(filename):
  r = []
  f = open(filename,'r')
  for x in f.readlines():
    m = re.match(r"(\w+):[ ]*(\d+),.*",x)
    if m:
      name = m.group(1)
      node = m.group(2)
      r.append((name,node))
    else:
      m = re.match(r'"(.+)":[ ]*(\d+),.*',x)
      if m:
        name = m.group(1)
        node = m.group(2)
        r.append((name,node))
  return r

def read_segdefs(filename):
  r = []
  f = open(filename,'r')
  for x in f.readlines():
    m = re.match(r"\[[ ]*(\d+),'(.)'.*",x)
    if m:
      node = m.group(1)
      pullup = m.group(2)
      r.append((node,pullup))
  return r

def remove_duplicates(transdefs):
  r = []
  td = {}
  duplicates = 0
  for t in transdefs:
    name,g,s,d = t
    if s>d:
      key = (g,s,d)
    else:
      key = (g,d,s)
    if not td.has_key(key):
      r.append(t)
      td[key] = 1
    else:
      duplicates = duplicates + 1
  if duplicates>0:
    print 'removed %d duplicate transistors' % duplicates
  return r

pins = [
('ab0','pin_output'),
('ab1','pin_output'),
('ab2','pin_output'),
('ab3','pin_output'),
('ab4','pin_output'),
('ab5','pin_output'),
('ab6','pin_output'),
('ab7','pin_output'),
('ab8','pin_output'),
('ab9','pin_output'),
('ab10','pin_output'),
('ab11','pin_output'),
('ab12','pin_output'),
('ab13','pin_output'),
('ab14','pin_output'),
('ab15','pin_output'),
('db0','pin_bidirectional'),
('db1','pin_bidirectional'),
('db2','pin_bidirectional'),
('db3','pin_bidirectional'),
('db4','pin_bidirectional'),
('db5','pin_bidirectional'),
('db6','pin_bidirectional'),
('db7','pin_bidirectional'),
('res','pin_input'),
('rw','pin_output'),
('sync','pin_output'),
('so','pin_input'),
('clk0','pin_input'),
('clk1out','pin_output'),
('clk2out','pin_output'),
('rdy','pin_input'),
('nmi','pin_input'),
('irq','pin_input')
]

def read_netlist_from_javascript(dir):
  p = netlist()

  nodenames = read_nodenames(dir+'/nodenames.js')
  transdefs = read_transdefs(dir+'/transdefs.js')
  segdefs = read_segdefs(dir+'/segdefs.js')

  transdefs = remove_duplicates(transdefs)

  for (name,g,s,d) in transdefs:
    p.add_node(g)
    p.add_node(s)
    p.add_node(d)
    p.add_component(name,'t',[g,s,d])

  for (name,node) in nodenames:
    p.set_node_name(node, name)

  pullups = {}
  for (node,pullup) in segdefs:
    if not pullups.has_key(node):
      pullups[node] = pullup
    else:
      if pullup != pullups[node]:
        print 'pullup conflict on node %s' % node

  n_pullups = 0
  for n in pullups.keys():
    if pullups[n]=='+':
      p.add_node(n)
      p.add_component(new_name('p'),'pullup',[n])
      n_pullups = n_pullups + 1

  print 'added %d pullups' % n_pullups

  for (n,ptype) in pins:
    p.add_component('pin_'+n,ptype,[p.name_to_node(n)])

  return p
