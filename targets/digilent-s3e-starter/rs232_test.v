module rs232_test(
  input clk,reset,
  input [7:0] rx_data,
  input rx_flag,
  output reg rx_ack,
  output [7:0] tx_data,
  input tx_flag,
  output reg tx_wr
);

  reg [7:0] d;
  assign tx_data = d+1;

  reg [2:0] state;

  always @(posedge clk)
    if (reset) begin
      state <= 0;
      rx_ack <= 0;
      tx_wr <= 0;
    end else
      case (state)
        3'd0: if (rx_flag) begin d <= rx_data; rx_ack <= 1; state <= 3'd1; end
        3'd1: begin rx_ack <= 0; state <= 3'd2; end
        3'd2: if (tx_flag) begin tx_wr <= 1; state <= 3'd3; end
        3'd3: begin tx_wr <= 0; state <= 3'd0; end
      endcase

endmodule
