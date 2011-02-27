#!/usr/bin/python

#
# netlist_to_verilog.py <netlist.txt >netlist.v
#
# Convert a transistor netlist to a Verilog module.  Detects two-phase latches and NOR gates.
#
# Peter Monta
# November 2010
#

import sys
import string

d_components = {}
d_nodes = {}
d_ctype = {}

def add(c,ctype,nodes):
  for n in nodes:
    if d_components.has_key(n):
      d_components[n].append(c)
    else:
      d_components[n] = [c]
  d_nodes[c] = nodes
  d_ctype[c] = ctype

def remove(c):
  nodes = d_nodes[c]
  del d_nodes[c]
  del d_ctype[c]
  for n in nodes:
    for (i,cc) in enumerate(d_components[n]):
      if cc==c:
        del d_components[n][i]

def add_node(n):
  d_components[n] = []

nc = 0
def new_name(prefix):
  global nc
  x = nc
  nc = nc + 1
  return '%s_%d' % (prefix,x)

def coalesce_contacts(pin_names):
  for c in d_nodes.keys():
    if d_ctype[c]=='c':
      old1,old2 = d_nodes[c]
      if old1==old2:
        print 'circular contact',old1
        continue
      if old1 in pin_names and old2 in pin_names:
        print 'pins %s and %s conflict: they are the same node' % (old1,old2)
      if old1 in pin_names:
        new = old1
      elif old2 in pin_names:
        new = old2
      else:
        new = new_name('n')
      c1,c2 = d_components[old1],d_components[old2]
      del d_components[old1]
      del d_components[old2]
      del d_nodes[c]
      del d_ctype[c]
      d_components[new] = []
      for r in c1+c2:
        if r==c:
          continue
        if not r in d_components[new]:
          d_components[new].append(r)
        for index,item in enumerate(d_nodes[r]):
          if item==old1 or item==old2:
            d_nodes[r][index] = new

def coalesce_pins():
  pin_names = []
  for c in d_nodes.keys():
    if d_ctype[c]=='p':
      new,old = d_nodes[c]
      pin_names.append(new)
      c1 = d_components[old]
      del d_components[old]
      del d_nodes[c]
      del d_ctype[c]
      d_components[new] = []
      for r in c1:
        if r==c:
          continue
        if not r in d_components[new]:
          d_components[new].append(r)
        for index,item in enumerate(d_nodes[r]):
          if item==old:
            d_nodes[r][index] = new
  return pin_names

def alias(old,new):
  c1 = d_components[old]
  del d_components[old]
  d_components[new] = list(set(d_components[new]+c1))
  for r in c1:
    for index,item in enumerate(d_nodes[r]):
      if item==old:
        d_nodes[r][index] = new

def detect_pullups():
  for c in d_nodes.keys():
    if d_ctype[c]!='t':
      continue
    x = d_nodes[c]
    if (x[0]==x[1] and x[2]=='Vdd') or (x[0]==x[2] and x[1]=='Vdd'):
      remove(c)
      add(new_name('r'),'pullup',[x[0]])

def list_components_with_node(n):
  r = []
  for c in d_nodes.keys():
    if n in d_nodes[c]:
      r.append(c)
  return r

def find_unique_component(type,node):
  r = []
  for c in d_nodes.keys():
    if d_ctype[c]!=type:
      continue
    if node in d_nodes[c]:
      r.append(c)
  if len(r)==1:
    return r[0]
  return None

def find_components(type,node):
  r = []
  for c in d_nodes.keys():
    if d_ctype[c]!=type:
      continue
    if node in d_nodes[c]:
      r.append(c)
  return r

def find_t_drain(gate_node,node):
  r = []
  for c in d_nodes.keys():
    if d_ctype[c]!='t':
      continue
    (gate,source,drain) = d_nodes[c]
    if gate!=gate_node:
      continue
    if source==node or drain==node:
      r.append(c)
  if len(r)==1:
    return r[0]
  return None

def find_sd_components(node):
  r = []
  for c in d_nodes.keys():
    if d_ctype[c]!='t':
      continue
    (gate,source,drain) = d_nodes[c]
    if source==node or drain==node:
      r.append(c)
  return r

def detect_latches():
  for c in d_nodes.keys():
    if not d_ctype.has_key(c):
      continue

    if d_ctype[c]!='t':
      continue
    (gate,source,drain) = d_nodes[c]

    the_pulldown = c

    if drain=='Vss':
      source,drain = drain,source
    inverter_node = drain

    the_pullup = find_unique_component('pullup',inverter_node)
    if not the_pullup:
      continue

    the_phi2 = find_t_drain('phi2',inverter_node)
    if not the_phi2:
      continue

    the_phi1 = find_t_drain('phi1',gate)
    if not the_phi1:
      continue

    (g,s,d) = d_nodes[the_phi1]
    if s==gate:
      s,d = d,s
    input_node = s

    (g,s,d) = d_nodes[the_phi2]
    if s==inverter_node:
      s,d = d,s
    output_node = s

    remove(the_phi1)
    remove(the_phi2)
    remove(the_pullup)
    remove(the_pulldown)
    add(new_name('latch'),'latch',[output_node,input_node])

def detect_gates():
  for c in d_nodes.keys():
    if not d_ctype.has_key(c):
      continue

    if d_ctype[c]!='pullup':
      continue
    node = d_nodes[c][0]

    x = find_sd_components(node)
    gates = []
    for cc in x:
      (g,s,d) = d_nodes[cc]
      gates.append(g)

    add(new_name('g'),'nor',[node]+gates)
    for old_c in x:
      remove(old_c)
    remove(c)

def print_netlist():
  print 'components with node lists and type:'
  for c in d_nodes.keys():
    print c,d_nodes[c],d_ctype[c]
  print 'nodes with component lists:'
  for c in d_components.keys():
    print c,d_components[c]

def print_nor(c,nodes):
  if len(nodes)==2:
    print '  assign %s = ~%s;' % (nodes[0],nodes[1])
  else:
    print '  assign %s = ~(%s);'  % (nodes[0],string.join(nodes[1:],' | '))

def print_latch(c,nodes):
  n_out,n_in = nodes[0],nodes[1]
  print '    %s <= %s;' % (n_out,n_in)

def pretty_print(x,prefix):
  per_line = 8
  for i in xrange(0,int(len(x)/per_line)):
    print '  %s %s;' % (prefix,string.join(x[per_line*i:per_line*(i+1)],','))

def print_wires_and_regs():
  wires = set([])
  regs = set([])
  for c in d_nodes.keys():
    if d_ctype[c]=='latch':
      nodes = d_nodes[c]
      n_out,n_in = nodes[0],nodes[1]
      wires.add(n_in)
      regs.add(n_out)
    elif d_ctype[c]=='nor':
      nodes = d_nodes[c]
      wires.add(nodes[0])
  pretty_print(list(wires),'wire');
  print ''
  pretty_print(list(regs),'reg');
  print ''

def print_verilog_netlist():
  print 'module hp35_rom_control1(input clk, input sync, output x0,x1,y0,y1,z0,z1,z2,z3,z4);'
  print ''
  print_wires_and_regs()
  for c in d_nodes.keys():
    if d_ctype[c]=='nor':
      print_nor(c,d_nodes[c])
  print ''
  print '  always @(posedge clk) begin'
  for c in d_nodes.keys():
    if d_ctype[c]=='latch':
      print_latch(c,d_nodes[c])
  print '  end'
  print 'endmodule'

#
# main program
#

for x in sys.stdin.readlines():
  y = string.split(x)
  if not y:
    continue
  if y[0]=='p' or y[0]=='c':
    add(new_name(y[0]),y[0],[y[1],y[2]])
  elif y[0]=='t':
    add(new_name(y[0]),'t',[y[1],y[2],y[3]])

pin_names = coalesce_pins()
coalesce_contacts(pin_names)
add_node('Vdd')
alias('Gnd','Vdd')
alias('Gnd2','Vdd')

detect_pullups()
detect_latches()
detect_gates()

print_verilog_netlist()
