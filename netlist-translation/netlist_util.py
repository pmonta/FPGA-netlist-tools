#
# Netlist analysis functions
#
# Copyright (c) 2010 Peter Monta
# November 2010
#

from netlist import *
import string

# list of transistors connecting nodes c1 and c2

def find_parallel_transistors(c1,c2):
  r = []
  for c in c1.neighbors():
    if c.ntype()!='t':
      continue
#    print c._name,c._ntype,c._neighbors,c.data
    s,d = c['s'],c['d']
    if (s==c1 and d==c2) or (s==c2 and d==c1):
      r.append(c)
  return r

# find a transistor in series with c through a node

def find_series_transistor(c,node):
  x = node.neighbors()
  if len(x)!=2:
    return None
  if c==x[0]:
    z = x[1]
  else:
    z = x[0]
  if z.ntype()!='t':
    return None
  s,d = z['s'],z['d']
  if node!=s and node!=d:
    return None
  return z

# inputs: all ports except source and drain

def transistor_inputs(c):
  return [(c[p],p) for p in c.ports() if p!='s' and p!='d']

# detect series-parallel transistor networks

def detect_gates(p):
  while 1:
    new = 0
    print "."
    for c in p.nodes():
      if c.ntype()!='t':
        continue
      if not 's' in c.ports():
        continue
      s,d = c['s'],c['d']
      x = set(find_parallel_transistors(s,d))
      if len(x)<=1:
        continue
      new = 1
      gates = []
      function = ['or']
      for cc in x:
        gates = gates + transistor_inputs(cc)
        function = function + [cc.data['function']]
      k = p.add_node(new_name('g'),'t')
      link(s,None,k,'s');
      link(d,None,k,'d');
      for (g,port) in gates:
        link(g,None,k,port)
      k.data['function'] = function
      for cc in x:
        p.remove_node(cc)
    for c in p.nodes():
      if c.ntype()!='t':
        continue
      if not 's' in c.ports():
        continue
      s,d = c['s'],c['d']
      x = find_series_transistor(c,d)
      if not x:
        x = find_series_transistor(c,s)
        s,d = d,s
      if not x:
        continue
      new = 1
      ss,dd = x['s'],x['d']
      if d==dd:
        ss,dd = dd,ss
      gates = []
      function = ['and']
      for cc in [c,x]:
        gates = gates + transistor_inputs(cc)
        function = function + [cc.data['function']]
      k = p.add_node(new_name('g'),'t')
      link(s,None,k,'s')
      link(dd,None,k,'d')
      for (g,port) in gates:
        link(g,None,k,port)
      k.data['function'] = function
      for cc in [c,x]:
        p.remove_node(cc)
      p.remove_node(d)
    if not new:
      break

def find_port(n,c):
  for p in n.ports():
    if n[p]==c:
      return p
  return None

def clean_netlist(p):
  j = 0
  ngnd = p['vss']
  for c in p.nodes():
    if c.ntype()!='t':
      continue
    x = transistor_inputs(c)
    if len(x)!=1:
      continue
    (node,port) = x[0]
    if node==ngnd:
      p.remove_node(c)
      j = j + 1
  print 'removed %d transistors with gate tied to vss' % j

def series_order(g):
  if not type(g)==type([]):
    return 1
  if g[0]=='or':
    x = map(series_order,g[1:])
    return max(x)
  else:
    x = map(series_order,g[1:])
    return sum(x)

def print_gate_stats(p):
  for c in p.nodes():
    if c.ntype()!='t':
      continue
    f = c.data['function']
#    print 'gate_stats',c,f
    j = series_order(f)
    if j>2:
      print j,f

def drives(c,node):
  t = c.ntype()
  if t=='t':
    s,d = c['s'],c['d']
    if node==s or node==d:
      return True
  elif t=='pullup':
    s = c['s']
    if node==s:
      return True
  elif t=='pin_input' or t=='pin_bidirectional':
    s = c['pin']
    if node==s:
      return True
  elif t=='latch':
    s = c['dout']
    if node==s:
      return True
  elif t=='gate':
    s = c['dout']
    if node==s:
      return True
  return False

def all_gates(x,node):
  for c in x:
    if c.ntype()=='t':
      s,d = c['s'],c['d']
      if node==s or node==d:
        return False
    elif c.ntype()=='latch':
      dout = c['dout']
      if node==dout:
        return False
    else:
      return False
  return True

def detect_latches(p):
  for c in p.nodes():
    if c.ntype()!='t':
      continue
    s,d = c['s'],c['d']
    cc = set(s.neighbors())
    cc.remove(c)
    g_s = all_gates(cc,s)
    cc = set(d.neighbors())
    cc.remove(c)
    g_d = all_gates(cc,d)
    if not g_s and not g_d:
      continue
    if g_s and g_d:
      print 'latch %s driven from neither side' % c
      continue
    if g_s:
      l_dout, l_din = s,d
    else:
      l_dout, l_din = d,s
    k = p.add_node(new_name('latch'),'latch')
    link(k,'din',l_din,None)
    link(k,'dout',l_dout,None)
    for (g,port) in transistor_inputs(c):
      link(g,None,k,port)
    k.data['function'] = c.data['function']
    l_dout.set_type('node_digital')
    p.remove_node(c)

def get_pulldown(x,n,gnd):
  pd = None
  for c in x:
    if c.ntype()=='t':
      s,d = c['s'],c['d']
      if d!=n:
        s,d = d,s
      if d==n:
        if pd and s==gnd:
          print 'warning: two distinct pulldown networks'
          return None
        elif s==gnd:
          pd = c
        else:
#          return None
          print 'non-grounded transistor: continuing'
    elif c.ntype()=='latch':
      if c['dout']==n:
        return None
  return pd

def drivers(n):
  r = []
  for c in n.neighbors():
    if drives(c,n):
      r.append(c)
  return r

def driven_by_latch(n):
  d = drivers(n)
  if len(d)==1 and d[0].ntype()=='latch':
    return True
  elif len(d)==1 and d[0].ntype()=='gate':
#    print 'driven by gate'
    return True
  else:
    return False

def is_input(n,c):
  if c.ntype()=='t':
    return not (n==c['s'] or n==c['d'])
  elif c.ntype()=='gate':
    return not n==c['dout']
  else:
    return False

def driven_by(c):
# driven nodes
# all components adjacent to these nodes except c
  if c.ntype()=='t':
    d = set([c['s'],c['d']])
  elif c.ntype()=='gate':
    d = set([c['dout']])
  else:
    d = set([])
  r = []
  for n in d:
    for cc in n.neighbors():
      if is_input(n,cc):
        r.append(cc)
  return r

def next(s):
  r = s
  for x in s:
    r = r | set(driven_by(x))
  return r

def cyclic(n):
  s = next(set([n])) - set([n])
  while 1:
    print '<cyclic>',s
    t = next(s)
    if t==s:
      return False
    if n in t:
      return True
    s = t

def detect_inverters(p):
  gnd = p['vss']
  for c in p.nodes():
    if c.ntype()!='pullup':
      continue

    n = c['s']
    cc = set(n.neighbors())
    cc.remove(c)

    print 'detect_inverters: pulldown',n

    pd = get_pulldown(cc,n,gnd)
    if not pd:
      continue

#    x = transistor_inputs(pd)
#    valid = True
#    for (n0,p0) in x:
#      if not driven_by_latch(n0):
#        valid = False
#    if not valid:
#      continue

    print 'testing pulldown',pd

    if cyclic(pd):
      print pd,'is cyclic'
      continue
    print pd,'is acyclic'

    k = p.add_node(new_name('gate'),'gate')
    link(k,'dout',n,None)
    for (g,port) in transistor_inputs(pd):
      link(g,None,k,port)
    k.data['function'] = pd.data['function']
    n.set_type('node_digital')
    p.remove_node(c)
    p.remove_node(pd)

def expr_nodes(x):
  if type(x)==type(''):
    return [x]
  else:
    r = []
    for e in x[1:]:
      r = r + expr_nodes(e)
    return r

nc = 0

def new_name(prefix):
  global nc
  x = nc
  nc = nc + 1
  return '%s_%d' % (prefix,x)

def print_summary(p):
  hist = {}
  for n in p.nodes():
    t = n.ntype()
    if not hist.has_key(t):
      hist[t] = 1
    else:
      hist[t] = hist[t] + 1
  print hist

def print_netlist(p,filename):
  f = open(filename,"w")
  for c in p.nodes():
    f.write(`c.name(),c.ntype(),c.neighbors(),c.data`+'\n')
  f.close()

def spice_name(s):
  s = s.name()
  if s=='vss':
    return 'GND'
  elif s=='vcc':
    return 'Vdd'
  else:
    return s

def print_spice_netlist(p,filename):
  f = open(filename,"w")
  f.write('* SPICE3 netlist\n')
  f.write('\n')
  i = 0
  for c in p.nodes():
    if c.ntype()!='t':
      continue
    port = c.data['function']
    g = c[port]
    s,d = c['s'],c['d']
    g,s,d = spice_name(g),spice_name(s),spice_name(d)
    f.write('M%d %s %s %s GND efet\n' % (i,s,g,d))
    i = i + 1
  for c in p.nodes():
    if c.ntype()!='pullup':
      continue
    s = c['s']
    s = spice_name(s)
    f.write('M%d %s %s Vdd GND efet\n' % (i,s,s))
    i = i + 1
  f.close()

def detect_muxes(p):
  for n in p.nodes():
    if n.ntype()!='node_analog':
      continue
    sn = n.name()
    if sn=='vss' or sn=='vcc':
      continue
    d = drivers(n)
    s = len(d)
    if s!=2 and s!=3:
      continue
    clk = []
    x = []
    cc = []
    for c in d:
      if c.ntype()!='t':
        continue
      cc.append(c)
      clk.append(c.data['function'])
      if c['s']==n:
        x.append(c['d'])
      else:
        x.append(c['s'])
    if len(clk)!=s:
      print 'size',len(clk)
      continue
# new component: mux.  inputs clk* and x*; output: this node.
    k = p.add_node(new_name('mux'),'mux')
    for c in cc:
      for (g,port) in transistor_inputs(c):
        link(g,None,k,port)
    k.data['functions'] = clk
    for (i,c) in enumerate(x):
      link(c,None,k,'x%d'%i)
    link(n,None,k,'dout')
# change type of this node to digital
    n.set_type('node_digital')
# remove transistors
    for c in d:
      p.remove_node(c)
