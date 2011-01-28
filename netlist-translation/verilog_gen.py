import string

def pin_verilog(s):
  i,name,pin_type = s
  if pin_type=='pin_output':
    return ['  output %s' % name]
  elif pin_type=='pin_input':
    return ['  input %s' % name]
  elif pin_type=='pin_bidirectional':
    return ['  input %s_i' % name,'  output %s_o' % name,'  output %s_t' % name]

# list of Verilog pin strings in their original pins.txt order

def pin_list(p):
  r = []
  for c in p.nodes():
    t = c.ntype()
    if t=='pin_output' or t=='pin_input' or t=='pin_bidirectional':
      r.append((c.data['index'],c.data['name'],t))
  r.sort()
  return reduce(lambda x,y:x+y,map(pin_verilog,r),'')

#
# generate a Verilog model of an analog node
#

def glist(x,s):
  r = []
  for i in xrange(0,s):
    r.append('%s%d'%(x,i))
  return r

def gen(f,s):
  f.write('module spice_node_%d(input eclk,ereset, input signed [`W-1:0] %s, output reg signed [`W-1:0] v);\n' % (s,string.join(glist('i',s),',')))
  f.write('  wire signed [`W-1:0] i = %s;\n' % string.join(glist('i',s),'+'))
  f.write('\n')
  f.write('  always @(posedge eclk)\n')
  f.write('    if (ereset)\n')
  f.write('      v <= 0;\n')
  f.write('    else\n')
  f.write('      v <= v + i;\n')
  f.write('\n')
  f.write('endmodule\n')

def gen0(f):
  f.write('module spice_node_0(input eclk,ereset, output signed [`W-1:0] v);\n')
  f.write('  assign v = 0;\n')
  f.write('endmodule\n')

def nodelist_index(p,n,c):
  x = p.components(n)
  return x.index(c)

def t_function(c,s):
  if type(s)==type(""):
    node = c[s]
    if node.ntype()=='node_analog':
      return 'v(%s_v)' % node
    else:
      return '%s_v' % node
  else:
    op = s[0]
    if op=='and':
      j = '&'
    else:
      j = '|'
    return '(%s)' % string.join(map(lambda x:t_function(c,x),s[1:]),j)

def binarize(n):
  if n.name()=='vss':
    return "1'b0"
  elif n.name()=='vcc':
    return "1'b1"
  elif n.ntype()=='node_analog':
    return 'v(%s_v)' % n.name()
  else:
    return '%s_v' % n.name()

def gen_mux(f,s):
  clk_list = string.join(glist('clk',s),',')
  x_list = string.join(glist('x',s),',')
  f.write('module spice_mux_%d(input eclk,ereset, input %s, input %s, output reg y);\n' % (s,clk_list,x_list))
  for i in xrange(0,s):
    f.write('  wire c%d,z%d;\n' % (i,i));
  f.write('\n');
  f.write('  assign c0 = clk0;\n')
  f.write('  assign z0 = x0;\n')
  f.write('\n');
  for i in xrange(0,s-1):
    f.write('  mux_cascade m%d(c%d, z%d, clk%d, x%d, c%d, z%d);\n' % (i,i,i,i+1,i+1,i+1,i+1))
  f.write('\n');
  f.write('  wire clk = c%d;\n' % (s-1));
  f.write('  wire x = z%d;\n' % (s-1));
  f.write('\n');
  f.write('  always @(posedge eclk)\n');
  f.write('    if (ereset)\n');
  f.write('      y <= 0;\n');
  f.write('    else begin\n');
  f.write('      if (clk)\n');
  f.write('        y <= x;\n');
  f.write('    end\n');
  f.write('\n');
  f.write('endmodule\n');
