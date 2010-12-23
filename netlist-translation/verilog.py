import string
from verilog_gen import *
from netlist_util import *

#
# translate a netlist into a Verilog module
#

def print_verilog_spice_netlist(p,filename):
  f = open(filename,"w")

# verilog header

  f.write('`include "common.h"\n')
  f.write('\n')
  f.write('module chip_6502(\n')
  f.write('  input eclk, ereset,\n')

# ports

  f.write(string.join(pin_list(p),',\n'))
  f.write('\n);\n')
  f.write('\n')

# wires

  for c in p.nodes():
    t = c.ntype()
    if t=='node_analog':
      sn = c.name()
      if sn=='vss' or sn=='vcc':
        continue
      wires = []
      for port in c.ports():
        if drives(c[port],c):
          wires.append('%s_%s' % (sn,port))
      wires.append('%s_v' % sn)
      f.write('  wire signed [`W-1:0] %s;\n' % string.join(wires,', '))
  f.write('\n')

# input pins

  for c in p.nodes():
    if c.ntype()=='pin_input':
      n = c['pin']
      port = find_port(n,c)
      f.write('  spice_pin_input %s(%s, %s_v, %s_%s);\n' % (c,c.data['name'],n,n,port))
  f.write('\n')

# output pins

  for c in p.nodes():
    if c.ntype()=='pin_output':
      n = c['pin']
      f.write('  spice_pin_output %s(%s, %s_v);\n' % (c,c.data['name'],n))
  f.write('\n')

# bidirectional pins

  for c in p.nodes():
    if c.ntype()=='pin_bidirectional':
      n = c['pin']
      port = find_port(n,c)
      f.write('  spice_pin_bidirectional %s(%s_i, %s_o, %s_t, %s_v, %s_%s);\n' % (c,c.data['name'],c.data['name'],c.data['name'],n,n,port))
  f.write('\n')

# transistors / transistor series-parallel networks

  for c in p.nodes():
    if c.ntype()=='t':
      s,d = c['s'],c['d']
      if s.name()=='vcc' or d.name()=='vss':
        s,d = d,s
      if d.name()=='vcc':
        v_s = '%s_v' % s.name()
        i_s = '%s_%s' % (s.name(),find_port(s,c))
        f.write('  spice_transistor_nmos_vdd %s(%s, %s, %s);\n' % (c,t_function(c,c.data['function']),v_s,i_s))
      elif s.name()=='vss':
        v_d = '%s_v' % d.name()
        i_d = '%s_%s' % (d.name(),find_port(d,c))
        f.write('  spice_transistor_nmos_gnd %s(%s, %s, %s);\n' % (c,t_function(c,c.data['function']),v_d,i_d))
      else:
        v_s = '%s_v' % s.name()
        i_s = '%s_%s' % (s.name(),find_port(s,c))
        v_d = '%s_v' % d.name()
        i_d = '%s_%s' % (d.name(),find_port(d,c))
        f.write('  spice_transistor_nmos %s(%s, %s, %s, %s, %s);\n' % (c,t_function(c,c.data['function']),v_s,v_d,i_s,i_d))
  f.write('\n')

# pullups

  for c in p.nodes():
    if c.ntype()=='pullup':
      n = c['s']
      i = find_port(n,c)
      f.write('  spice_pullup %s(%s_v, %s_%s);\n' % (c,n,n,i))
  f.write('\n')

# nodes

  node_sizes = set([])

  for n in p.nodes():
    if n.ntype()!='node_analog':
      continue
    sn = n.name()
    if sn=='vss' or sn=='vcc':
      continue
    drivers = []
    for port in n.ports():
      if drives(n[port],n):
        drivers.append(port)
    l = len(drivers)
    node_sizes.add(l)
    f.write('  spice_node_%d n_%s(eclk, ereset, ' % (l,sn))
    for k in drivers:
      f.write('%s_%s,' % (sn,k))
    f.write(' ')
    f.write('%s_v' % sn)
    f.write(');\n')
  f.write('\n')

# footer

  f.write('endmodule\n')
  f.write('\n')

# node modules

  gen0(f)
  f.write('\n')
  node_sizes.remove(0)
  for s in node_sizes:
    gen(f,s)
    f.write('\n')
