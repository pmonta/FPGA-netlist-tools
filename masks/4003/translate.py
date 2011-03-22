#!/usr/bin/python

#
# Translate the 4003 netlist into a Verilog model
#
# Copyright (c) 2011 Peter Monta
# March 2011
#

import sys
from netlist_import import *
from verilog import *
from netlist_util import *

#
# main program
#

p = read_netlist_from_spice('4003.spice')
print_summary(p)
clean_netlist(p)
print_summary(p)

detect_gates(p)
print_summary(p)
#print_gate_stats(p)

detect_latches(p)
print_summary(p)

detect_inverters(p)
print_summary(p)
detect_inverters(p)
print_summary(p)
detect_inverters(p)
print_summary(p)
detect_inverters(p)
print_summary(p)

#detect_muxes(p)
#print_summary(p)

#print_netlist(p,'netlist.txt')
print_verilog_spice_netlist(p,'../../verilog/chip_4003.v','chip_4003')
