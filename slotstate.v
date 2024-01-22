module slotstate ( input clk, reset, lever,
                  output reg [3:0] resultMSB,
                  output reg [3:0] result2, resultLSB,
                  output reg [31:0] score
                 );
  //parameters for 3 FSMs
  parameter rst = 2'b01;
  parameter spin = 2'b10;
  parameter winning = 2'b11;

  reg [1:0] state;
  reg [12:0] slotMSB, slot2, slotLSB;
  reg [12:0] temp1, temp2, temp3;
  reg [31:0] scoretmp;

  always @(posedge clk or posedge reset)
    begin
      if (reset) begin
        state <= rst;
        slotMSB <= 13'h1;
        slot2 <= 5'h2;
        slotLSB <= 5'h3;
        scoretmp <= 5'h0;
      end else
        case (state)
          rst : if (lever)
            state <= spin;
          else 
            state <= reset;
          spin: begin //pseudo random number using Linear Feedback Shift Register
            slotMSB <= {slotMSB[11:0], slotMSB[12]^slotMSB[3]^slotMSB[2]^slotMSB[0]};
            slot2 <= {slot2[11:0], slot2[11]^slot2[2]^slot2[1]^slot2[0]};
            slotLSB <= {slotLSB[11:0], slotLSB[9]^slotLSB[4]^slotLSB[3]^slotLSB[1]};
            temp1 <= slotLSB%10; //mod 10 for #0-9
            temp2 <= slot2%10;
            temp3 <= slotLSB%10;
            if (lever == 0) begin
              state <= reset;
            end 
            else if (temp1 == temp2 || temp1 == temp3 || temp2 == temp3)
              begin
                state <= winning;
              end else
                state <= spin;
          end
          winning: if (temp1 == temp2 && temp2 && temp3) begin
            scoretmp <= scoretmp + 10;
            state <= spin;
          end
          else begin
            scoretmp <= scoretmp + 1;
            state <= spin;
          end
          default : state <= rst;
        endcase
    end
  always@(*) begin
    resultMSB <= temp1;
    score <= scoretmp;
    result2 <= temp2;
    resultLSB <= temp3;
  end
  
            
            
