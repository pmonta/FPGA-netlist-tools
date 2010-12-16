`include "common.h"

module spice_pin_input(input p, input signed [`W:0] v, output signed [`W:0] i);
  wire [`W:0] vp = p ? `HI : `LO;
  wire [`W+1:0] dv = {vp[`W],vp} - {v[`W],v};
  assign i = {{2{dv[`W+1]}},dv[`W+1:3]};
endmodule

module spice_pin_output(output p, input signed [`W:0] v, output signed [`W:0] i);
  assign p = ~v[`W];
  assign i = 0;
endmodule

module spice_pin_bidirectional(input p_i, output p_o, output p_t, input signed [`W:0] v, output signed [`W:0] i);
  assign p_o = ~v[`W];
  wire [`W:0] vp = p_i ? `HI : `LO;
  wire [`W+1:0] dv = {vp[`W],vp} - {v[`W],v};
  assign i = {{3{dv[`W+1]}},dv[`W+1:4]};
  assign p_t = 0; //fixme
endmodule

module spice_transistor_nmos(input g, input signed [`W:0] vs,vd, output signed [`W:0] is,id);
  wire signed [`W+1:0] vsd = {vd[`W],vd} - {vs[`W],vs};
  wire signed [`W:0] isd = {vsd[`W+1],vsd[`W+1:2]};
  wire signed [`W:0] i = g ? isd : 0;
  assign is = i;
  assign id = -i;
endmodule

module spice_transistor_nmos_vdd(input g, input signed [`W:0] vs, output signed [`W:0] is);
  wire signed [`W:0] vd = `HI;
  wire signed [`W+1:0] vsd = {vd[`W],vd} - {vs[`W],vs};
  wire signed [`W:0] isd = {{2{vsd[`W+1]}},vsd[`W+1:3]}; // heuristic for 6502: transistors that connect to vdd should be weaker
  assign is = g ? isd : `W1'd0;
endmodule

module spice_transistor_nmos_gnd(input g, input signed [`W:0] vd, output signed [`W:0] id);
  wire signed [2:0] lo = 3'b110;
  wire signed [2:0] vdtop = lo - {vd[`W],vd[`W:`W-1]};
  wire signed [`W+1:0] vsd = {vdtop,~vd[`W-2:0]};
  wire signed [`W:0] i = {vsd[`W+1],vsd[`W+1:2]};
  assign id = g ? i : `W1'd0;
endmodule

module spice_pullup(input signed [`W:0] v, output signed [`W:0] i);
  wire signed [2:0] hi = 3'b000;
  wire signed [2:0] vdtop = hi - {v[`W],v[`W:`W-1]};
  wire signed [`W+1:0] dv = {vdtop,~v[`W-2:0]};
  assign i = {{3{dv[`W+1]}},dv[`W+1:4]};
endmodule
