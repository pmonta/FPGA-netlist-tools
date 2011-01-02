#!/usr/bin/python

#
# Translate the 6502 netlist into a Verilog model
#
# Copyright (c) 2010 Peter Monta
# November 2010
#

import sys
from netlist_import import *
from verilog import *
from netlist_util import *

#
# main program
#

p = read_netlist_from_javascript(dir='../visual6502')
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

detect_muxes(p)
print_summary(p)

#print_netlist(p,'netlist.txt')
print_verilog_spice_netlist(p,'../verilog/chip_6502.v')
