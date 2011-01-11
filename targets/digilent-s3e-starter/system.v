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
    case (ab[7:0])
      8'd0: d = 8'hd8;
      8'd1: d = 8'h58;
      8'd2: d = 8'ha0;
      8'd3: d = 8'h7f;
      8'd4: d = 8'h8c;
      8'd5: d = 8'h12;
      8'd6: d = 8'hd0;
      8'd7: d = 8'ha9;
      8'd8: d = 8'ha7;
      8'd9: d = 8'h8d;
      8'd10: d = 8'h11;
      8'd11: d = 8'hd0;
      8'd12: d = 8'h8d;
      8'd13: d = 8'h13;
      8'd14: d = 8'hd0;
      8'd15: d = 8'hc9;
      8'd16: d = 8'hdf;
      8'd17: d = 8'hf0;
      8'd18: d = 8'h13;
      8'd19: d = 8'hc9;
      8'd20: d = 8'h9b;
      8'd21: d = 8'hf0;
      8'd22: d = 8'h03;
      8'd23: d = 8'hc8;
      8'd24: d = 8'h10;
      8'd25: d = 8'h0f;
      8'd26: d = 8'ha9;
      8'd27: d = 8'hdc;
      8'd28: d = 8'h20;
      8'd29: d = 8'hef;
      8'd30: d = 8'hff;
      8'd31: d = 8'ha9;
      8'd32: d = 8'h8d;
      8'd33: d = 8'h20;
      8'd34: d = 8'hef;
      8'd35: d = 8'hff;
      8'd36: d = 8'ha0;
      8'd37: d = 8'h01;
      8'd38: d = 8'h88;
      8'd39: d = 8'h30;
      8'd40: d = 8'hf6;
      8'd41: d = 8'had;
      8'd42: d = 8'h11;
      8'd43: d = 8'hd0;
      8'd44: d = 8'h10;
      8'd45: d = 8'hfb;
      8'd46: d = 8'had;
      8'd47: d = 8'h10;
      8'd48: d = 8'hd0;
      8'd49: d = 8'h99;
      8'd50: d = 8'h00;
      8'd51: d = 8'h02;
      8'd52: d = 8'h20;
      8'd53: d = 8'hef;
      8'd54: d = 8'hff;
      8'd55: d = 8'hc9;
      8'd56: d = 8'h8d;
      8'd57: d = 8'hd0;
      8'd58: d = 8'hd4;
      8'd59: d = 8'ha0;
      8'd60: d = 8'hff;
      8'd61: d = 8'ha9;
      8'd62: d = 8'h00;
      8'd63: d = 8'haa;
      8'd64: d = 8'h0a;
      8'd65: d = 8'h85;
      8'd66: d = 8'h2b;
      8'd67: d = 8'hc8;
      8'd68: d = 8'hb9;
      8'd69: d = 8'h00;
      8'd70: d = 8'h02;
      8'd71: d = 8'hc9;
      8'd72: d = 8'h8d;
      8'd73: d = 8'hf0;
      8'd74: d = 8'hd4;
      8'd75: d = 8'hc9;
      8'd76: d = 8'hae;
      8'd77: d = 8'h90;
      8'd78: d = 8'hf4;
      8'd79: d = 8'hf0;
      8'd80: d = 8'hf0;
      8'd81: d = 8'hc9;
      8'd82: d = 8'hba;
      8'd83: d = 8'hf0;
      8'd84: d = 8'heb;
      8'd85: d = 8'hc9;
      8'd86: d = 8'hd2;
      8'd87: d = 8'hf0;
      8'd88: d = 8'h3b;
      8'd89: d = 8'h86;
      8'd90: d = 8'h28;
      8'd91: d = 8'h86;
      8'd92: d = 8'h29;
      8'd93: d = 8'h84;
      8'd94: d = 8'h2a;
      8'd95: d = 8'hb9;
      8'd96: d = 8'h00;
      8'd97: d = 8'h02;
      8'd98: d = 8'h49;
      8'd99: d = 8'hb0;
      8'd100: d = 8'hc9;
      8'd101: d = 8'h0a;
      8'd102: d = 8'h90;
      8'd103: d = 8'h06;
      8'd104: d = 8'h69;
      8'd105: d = 8'h88;
      8'd106: d = 8'hc9;
      8'd107: d = 8'hfa;
      8'd108: d = 8'h90;
      8'd109: d = 8'h11;
      8'd110: d = 8'h0a;
      8'd111: d = 8'h0a;
      8'd112: d = 8'h0a;
      8'd113: d = 8'h0a;
      8'd114: d = 8'ha2;
      8'd115: d = 8'h04;
      8'd116: d = 8'h0a;
      8'd117: d = 8'h26;
      8'd118: d = 8'h28;
      8'd119: d = 8'h26;
      8'd120: d = 8'h29;
      8'd121: d = 8'hca;
      8'd122: d = 8'hd0;
      8'd123: d = 8'hf8;
      8'd124: d = 8'hc8;
      8'd125: d = 8'hd0;
      8'd126: d = 8'he0;
      8'd127: d = 8'hc4;
      8'd128: d = 8'h2a;
      8'd129: d = 8'hf0;
      8'd130: d = 8'h97;
      8'd131: d = 8'h24;
      8'd132: d = 8'h2b;
      8'd133: d = 8'h50;
      8'd134: d = 8'h10;
      8'd135: d = 8'ha5;
      8'd136: d = 8'h28;
      8'd137: d = 8'h81;
      8'd138: d = 8'h26;
      8'd139: d = 8'he6;
      8'd140: d = 8'h26;
      8'd141: d = 8'hd0;
      8'd142: d = 8'hb5;
      8'd143: d = 8'he6;
      8'd144: d = 8'h27;
      8'd145: d = 8'h4c;
      8'd146: d = 8'h44;
      8'd147: d = 8'hff;
      8'd148: d = 8'h6c;
      8'd149: d = 8'h24;
      8'd150: d = 8'h00;
      8'd151: d = 8'h30;
      8'd152: d = 8'h2b;
      8'd153: d = 8'ha2;
      8'd154: d = 8'h02;
      8'd155: d = 8'hb5;
      8'd156: d = 8'h27;
      8'd157: d = 8'h95;
      8'd158: d = 8'h25;
      8'd159: d = 8'h95;
      8'd160: d = 8'h23;
      8'd161: d = 8'hca;
      8'd162: d = 8'hd0;
      8'd163: d = 8'hf7;
      8'd164: d = 8'hd0;
      8'd165: d = 8'h14;
      8'd166: d = 8'ha9;
      8'd167: d = 8'h8d;
      8'd168: d = 8'h20;
      8'd169: d = 8'hef;
      8'd170: d = 8'hff;
      8'd171: d = 8'ha5;
      8'd172: d = 8'h25;
      8'd173: d = 8'h20;
      8'd174: d = 8'hdc;
      8'd175: d = 8'hff;
      8'd176: d = 8'ha5;
      8'd177: d = 8'h24;
      8'd178: d = 8'h20;
      8'd179: d = 8'hdc;
      8'd180: d = 8'hff;
      8'd181: d = 8'ha9;
      8'd182: d = 8'hba;
      8'd183: d = 8'h20;
      8'd184: d = 8'hef;
      8'd185: d = 8'hff;
      8'd186: d = 8'ha9;
      8'd187: d = 8'ha0;
      8'd188: d = 8'h20;
      8'd189: d = 8'hef;
      8'd190: d = 8'hff;
      8'd191: d = 8'ha1;
      8'd192: d = 8'h24;
      8'd193: d = 8'h20;
      8'd194: d = 8'hdc;
      8'd195: d = 8'hff;
      8'd196: d = 8'h86;
      8'd197: d = 8'h2b;
      8'd198: d = 8'ha5;
      8'd199: d = 8'h24;
      8'd200: d = 8'hc5;
      8'd201: d = 8'h28;
      8'd202: d = 8'ha5;
      8'd203: d = 8'h25;
      8'd204: d = 8'he5;
      8'd205: d = 8'h29;
      8'd206: d = 8'hb0;
      8'd207: d = 8'hc1;
      8'd208: d = 8'he6;
      8'd209: d = 8'h24;
      8'd210: d = 8'hd0;
      8'd211: d = 8'h02;
      8'd212: d = 8'he6;
      8'd213: d = 8'h25;
      8'd214: d = 8'ha5;
      8'd215: d = 8'h24;
      8'd216: d = 8'h29;
      8'd217: d = 8'h07;
      8'd218: d = 8'h10;
      8'd219: d = 8'hc8;
      8'd220: d = 8'h48;
      8'd221: d = 8'h4a;
      8'd222: d = 8'h4a;
      8'd223: d = 8'h4a;
      8'd224: d = 8'h4a;
      8'd225: d = 8'h20;
      8'd226: d = 8'he5;
      8'd227: d = 8'hff;
      8'd228: d = 8'h68;
      8'd229: d = 8'h29;
      8'd230: d = 8'h0f;
      8'd231: d = 8'h09;
      8'd232: d = 8'hb0;
      8'd233: d = 8'hc9;
      8'd234: d = 8'hba;
      8'd235: d = 8'h90;
      8'd236: d = 8'h02;
      8'd237: d = 8'h69;
      8'd238: d = 8'h06;
      8'd239: d = 8'h2c;
      8'd240: d = 8'h12;
      8'd241: d = 8'hd0;
      8'd242: d = 8'h30;
      8'd243: d = 8'hfb;
      8'd244: d = 8'h8d;
      8'd245: d = 8'h12;
      8'd246: d = 8'hd0;
      8'd247: d = 8'h60;
      8'd248: d = 8'h00;
      8'd249: d = 8'h00;
      8'd250: d = 8'h00;
      8'd251: d = 8'h0f;
      8'd252: d = 8'h00;
      8'd253: d = 8'hff;
      8'd254: d = 8'h00;
      8'd255: d = 8'h00;
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
