// Generate reset and clk1 and clk2 for the 4004 core
//
// Copyright (c) 2011 Peter Monta

module clocks_4004(
  input eclk, ereset,
  output reg reset,
  output clk1,
  output clk2
);

  reg [10:0] c;
  reg [7:0] i;
  reg [1:0] p;

  always @(posedge eclk)
    if (ereset) begin
      c <= 0;
      reset <= 1;
      p <= 0;
      i <= 0;
    end else begin
      c <= c + 1;
      if (c==11'd2047)
        reset <= 0;
      if (i==8'd`QUARTERCYCLE-1) begin
        i <= 0;
        p <= p+1;
      end else
        i <= i + 1;
    end

  assign clk1 = (p==2'd0);
  assign clk2 = (p==2'd2);

endmodule
