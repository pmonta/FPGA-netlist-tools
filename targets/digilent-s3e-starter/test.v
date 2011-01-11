module test();
  reg clk;

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  wire [7:0] led;
  wire rx;
  wire tx;

  system _system(clk, led, rx, tx);

  initial begin
    $dumpfile("test_sys.lxt");
    $dumpvars(0,test);
    #400000;
    $finish();
  end


endmodule
