// Top-level module for GODIL40_XC3S500E board

module godil40_xc3s500e(
  input clk_49152mhz,
// start of 6502 pins on DIL40 connector
  output [15:0] ab,
  inout [7:0] db,
  input res,
  output rw,
  output sync,
  input so,
  input clk0,
  output clk1out,
  output clk2out,
  input rdy,
  input nmi,
  input irq,
// end of 6502 pins on DIL40 connector
  output [1:0] led
);

// handle three-state data bus

  wire [7:0] db_i;
  wire [7:0] db_o;
  wire [7:0] db_t;  // not yet properly set by the 6502 model; instead use rw for the three-state enable for all db pins

  assign db_i = db;
  assign db = rw ? 8'bz : db_o;

// create an emulation clock from clk_49152mhz

  wire eclk, ereset;

  clock_and_reset _clk(clk_49152mhz, eclk, ereset);

// blink an LED using eclk

  blink #(26) _blink0(eclk, led[0]);

  assign led[1] = !res;

// instantiate the 6502 model

  chip_6502 _chip_6502(eclk, ereset,
    ab[0], ab[1], ab[2], ab[3], ab[4], ab[5], ab[6], ab[7], ab[8], ab[9], ab[10], ab[11], ab[12], ab[13], ab[14], ab[15],
    db_i[0], db_o[0], db_t[0], db_i[1], db_o[1], db_t[1], db_i[2], db_o[2], db_t[2], db_i[3], db_o[3], db_t[3], 
    db_i[4], db_o[4], db_t[4], db_i[5], db_o[5], db_t[5], db_i[6], db_o[6], db_t[6], db_i[7], db_o[7], db_t[7], 
    res, rw, sync, so, clk0, clk1out, clk2out, rdy, nmi, irq);

endmodule

//
// Make emulation clock from on-board 49.152 MHz oscillator
//

module clock_and_reset(
  input clk_in,
  output eclk,
  output ereset
);

  wire clk_56mhz;
  dcm_mult #(8,7) _dcm0(clk_in, clk_56mhz);
  BUFG b0(.I(clk_56mhz), .O(eclk));

  reg [7:0] r = 8'd0;

  always @(posedge eclk)
    r <= {r[6:0], 1'b1};

  assign ereset = ~r[7];

endmodule

module dcm_mult(
  input clk_in,
  output clk_out
);

  parameter N = 2;
  parameter D = 2;

  wire clk_m;

  DCM_SP #(
   .CLKFX_DIVIDE(D),    // Can be any integer from 1 to 32
   .CLKFX_MULTIPLY(N), // Can be any integer from 2 to 32
   .STARTUP_WAIT("TRUE")    // Delay configuration DONE until DCM LOCK, TRUE/FALSE
) DCM_SP_inst (
   .CLKFX(clk_out),     // DCM CLK synthesis out (M/D)
   .CLKIN(clk_in)    // Clock input (from IBUFG, BUFG or DCM)
);

endmodule

module blink(
  input clk,
  output led
);

  parameter W = 8;

  reg [W-1:0] c;

  always @(posedge clk)
    c <= c + 1;

  assign led = c[W-1];

endmodule
