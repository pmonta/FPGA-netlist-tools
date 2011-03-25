// Generate reset and clk1 and clk2 for the 4004 core
//
// Copyright (c) 2011 Peter Monta

module clocks_4004(
  input eclk, ereset,
  output reg res,
  output reg clk1,
  output clk2
);

  reg [10:0] c;
  reg [7:0] i;

  always @(posedge eclk)
    if (ereset) begin
      c <= 0;
      res <= 0;
      clk1 <= 0;
      i <= 0;
    end else begin
      c <= c + 1;
      if (c==11'd2047)
        res <= 1;
      if (i==8'd`HALFCYCLE-1) begin
        i <= 0;
        clk1 <= ~clk1;
      end else
        i <= i + 1;
    end

  assign clk2 = ~clk1;

endmodule
