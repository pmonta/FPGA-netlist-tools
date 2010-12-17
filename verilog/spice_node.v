`include "common.h"

module spice_node_0(input eclk,ereset, output signed [`W-1:0] v);
  assign v = 0;
endmodule

module spice_node_1(input eclk,ereset, input signed [`W-1:0] i0, output reg signed [`W-1:0] v);
  wire signed [`W-1:0] i = i0;

  always @(posedge eclk)
    if (ereset)
      v <= 0;
    else
      v <= v + i;

endmodule

module spice_node_2(input eclk,ereset, input signed [`W-1:0] i0,i1, output reg signed [`W-1:0] v);
  wire signed [`W-1:0] i = i0+i1;

  always @(posedge eclk)
    if (ereset)
      v <= 0;
    else
      v <= v + i;

endmodule

module spice_node_3(input eclk,ereset, input signed [`W-1:0] i0,i1,i2, output reg signed [`W-1:0] v);
  wire signed [`W-1:0] i = i0+i1+i2;

  always @(posedge eclk)
    if (ereset)
      v <= 0;
    else
      v <= v + i;

endmodule

module spice_node_4(input eclk,ereset, input signed [`W-1:0] i0,i1,i2,i3, output reg signed [`W-1:0] v);
  wire signed [`W-1:0] i = i0+i1+i2+i3;

  always @(posedge eclk)
    if (ereset)
      v <= 0;
    else
      v <= v + i;

endmodule

module spice_node_5(input eclk,ereset, input signed [`W-1:0] i0,i1,i2,i3,i4, output reg signed [`W-1:0] v);
  wire signed [`W-1:0] i = i0+i1+i2+i3+i4;

  always @(posedge eclk)
    if (ereset)
      v <= 0;
    else
      v <= v + i;

endmodule

module spice_node_6(input eclk,ereset, input signed [`W-1:0] i0,i1,i2,i3,i4,i5, output reg signed [`W-1:0] v);
  wire signed [`W-1:0] i = i0+i1+i2+i3+i4+i5;

  always @(posedge eclk)
    if (ereset)
      v <= 0;
    else
      v <= v + i;

endmodule

module spice_node_7(input eclk,ereset, input signed [`W-1:0] i0,i1,i2,i3,i4,i5,i6, output reg signed [`W-1:0] v);
  wire signed [`W-1:0] i = i0+i1+i2+i3+i4+i5+i6;

  always @(posedge eclk)
    if (ereset)
      v <= 0;
    else
      v <= v + i;

endmodule

module spice_node_8(input eclk,ereset, input signed [`W-1:0] i0,i1,i2,i3,i4,i5,i6,i7, output reg signed [`W-1:0] v);
  wire signed [`W-1:0] i = i0+i1+i2+i3+i4+i5+i6+i7;

  always @(posedge eclk)
    if (ereset)
      v <= 0;
    else
      v <= v + i;

endmodule

module spice_node_9(input eclk,ereset, input signed [`W-1:0] i0,i1,i2,i3,i4,i5,i6,i7,i8, output reg signed [`W-1:0] v);
  wire signed [`W-1:0] i = i0+i1+i2+i3+i4+i5+i6+i7+i8;

  always @(posedge eclk)
    if (ereset)
      v <= 0;
    else
      v <= v + i;

endmodule

module spice_node_10(input eclk,ereset, input signed [`W-1:0] i0,i1,i2,i3,i4,i5,i6,i7,i8,i9, output reg signed [`W-1:0] v);
  wire signed [`W-1:0] i = i0+i1+i2+i3+i4+i5+i6+i7+i8+i9;

  always @(posedge eclk)
    if (ereset)
      v <= 0;
    else
      v <= v + i;

endmodule

module spice_node_11(input eclk,ereset, input signed [`W-1:0] i0,i1,i2,i3,i4,i5,i6,i7,i8,i9,i10, output reg signed [`W-1:0] v);
  wire signed [`W-1:0] i = i0+i1+i2+i3+i4+i5+i6+i7+i8+i9+i10;

  always @(posedge eclk)
    if (ereset)
      v <= 0;
    else
      v <= v + i;

endmodule

module spice_node_12(input eclk,ereset, input signed [`W-1:0] i0,i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11, output reg signed [`W-1:0] v);
  wire signed [`W-1:0] i = i0+i1+i2+i3+i4+i5+i6+i7+i8+i9+i10+i11;

  always @(posedge eclk)
    if (ereset)
      v <= 0;
    else
      v <= v + i;

endmodule

module spice_node_13(input eclk,ereset, input signed [`W-1:0] i0,i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12, output reg signed [`W-1:0] v);
  wire signed [`W-1:0] i = i0+i1+i2+i3+i4+i5+i6+i7+i8+i9+i10+i11+i12;

  always @(posedge eclk)
    if (ereset)
      v <= 0;
    else
      v <= v + i;

endmodule

