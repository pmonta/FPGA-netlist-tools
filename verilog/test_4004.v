// Top-level test SoC for 4004 core, RAM, peripherals, clocks
//
// Copyright (c) 2011 Peter Monta

module main();
  wire eclk /*verilator public*/;
  wire ereset /*verilator public*/;

`ifndef verilator
  clk_reset_gen _clk_reset_gen(eclk, ereset);
`endif

  wire clk1, clk2, sync, reset, test;
  wire [3:0] db_i;
  wire [3:0] db_o;
  wire [3:0] db_t;
  wire cm_rom, cm_ram3, cm_ram2, cm_ram1, cm_ram0;

  assign test = 0;
  assign db_i = 0;

  clocks_4004 _clocks_4004(eclk, ereset, reset, clk1, clk2);

  chip_4004 _chip_4004(eclk, ereset,
    clk1, clk2, sync, reset, test,
    db_i[0], db_o[0], db_t[0], db_i[1], db_o[1], db_t[1], db_i[2], db_o[2], db_t[2], db_i[3], db_o[3], db_t[3],
    cm_rom, cm_ram3, cm_ram2, cm_ram1, cm_ram0);

`ifndef verilator
  initial begin
    $dumpfile("test_4004.lxt");
    $dumpvars(0,main);
    #`MAXTICKS;
    $finish();
  end
`endif

endmodule

`ifndef verilator
module clk_reset_gen(output reg clk, reset);
  initial begin
    reset = 1;
    #1000;
    reset = 0;
  end

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

endmodule
`endif
