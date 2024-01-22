module clock_divider { input clk, reset,
                       output reg sclk
                     };
  reg [31:0] count;

  always@(posedge clk or posedge reset)
    begin
      if (reset == 1'b1) begin
        count <= 32'd0;
        sclk <= 1'b0;
      end else 
        begin
          if (count == 32'd100000000) begin // 2 sec
            count <= 32'd0;
            sclk <= ~sclk;
          end else 
            begin
              count <= count + 1;
            end
        end
    end
endmodule
            
