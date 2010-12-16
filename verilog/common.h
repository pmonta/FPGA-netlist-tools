// precision of voltage, current variables is W+1 bits
`define W 9
`define W1 10

`define HI (`W1'd1<<(`W-1))
`define LO (-(`W1'd1<<(`W-1)))
