module ram_6502(input eclk,ereset, input clk, input [15:0] a, output reg [7:0] dout, input [7:0] din, input rw);
  reg [7:0] mem[0:65535] /*verilator public*/;

`ifndef verilator
  integer i;
  integer fp;
  integer pc;
  integer c;
  initial begin
    for (i=0; i<65536; i=i+1)
      mem[i] = 0;
    #4000;
    for (i=0; i<65536; i=i+1)
      mem[i] = 0;
    pc = 16'h`CODE_START;
    fp = $fopen(`CODE,"r");
    c = $fgetc(fp);
    while (c!==32'hffffffff) begin
      mem[pc] = c;
      pc = pc + 1;
      c = $fgetc(fp);
    end
    $display($time,,"done initializing RAM; last address 0x%04x",pc);
  end
`endif

  reg key_ready /*verilator public*/;
  reg display_ready;
  reg display_first;
  reg display_flag /*verilator public*/;
  reg [7:0] display_byte /*verilator public*/;

  reg clk1;

  always @(posedge eclk)
    if (ereset) begin
      dout <= 0;
      clk1 <= 0;
      key_ready <= 0;
      display_ready <= 1;
      display_first <= 1;
      display_flag <= 0;
      display_byte <= 8'd0;
    end else begin
      clk1 <= clk;
      dout <= (a==16'hd011) ? {key_ready,7'd0} : ((a==16'hd012)||(a==16'hd0f2)) ? {!display_ready,mem[a][6:0]} : mem[a];
//      dout <= (a==16'hd011) ? {key_ready,mem[a][6:0]} : mem[a];

      if (!clk && clk1 && rw) begin                   //reads
        if (a==16'hd011) begin
//          $display("read d011; clearing flag");
          key_ready <= 0;
        end
//        if (a==16'hd012) begin
//          $display("read d012; value is 0x%02x 0x%02x",mem[a],dout);
//        end
      end

      if (!clk && clk1 && !rw) begin                  // writes
`ifdef DISPLAY_WRITES
        $display("mem[%04x] <- %02x",a,din);
`endif
        mem[a] <= din;
        if ((a==16'hd012)||(a==16'hd0f2)) begin  // fixme: separate peripheral code from generic RAM code
          if (!display_first) begin
            display_byte <= din&8'h7f;
            display_flag <= 1;
          end
          display_first <= 0;
        end
      end
    end

endmodule
