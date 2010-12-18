// Generate reset and clk0 for the 6502 core
//
// Copyright (c) 2010 Peter Monta

module clocks_6502(input eclk, ereset, output reg res, output reg clk0);
  reg [10:0] c;
  reg [7:0] i;

  always @(posedge eclk)
    if (ereset) begin
      c <= 0;
      res <= 0;
      clk0 <= 0;
      i <= 0;
    end else begin
      c <= c + 1;
      if (c==11'd2047)
        res <= 1;
      if (i==8'd`HALFCYCLE-1) begin
        i <= 0;
        clk0 <= ~clk0;
      end else
        i <= i + 1;
    end

endmodule
