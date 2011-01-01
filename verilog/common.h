// Common defines for 6502 Verilog
//
// Copyright (c) 2010 Peter Monta

// precision of voltage, current variables is W bits (two's complement);
// definition of `W is from Makefile

// levels for HI and LO

`define HI (`W'd3<<(`W-3))
`define LO (-(`W'd2<<(`W-3)))

`define HI2 (`W'd2<<(`W-4))
`define LO2 (-(`W'd2<<(`W-4)))
