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
    (ab[15]==1'b0) ? db_ram :
    (ab==16'hd010) ? {1'b1,keyboard_data[6:0]} :
    (ab==16'hd011) ? {keyboard_flag,7'd0} :
    ((ab==16'hd012)||(ab==16'hd0f2)) ? {!display_ready,display_data[6:0]} : 8'd0;

// I/O strobes

  reg clk2out1;
  always @(posedge eclk)
    clk2out1 <= clk2out;

  wire wr = !rw & clk2out1 & !clk2out;
  wire rd = rw & clk2out1 & !clk2out;

  wire wr_ram = (ab[15]==1'b0) && wr;
  wire rd_keyboard = (ab==16'hd010) && rd;
  wire wr_display = ((ab==16'hd012)||(ab==16'hd0f2)) && wr;
  wire wr_leds = (ab==16'ha000) && wr;

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

// on-board LEDs

  leds _leds(eclk, ereset,
    led,
    wr_leds, db_o);

endmodule

//
// SoC peripherals
//

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
  assign keyboard_data = {rx_data[7:6],rx_data[6] ? 1'b0 : rx_data[5],rx_data[4:0]};  // force incoming keyboard data to upper case
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

//
// 32K RAM
//

module ram_6502(
  input eclk,ereset,
  input [15:0] ab,
  output reg [7:0] d,
  input wr,
  input [7:0] din
);

  reg [7:0] mem[0:32767];

  always @(posedge eclk)
    d <= mem[ab[14:0]];

  always @(posedge eclk)
    if (wr)
      mem[ab[14:0]] <= din;

endmodule

//
// 8 LEDs as an output port
//

module leds(
  input eclk, ereset,
  output reg [7:0] led,
  input wr_leds,
  input [7:0] din
);

  always @(posedge eclk)
    if (ereset)
      led <= 0;
    else if (wr_leds)
      led <= din;

endmodule
