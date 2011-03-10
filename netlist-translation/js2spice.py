#!/usr/bin/python

from netlist_import import *
from netlist_util import *

p = read_netlist_from_javascript(dir='../visual6502',remove_dups=False,remove_shorts=False)
print_spice_netlist(p,'6502-from-javascript.spice')
