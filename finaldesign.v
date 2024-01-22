module finaldesign { input reset, clk, lever,
                     output [7:0] Anode_Activate,
                     output [6:0] LED_out
                   };
  wire sclk;
  wire [3:0] resultMSB, result2, resultLSB;
  wire [3:0] score;

  clock_divider CLKDIV (.clk(clk),
                        .reset(reset),
                        .sclk(sclk)
                       );
  
  slotstate ST (.clk(sclk),
                .reset(reset),
                .resultMSB(resultMSB),
                .result2(result2),
                .resultLSB(resultLSB),
                .score(score),
                .lever(lever)
               );

  sevensegmentLED SLED (.clk(clk),
                        .reset(reset),
                        .resultMSB(resultMSB),
                        .result2(result2),
                        .resultLSB(resultLSB),
                        .score(score),
                        .Anode_Activate(Anode_Activatee),
                        .LED_out(LED_out)
                       );
  
                        
                
