# Generate Verilog models of nodes of various sizes
#
# Copyright (c) 2010 Peter Monta

import string

def glist(x,s):
  r = []
  for i in xrange(0,s):
    r.append('%s%d'%(x,i))
  return r

def gen(s):
  print 'module spice_node_%d(input eclk,ereset, input signed [`W-1:0] %s, output reg signed [`W-1:0] v);' % (s,string.join(glist('i',s),','))
  print '  wire signed [`W-1:0] i = %s;' % string.join(glist('i',s),'+')
  print ''
  print '  always @(posedge eclk)'
  print '    if (ereset)'
  print '      v <= 0;'
  print '    else'
  print '      v <= v + i;'
  print ''
  print 'endmodule'

def gen0():
  print 'module spice_node_0(input eclk,ereset, output signed [`W-1:0] v);'
  print '  assign v = 0;'
  print 'endmodule'

sizes = [1,2,3,4,5,6,7,8,9,10,11,12,13]

print '`include "common.h"'
print ''
gen0()
print ''
for s in sizes:
  gen(s)
  print ''
