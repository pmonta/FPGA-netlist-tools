# Import the visual6502 netlist files
#
# Copyright (c) 2010 Peter Monta

import re
import string
from netlist import *
from netlist_util import *

#
# transform a nodenames.js name into a valid HDL instance name
#

nodenames = {}

def sanitize(s):
  s = s.replace(r'.',r'_')
  s = s.replace(r'/',r'_')
  s = s.replace(r'+',r'_')
  s = s.replace(r'-',r'_')
  s = s.replace(r'#',r'n')
  s = s.replace(r'(',r'_')
  s = s.replace(r')',r'_')
  s = s.replace(r'~',r'_')
  s = s.replace(r'&',r'_')
  if s[0] in ['0','1','2','3','4','5','6','7','8','9']:
    s = 'n_' + s
  if nodenames.has_key(s):
    return nodenames[s]
  return s

#
# read in the Javascript-format netlists
#

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

def read_transdefs(filename,remove_shorts=True):
  r = []
  f = open(filename,'r')
  for x in f.readlines():
    m = re.match(r".*'(\w+)', (\d+), (\d+), (\d+).*",x)
    if m:
      name = sanitize(m.group(1))
      gate = sanitize(m.group(2))
      source = sanitize(m.group(3))
      drain = sanitize(m.group(4))
      if remove_shorts and source==drain:
        print 'omitting %s, source tied to drain' % name
      else:
        r.append((name,gate,source,drain))
  f.close()
  return r

def read_segdefs(filename):
  pullups = set([])
  r = []
  f = open(filename,'r')
  for x in f.readlines():
    m = re.match(r"\[[ ]*(\d+),'(.)'.*",x)
    if m:
      node = sanitize(m.group(1))
      pullup = m.group(2)
      if pullup=='-' and node in pullups:
        print 'pullup conflict on node %s' % node
      if pullup=='+' and not node in pullups:
        r.append(node)
        pullups.add(node)
  f.close()
  return r

def read_pins(filename):
  r = []
  f = open(filename,'r')
  i = 0
  for x in f.readlines():
    if x=='' or x[0]=='#':
      continue
    m = string.split(x)
    name = m[0]
    ptype = m[1]
    r.append((i,name,ptype))
    i = i + 1
  f.close()
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

def read_netlist_from_javascript(dir,remove_dups=True,remove_shorts=True):
  p = netlist()

  read_nodenames(dir+'/nodenames.js')

  transdefs = read_transdefs(dir+'/transdefs.js',remove_shorts)
  pullups = read_segdefs(dir+'/segdefs.js')
  pins = read_pins(dir+'/pins.txt')

  if remove_dups:
    transdefs = remove_duplicates(transdefs)

  for (name,g,s,d) in transdefs:
    ng = p.add_node(g,'node_analog')
    ns = p.add_node(s,'node_analog')
    nd = p.add_node(d,'node_analog')
    nt = p.add_node(name,'t')
    port = new_name('in')
    link(nt,port,ng,None)
    link(nt,'s',ns,None)
    link(nt,'d',nd,None)
    nt.data['function'] = port

  for name in pullups:
    np = p.add_node(new_name('pullup'),'pullup')
    link(np,'s',p[name],None)

  for (i,name,pin_type) in pins:
    np = p.add_node(new_name('pin'),'pin_'+pin_type)
    link(np,'pin',p[name],None)
    np.data['index'] = i
    np.data['name'] = name

  return p

def read_spice_lines(filename):
  r = []
  f = open(filename,'r')
  header = f.readline()
  for s in f.readlines():
    if not s:
      continue
    if s=='\n':
      continue
    if s[0]=='+':
      continue
    r.append(s)
  return r

def read_netlist_from_spice(filename):
  p = netlist()

  pins = read_pins('pins.txt')

  for t in read_spice_lines(filename):
    v = string.split(t)
    name = v[0]
    if name[0]=='M':
      g,s,d = sanitize(v[2]),sanitize(v[1]),sanitize(v[3])
#      print g,s,d
      if g=='vcc' and s=='vcc' and d=='vcc':
        continue
      if s=='vcc':
        s,d = d,s
      if g=='vcc' and d=='vcc':
        pullup = p.add_node(s,'node_analog')
        np = p.add_node(new_name('pullup'),'pullup')
        link(np,'s',pullup,None)
      else:
        ng = p.add_node(g,'node_analog')
        ns = p.add_node(s,'node_analog')
        nd = p.add_node(d,'node_analog')
        nt = p.add_node('t'+name,'t')
        port = new_name('in')
        link(nt,port,ng,None)
        link(nt,'s',ns,None)
        link(nt,'d',nd,None)
        nt.data['function'] = port
    elif name[0]=='C':
      continue
    else:
      print 'unrecognized spice line: %s' % t

  for (i,name,pin_type) in pins:
    np = p.add_node(new_name('pin'),'pin_'+pin_type)
    link(np,'pin',p[name],None)
    np.data['index'] = i
    np.data['name'] = name

  return p
