// Top-level module for Digilent Spartan-3E starter board

module system(
  input clk_50mhz,
  output [7:0] led,
  input rs232_dce_rxd,
  output rs232_dce_txd
);

  wire [15:0] ab;
  wire [7:0] db_i;
  wire [7:0] db_o;
  wire [7:0] db_t;  // not yet properly set by the 6502 model; instead use rw for the three-state enable for all db pins

// create an emulation clock from clk_50mhz

  wire eclk, ereset;

  clock_and_reset _clk(clk_50mhz, eclk, ereset);

// synthesize the 6502 external clock and reset

  wire res, clk0;

  clocks_6502 _clocks_6502(eclk,ereset, res, clk0);

// blinking LED

  reg [26:0] c;
  always @(posedge eclk)
    c <= c+1;
  assign led = c[26:19];

  wire so = 1'b0;
  wire rdy = 1'b1;
  wire nmi = 1'b1;
  wire irq = 1'b1;

// instantiate the 6502 model

  chip_6502 _chip_6502(eclk, ereset,
    ab[0], ab[1], ab[2], ab[3], ab[4], ab[5], ab[6], ab[7], ab[8], ab[9], ab[10], ab[11], ab[12], ab[13], ab[14], ab[15],
    db_i[0], db_o[0], db_t[0], db_i[1], db_o[1], db_t[1], db_i[2], db_o[2], db_t[2], db_i[3], db_o[3], db_t[3], 
    db_i[4], db_o[4], db_t[4], db_i[5], db_o[5], db_t[5], db_i[6], db_o[6], db_t[6], db_i[7], db_o[7], db_t[7], 
    res, rw, sync, so, clk0, clk1out, clk2out, rdy, nmi, irq);

// address decoding

  wire [7:0] keyboard_data;
  wire keyboard_flag;
  wire [7:0] display_data;
  wire display_ready;
  wire [7:0] db_rom;
  wire [7:0] db_ram;

  wire [3:0] page = ab[15:12];
  assign db_i =
    (page==4'he || page==4'hf) ? db_rom :
    (page==4'h0 || page==4'h1) ? db_ram :
    (ab==16'hd010) ? {1'b1,keyboard_data[6:0]} :
    (ab==16'hd011) ? {keyboard_flag,7'd0} :
    ((ab==16'hd012)||(ab==16'hd0f2)) ? {!display_ready,display_data[6:0]} : 8'd0;

// I/O strobes

  reg clk2out1;
  always @(posedge eclk)
    clk2out1 <= clk2out;
  wire wr = !rw & clk2out1 & !clk2out;
  wire rd = rw & clk2out1 & !clk2out;

  wire wr_ram = (page==4'h0 || page==4'h1) && wr;
  wire rd_keyboard = (ab==16'hd011) && rd;
  wire wr_display = ((ab==16'hd012)||(ab==16'hd0f2)) && wr;

// ROM

  rom_6502 _rom_6502(eclk, ereset,
    ab, db_rom);

// RAM

  ram_6502 _ram_6502(eclk, ereset,
    ab, db_ram, wr_ram, db_o);

// RS-232 transceiver

  wire [7:0] rx_data;
  wire rx_flag;
  wire rx_ack;
  wire [7:0] tx_data;
  wire tx_flag;
  wire tx_wr;

  uart _uart(eclk, ereset,
    rs232_dce_rxd, rs232_dce_txd,
    rx_data, rx_flag, rx_ack,
    tx_data, tx_flag, tx_wr);

// Apple 1 keyboard

  keyboard_6502 _keyboard_6502(eclk, ereset,
    rx_data, rx_flag, rx_ack,
    rd_keyboard, keyboard_data, keyboard_flag);

// Apple 1 display

  display_6502 _display_6502(eclk, ereset,
    tx_data, tx_flag, tx_wr,
    wr_display, db_o, display_data, display_ready);

endmodule

module keyboard_6502(
  input eclk,ereset,
  input [7:0] rx_data,
  input rx_flag,
  output rx_ack,
  input rd_keyboard,
  output [7:0] keyboard_data,
  output keyboard_flag
);

  assign rx_ack = rd_keyboard;
  assign keyboard_data = rx_data;
  assign keyboard_flag = rx_flag;

endmodule

module display_6502(
  input eclk,ereset,
  output [7:0] tx_data,
  input tx_flag,
  output reg tx_wr,
  input wr_display,
  input [7:0] db_o,
  output reg [7:0] display_data,
  output display_ready
);

  assign tx_data = {1'b0,display_data[6:0]};

  always @(posedge eclk)
    if (ereset)
      tx_wr <= 0;
    else
      tx_wr <= wr_display;

  always @(posedge eclk)
    if (ereset)
      display_data <= 0;
    else if (wr_display)
      display_data <= db_o;

  assign display_ready = tx_flag;

endmodule

//
// Generate an emulation clock and an internally generated synchronous reset.
// For now just use the board's native 50 MHz; later can use a DCM to multiply up
// to something higher.
//

module clock_and_reset(
  input clk_50mhz,
  output eclk,
  output ereset
);

  wire _clk_50mhz;

  IBUFG i0(.I(clk_50mhz), .O(_clk_50mhz));
  BUFG b0(.I(_clk_50mhz), .O(eclk));
//  assign eclk = clk_50mhz;

  reg [7:0] r = 8'd0;

  always @(posedge eclk)
    r <= {r[6:0], 1'b1};

  assign ereset = ~r[7];

endmodule

module rom_6502(
  input eclk,ereset,
  input [15:0] ab,
  output reg [7:0] d
);

  always @*
    case (ab[3:0])
      4'h0: d = 8'ha9;
      4'h1: d = 8'h34;
      4'h2: d = 8'h8d;
      4'h3: d = 8'h12;
      4'h4: d = 8'hd0;
      4'h5: d = 8'h4c;
      4'h6: d = 8'hf5;
      4'h7: d = 8'hff;
      4'h8: d = 8'h00;
      4'h9: d = 8'h00;
      4'ha: d = 8'h00;
      4'hb: d = 8'h00;
      4'hc: d = 8'hf0; // reset vector
      4'hd: d = 8'hff;
      4'he: d = 8'h00;
      4'hf: d = 8'h00;
    endcase

endmodule

module ram_6502(
  input eclk,ereset,
  input [15:0] ab,
  output reg [7:0] d,
  input wr,
  input [7:0] din
);

  reg [7:0] mem[0:8191];

  integer i;

//  initial
//    for (i=0; i<8192; i=i+1)
//      mem[i] = 0;

  always @(posedge eclk)
    d <= mem[ab[12:0]];

  always @(posedge eclk)
    if (wr)
      mem[ab[12:0]] <= din;

endmodule
