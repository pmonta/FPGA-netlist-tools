# Netlist utilities, including Verilog generation
#
# Copyright (c) 2010 Peter Monta

import string

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
  n_trans = 0
  n_pullup = 0
  for c in p.components():
    t = p.type(c)
    if t=='t':
      n_trans = n_trans + 1
    elif t=='pullup':
      n_pullup = n_pullup + 1
  print '%d transistors, %d pullups, %d nodes' % (n_trans,n_pullup,len(p.nodes()))

def sanitize(s):
  s = s.replace(r'.',r'_')
  s = s.replace(r'/',r'_')
  s = s.replace(r'+',r'_')
  s = s.replace(r'-',r'_')
  s = s.replace(r'#',r'_')
  s = s.replace(r'(',r'_')
  s = s.replace(r')',r'_')
  if s[0] in ['0','1','2','3','4','5','6','7','8','9']:
    s = 'n_' + s
  return s

def name(p,n):
  r = p.node_to_name(n)
  if r:
    return sanitize(r)
  else:
    return 'n%s' % n

def print_netlist(p,filename):
  f = open(filename,"w")
  f.write('### components with node lists and type:\n')
  for c in p.components():
#    f.write('%s %s' % (c,`map(lambda n:name(p,n),p.nodes(c)),p.type(c)`))
    f.write('%s %s' % (c,`p.nodes(c),p.type(c)`))
    f.write('\n')
  f.write('### nodes with component lists:\n')
  for n in p.nodes():
    f.write('%s %s' % (name(p,n),`p.components(n)`))
    f.write('\n')

def nodelist_index(p,n,c):
  x = p.components(n)
  return x.index(c)

def t_function(p,g):
  if type(g)==type(""):
    return '~%s_v[`W-1]' % name(p,g)
  else:
    op = g[0]
    if op=='and':
      j = '&'
    else:
      j = '|'
    return '(%s)' % string.join(map(lambda x:t_function(p,x),g[1:]),j)

def print_verilog_spice_netlist(p,filename):
  f = open(filename,"w")

# verilog header

  f.write('`include "common.h"\n')
  f.write('\n')
  f.write('module chip_6502(\n')
  f.write('  input eclk, ereset,\n')

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

  for (i,(c,ptype)) in enumerate(pins):
    end = ',' if i!=len(pins)-1 else ''
    if ptype=='pin_output':
      f.write('  output %s%s\n' % (c,end))
    elif ptype=='pin_input':
      f.write('  input %s%s\n' % (c,end))
    elif ptype=='pin_bidirectional':
      f.write('  input %s_i,\n' % c)
      f.write('  output %s_o,\n' % c)
      f.write('  output %s_t%s\n' % (c,end))
  f.write(');\n')
  f.write('\n')

# wires

  for n in p.nodes():
    sn = name(p,n)
    if sn=='vss' or sn=='vcc':
      continue
    for (i,c) in enumerate(p.components(n)):
      f.write('  wire signed [`W-1:0] %s_i%d;\n' % (name(p,n),i))
    f.write('  wire signed [`W-1:0] %s_v;\n' % name(p,n))
  f.write('\n')

# input pins

  for c in p.components():
    if p.type(c)=='pin_input':
      n = p.nodes(c)
#      print c,n
      n = n[0]
#      print c,n
      i = nodelist_index(p,n,c)
      f.write('  spice_pin_input %s(%s, %s_v, %s_i%d);\n' % (c,name(p,n),name(p,n),name(p,n),i))
  f.write('\n')

# output pins

  for c in p.components():
    if p.type(c)=='pin_output':
      n = p.nodes(c)
      n = n[0]
      i = nodelist_index(p,n,c)
      f.write('  spice_pin_output %s(%s, %s_v, %s_i%d);\n' % (c,name(p,n),name(p,n),name(p,n),i))
  f.write('\n')

# bidirectional pins

  for c in p.components():
    if p.type(c)=='pin_bidirectional':
      n = p.nodes(c)
      n = n[0]
      i = nodelist_index(p,n,c)
      f.write('  spice_pin_bidirectional %s(%s_i, %s_o, %s_t, %s_v, %s_i%d);\n' % (c,name(p,n),name(p,n),name(p,n),name(p,n),name(p,n),i))
  f.write('\n')

# transistors / transistor networks

  for c in p.components():
    if p.type(c)=='t':
      (g,s,d) = p.nodes(c)
      if name(p,s)=='vcc' or name(p,d)=='vss':
        s,d = d,s
      if name(p,d)=='vcc':
        v_s = '%s_v' % name(p,s)
        i_s = '%s_i%d' % (name(p,s),nodelist_index(p,s,c))
        f.write('  spice_transistor_nmos_vdd %s(%s, %s, %s);\n' % (c,t_function(p,g),v_s,i_s))
      elif name(p,s)=='vss':
        v_d = '%s_v' % name(p,d)
        i_d = '%s_i%d' % (name(p,d),nodelist_index(p,d,c))
        f.write('  spice_transistor_nmos_gnd %s(%s, %s, %s);\n' % (c,t_function(p,g),v_d,i_d))
      else:
        v_s = '%s_v' % name(p,s)
        i_s = '%s_i%d' % (name(p,s),nodelist_index(p,s,c))
        v_d = '%s_v' % name(p,d)
        i_d = '%s_i%d' % (name(p,d),nodelist_index(p,d,c))
        f.write('  spice_transistor_nmos %s(%s, %s, %s, %s, %s);\n' % (c,t_function(p,g),v_s,v_d,i_s,i_d))
  f.write('\n')

# pullups

  for c in p.components():
    if p.type(c)=='pullup':
      n = p.nodes(c)
      n = n[0]
      i = nodelist_index(p,n,c)
      f.write('  spice_pullup %s(%s_v, %s_i%d);\n' % (c,name(p,n),name(p,n),i))
  f.write('\n')

# nodes

  for n in p.nodes():
    sn = name(p,n)
    if sn=='vss' or sn=='vcc':
      continue
    x = p.components(n)
    l = len(x)
    ports = []
    for i in xrange(0,l):
      if p.type(x[i])=='t':
        (g,s,d) = p.nodes(x[i])
#        if g!=n:
        if not n in expr_nodes(g):
          ports.append(i)
      else:
        ports.append(i)
    f.write('  spice_node_%d n_%s(eclk, ereset, ' % (len(ports),name(p,n)))
    for k in ports:
      f.write('%s_i%d,' % (name(p,n),k))
    f.write(' ')
    f.write('%s_v' % name(p,n))
    f.write(');\n')
  f.write('\n')

# footer

  f.write('endmodule\n')
