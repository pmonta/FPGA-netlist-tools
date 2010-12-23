# Simple netlist class
#
# Copyright (c) 2010 Peter Monta

#
# Nodes serve as both components (transitors, gates, etc.) and wires.
#

class node:
  def __init__(self,c,ntype):
    self._name = c
    self._ntype = ntype
    self._neighbors = {}
    self.data = {}
    self.p = 0

  def __str__(self):
    return self._name

  def __repr__(self):
    return self._name

  def __getitem__(self, port):
    return self._neighbors[port]

  def add(self,port,n):
    if not port:
      port = 'port_%d' % self.p
      self.p = self.p + 1
    self._neighbors[port] = n

  def remove(self,port):
    del self._neighbors[port]

  def ports(self):
    return self._neighbors.keys()

  def name(self):
    return self._name

  def ntype(self):
    return self._ntype

  def neighbors(self):
    return self._neighbors.values()

  def set_type(self,new_type):
    self._ntype = new_type

#
# A netlist is just a collection of nodes indexed by name
#

class netlist:
  def __init__(self):
    self._nodes = {}

  def add_node(self, c, ntype):
    if self._nodes.has_key(c):
      n = self._nodes[c]
      if n.ntype()!=ntype:
        print 'type conflict when adding node',c,ntype
      return n
    n = node(c,ntype)
    self._nodes[c] = n
    return n

  def remove_node(self, c):
    for n in c.neighbors():
      unlink(n,c)
    del self._nodes[c.name()]

  def nodes(self):
    return self._nodes.values()

  def __getitem__(self, key):
    return self._nodes[key]

  def __contains__(self, item):
    return self._nodes.has_key(item)

#
# Utility functions for nodes and netlists
#

def link(c1, port1, c2, port2):
  c1.add(port1,c2)
  c2.add(port2,c1)

def unlink(c1, c2):
  for p in c1.ports():
    if c1[p]==c2:
      c1.remove(p)
  for p in c2.ports():
    if c2[p]==c1:
      c2.remove(p)
