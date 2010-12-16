module clocks_6502(input eclk, ereset, output reg res, output clk0);
  reg [10:0] c;

  always @(posedge eclk)
    if (ereset) begin
      c <= 0;
      res <= 0;
    end else begin
      c <= c + 1;
      if (c==11'd2047)
        res <= 1;
    end

  assign clk0 = c[7];

endmodule
