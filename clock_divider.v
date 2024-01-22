module clock_divider { input clk, reset,
                       output reg sclk
                     };
  reg [31:0] count
