// Models for transistors and nodes
//
// Copyright (c) 2010 Peter Monta

`include "common.h"

module spice_pin_input(input p, input signed [`W-1:0] v, output signed [`W-1:0] i);
  wire [`W-1:0] vp = p ? `HI : `LO;
  wire [`W:0] dv = {vp[`W-1],vp} - {v[`W-1],v};
  assign i = {{2{dv[`W]}},dv[`W:3]};
endmodule

module spice_pin_output(output p, input signed [`W-1:0] v);
  assign p = ~v[`W-1];
endmodule

module spice_pin_bidirectional(input p_i, output p_o, output p_t, input signed [`W-1:0] v, output signed [`W-1:0] i);
  assign p_o = ~v[`W-1];
  wire [`W-1:0] vp = p_i ? `HI : `LO;
  wire [`W:0] dv = {vp[`W-1],vp} - {v[`W-1],v};
  assign i = {{3{dv[`W]}},dv[`W:4]};
  assign p_t = 0; //fixme
endmodule

module spice_transistor_nmos(input g, input signed [`W-1:0] vs,vd, output signed [`W-1:0] is,id);
  wire signed [`W:0] vsd = {vd[`W-1],vd} - {vs[`W-1],vs};
  wire signed [`W-1:0] isd = {vsd[`W],vsd[`W:2]};
  wire signed [`W-1:0] i = g ? isd : 0;
  assign is = i;
  assign id = -i;
endmodule

module spice_transistor_nmos_vdd(input g, input signed [`W-1:0] vs, output signed [`W-1:0] is);
  wire signed [`W-1:0] vd = `HI;
  wire signed [`W:0] vsd = {vd[`W-1],vd} - {vs[`W-1],vs};
  wire signed [`W-1:0] isd = {{2{vsd[`W]}},vsd[`W:3]}; // heuristic for 6502: transistors that connect to vdd should be weaker
  assign is = g ? isd : `W'd0;
endmodule

module spice_transistor_nmos_gnd(input g, input signed [`W-1:0] vd, output signed [`W-1:0] id);
  wire signed [2:0] lo = 3'b110;
  wire signed [2:0] vdtop = lo - {vd[`W-1],vd[`W-1:`W-2]};
  wire signed [`W:0] vsd = {vdtop,~vd[`W-3:0]};
  wire signed [`W-1:0] i = {vsd[`W],vsd[`W:2]};
  assign id = g ? i : `W'd0;
endmodule

module spice_pullup(input signed [`W-1:0] v, output signed [`W-1:0] i);
//  wire signed [2:0] hi = 3'b000;
//  wire signed [2:0] vdtop = hi - {v[`W-1],v[`W-1:`W-2]};
//  wire signed [`W:0] dv = {vdtop,~v[`W-3:0]};
  wire signed [`W-1:0] hi = `HI;
  wire signed [`W:0] dv = {hi[`W-1],hi} - {v[`W-1],v};
  assign i = {{3{dv[`W]}},dv[`W:4]};
endmodule

module spice_latch(input eclk,ereset, input g, input in, output reg out);

  always @(posedge eclk)
    if (ereset) begin
      out <= 0;
    end else begin
      if (g)
        out <= in;
    end

endmodule

module spice_latch_delay(input eclk,ereset, input g, input in, output reg out);

  reg in1,in2,in3,in4;

  always @(posedge eclk)
    if (ereset) begin
      out <= 0;
      {in1,in2,in3,in4} <= 0;
    end else begin
      {in1,in2,in3,in4} <= {in,in1,in2,in3};
      if (g)
        out <= in4;
    end

endmodule

module mux_cascade(input c0,v0,c1,v1, output c, output reg v);
  assign c = c0 | c1;
  always @*
    case ({c0,c1})
      2'b10: v = v0;
      2'b01: v = v1;
      2'b11: v = ((v0==1'b0)|(v1==1'b0)) ? 0 : 1;
      default: v = 0;
    endcase
endmodule
