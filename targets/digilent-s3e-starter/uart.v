// wrapper for uart_transceiver.v

module uart(
  input clk,reset,
  input rs232_rxd,
  output rs232_txd,
  output reg [7:0] rx_data,
  output reg rx_flag,
  input rx_ack,
  input [7:0] tx_data,
  output reg tx_flag,
  input tx_wr
);

  wire [7:0] rx_d;

  wire [15:0] divisor = 16'd27;  // 115200 baud at 50 MHz, 0.5 percent error
//  wire [15:0] divisor = 16'd163;  // 19200 baud at 50 MHz, 0.15 percent error

  uart_transceiver _uart_transceiver(.sys_clk(clk), .sys_rst(reset),
    .uart_rx(rs232_rxd), .uart_tx(rs232_txd),
    .divisor(divisor),
    .rx_data(rx_d), .rx_done(rx_done),
    .tx_data(tx_data), .tx_wr(tx_wr), .tx_done(tx_done));

// RX

  reg [1:0] rx_state;

  always @(posedge clk)
    if (reset) begin
      rx_state <= 0;
      rx_flag <= 0;
    end else
      case (rx_state)
        2'd0: if (rx_done) begin rx_data <= rx_d; rx_state <= 2'd1; end
        2'd1: if (!rx_done) begin rx_flag <= 1; rx_state <= 2'd2; end
        2'd2: if (rx_ack) begin rx_flag <= 0; rx_state <= 2'd0; end
      endcase

// TX

  reg [1:0] tx_state;

  always @(posedge clk)
    if (reset) begin
      tx_state <= 0;
      tx_flag <= 1;
    end else
      case (tx_state)
        2'd0: if (tx_wr) begin tx_flag <= 0; tx_state <= 2'd1; end
        2'd1: if (tx_done) tx_state <= 2'd2;
        2'd2: if (!tx_done) begin tx_flag <= 1; tx_state <= 2'd0; end
      endcase

endmodule
