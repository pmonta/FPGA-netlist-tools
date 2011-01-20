module chip_6507(
  input eclk, ereset,
  output [12:0] ab,
  input [7:0] db_i,
  output [7:0] db_o,
  input res,
  output rw,
  input clk0,
  output clk2out,
  input rdy
);

  wire [7:0] db_t;

  wire sync;
  wire so = 1'b1;
  wire clk1out;
  wire nmi = 1'b1;
  wire irq = 1'b1;

  wire _a13, _a14, _a15;

  chip_6502 _chip_6502(
    eclk, ereset,
    ab[0], ab[1], ab[2], ab[3], ab[4], ab[5], ab[6], ab[7], 
    ab[8], ab[9], ab[10], ab[11], ab[12], _a13, _a14, _a15, 
    db_i[0], db_o[0], db_t[0],
    db_i[1], db_o[1], db_t[1],
    db_i[2], db_o[2], db_t[2],
    db_i[3], db_o[3], db_t[3],
    db_i[4], db_o[4], db_t[4],
    db_i[5], db_o[5], db_t[5],
    db_i[6], db_o[6], db_t[6],
    db_i[7], db_o[7], db_t[7],
    res, rw, sync, so, clk0, clk1out, clk2out, rdy, nmi, irq);

endmodule
