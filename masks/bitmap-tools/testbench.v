module main();
  wire clk;

  wire sync;
  wire x0,x1,y0,y1,z0,z1,z2,z3,z4;

  clock_source c(clk);
  sync_source s(clk, sync);

  hp35_rom_control1 dut(clk, sync, x0,x1,y0,y1,z0,z1,z2,z3,z4);

  wire [7:0] state={dut.n_430,dut.n_428,dut.n_429,dut.n_426,dut.n_377,dut.n_421,dut.n_408,dut.n_348};
   
  always @(posedge clk)
    $display("sync:%d   state:%b   %d %d %d %d %d %d %d %d %d",sync,state,x0,x1,y0,y1,z0,z1,z2,z3,z4);

  initial #30000 $finish;

endmodule

module clock_source(output clk);
  reg clk;
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
endmodule

module sync_source(input clk, output sync);
  reg [5:0] c;
  initial
    c = 0;
  always @(posedge clk)
    c <= (c==6'd55) ? 0 : c+1;
//  assign sync = !((c>=45) && (c<55));
  assign sync = (c>=45) && (c<55);
endmodule
