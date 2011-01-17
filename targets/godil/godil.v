// Top-level module for GODIL40_XC3S500E board

module godil40_xc3s500e(
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

  wire clk0_i;
  BUFG _ibuf_clk0(.I(clk0), .O(clk0_i));

// blink an LED using buffered clk0

  blink #(20) _blink0(clk0_i, led[0]);

// blink an LED using an internal ring oscillator

  wire osc;
  ring_osc _ring_osc(osc);
  blink #(24) _blink1(osc, led[1]);

// create an emulation clock from clk0

  wire eclk, ereset;

  clock_and_reset _clk(clk0_i, eclk, ereset);

// instantiate the 6502 model

  chip_6502 _chip_6502(eclk, ereset,
    ab[0], ab[1], ab[2], ab[3], ab[4], ab[5], ab[6], ab[7], ab[8], ab[9], ab[10], ab[11], ab[12], ab[13], ab[14], ab[15],
    db_i[0], db_o[0], db_t[0], db_i[1], db_o[1], db_t[1], db_i[2], db_o[2], db_t[2], db_i[3], db_o[3], db_t[3], 
    db_i[4], db_o[4], db_t[4], db_i[5], db_o[5], db_t[5], db_i[6], db_o[6], db_t[6], db_i[7], db_o[7], db_t[7], 
    res, rw, sync, so, clk0_i, clk1out, clk2out, rdy, nmi, irq);

endmodule

//
// Multiply frequency of incoming clk0 by 60 for an emulation clk
// (equivalent to HALFCYCLE=30)
//

module clock_and_reset(
  input clk0,
  output eclk,
  output ereset
);

  wire clk_27x;
  wire clk_54x;

  dcm_mult #(27) _dcm0(clk0, clk_27x);
  dcm_mult #(2) _dcm1(clk_27x, clk_54x);

  BUFG b0(.I(clk_54x), .O(eclk));

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

  wire clk_m;

  DCM_SP #(
   .CLKFX_DIVIDE(1),    // Can be any integer from 1 to 32
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

module ring_osc(
  output osc
);

  (* S = "TRUE" *) wire t0,t1,t2,t3,t4;

  LUT1 #(.INIT(2'h1)) inv0(.O(t0), .I0(t4));
  LUT1 #(.INIT(2'h1)) inv1(.O(t1), .I0(t0));
  LUT1 #(.INIT(2'h1)) inv2(.O(t2), .I0(t1));
  LUT1 #(.INIT(2'h1)) inv3(.O(t3), .I0(t2));
  LUT1 #(.INIT(2'h1)) inv4(.O(t4), .I0(t3));

  BUFG _bufg(.I(t0), .O(osc));

endmodule
