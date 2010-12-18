# Simple netlist class
#
# Copyright (c) 2010 Peter Monta

def expr_nodes(x):
  if type(x)==type(''):
    return [x]
  else:
    r = []
    for e in x[1:]:
      r = r + expr_nodes(e)
    return r

class netlist:
  def __init__(self):
    self._components = {}
    self._nodes = {}
    self._ctype = {}
    self._node_to_name = {}
    self._name_to_node = {}

  def add_component(self, c, ctype, node_list):
#    print 'adding component',c,ctype,node_list
    for n in node_list:
      for nn in expr_nodes(n):
        self._components[nn].append(c)
    self._nodes[c] = node_list
    self._ctype[c] = ctype

  def remove_component(self, c):
#    print 'removing component',c
    nodes = self._nodes[c]
    del self._nodes[c]
    del self._ctype[c]
    for n in nodes:
      for nn in expr_nodes(n):
        for (i,cc) in enumerate(self._components[nn]):
          if cc==c:
            del self._components[nn][i]

  def remove_node(self, n):
#    print 'removing node %s' % n
#    print 'components were',self._components[n]
    del self._components[n]

  def component_exists(self, c):
    return self._nodes.has_key(c)

  def add_node(self, node):
    if not self._components.has_key(node):
      self._components[node] = []

  def set_node_name(self, node, name):
    self._node_to_name[node] = name
    self._name_to_node[name] = node

  def name_to_node(self, name):
    return self._name_to_node[name]

  def node_to_name(self, node):
    if self._node_to_name.has_key(node):
      return self._node_to_name[node]
    else:
      return None

  def components(self, n=None):
    if n:
      return self._components[n]
    else:
      return self._nodes.keys()

  def nodes(self, c=None):
    if c:
      return self._nodes[c]
    else:
      return self._components.keys()

  def type(self,c):
    return self._ctype[c]
