module rom_4004(
  input eclk, ereset,
  input clk1, clk2, sync, cm_rom,
  input [3:0] db,
  output [3:0] db_rom
);

  reg [11:0] a;
  reg [7:0] d;

  always @(a)
    case (a[3:0])
      4'd0: d = 8'hd5;
      4'd1: d = 8'hd6;
      4'd2: d = 8'hf2;
      4'd3: d = 8'hf2;
      4'd4: d = 8'hf2;
      4'd5: d = 8'hf2;
      4'd6: d = 8'hf2;
      4'd7: d = 8'h40;
      4'd8: d = 8'h06;
      4'd9: d = 8'h00;
      4'd10: d = 8'h00;
      4'd11: d = 8'h00;
      4'd12: d = 8'h00;
      4'd13: d = 8'h00;
      4'd14: d = 8'h00;
      4'd15: d = 8'h00;
    endcase

  reg [2:0] c,c1;
  reg clk1p;
  reg clk2p;
  reg [7:0] d1;

  always @(posedge eclk)
    if (ereset) begin
      c <= 0;
      c1 <= 0;
      clk1p <= 0;
      clk2p <= 0;
      a <= 0;
    end else begin
      clk1p <= clk1;
      clk2p <= clk2;
      if (clk2 & !clk2p) begin
        c <= sync ? 0 : c+1;
        if (c==3'd0)
          a[3:0] <= db;
        if (c==3'd1)
          a[7:4] <= db;
        if (c==3'd2)
          a[11:8] <= db;
      end
      if (clk1 & !clk1p) begin
        c1 <= c;
        d1 <= d;
      end
    end

  assign db_rom = (c1==3'd3) ? d1[7:4] : (c1==3'd4) ? d1[3:0] : 4'h0;

endmodule
