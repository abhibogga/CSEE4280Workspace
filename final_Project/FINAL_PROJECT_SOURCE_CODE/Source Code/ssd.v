`timescale 1ns / 1ps

module ssd(
    input clk,
    input rst,
    input [3:0] rpmOnes,
    input [3:0] rpmTens,
    input [3:0] rpmHundreds,
    input [3:0] rpmThousands,
    input [3:0] tempOnes, 
    input [3:0] tempTens, 
    output reg [0:6] seg,       // segment pattern 0-9
    output reg [7:0] digit      // digit select signals
    );
    
    // Parameters for segment patterns
    parameter ZERO  = 7'b000_0001;  // 0
    parameter ONE   = 7'b100_1111;  // 1
    parameter TWO   = 7'b001_0010;  // 2 
    parameter THREE = 7'b000_0110;  // 3
    parameter FOUR  = 7'b100_1100;  // 4
    parameter FIVE  = 7'b010_0100;  // 5
    parameter SIX   = 7'b010_0000;  // 6
    parameter SEVEN = 7'b000_1111;  // 7
    parameter EIGHT = 7'b000_0000;  // 8
    parameter NINE  = 7'b000_0100;  // 9
    
    // To select each digit in turn
    reg [2:0] digit_select;     // 2 bit counter for selecting each of 4 digits
    reg [16:0] digit_timer;     // counter for digit refresh
    
    // Logic for controlling digit select and digit timer
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            digit_select <= 0;
            digit_timer <= 0; 
        end
        else                                        // 1ms x 4 displays = 4ms refresh period
            if(digit_timer == 99_999) begin         // The period of 100MHz clock is 10ns (1/100,000,000 seconds)
                digit_timer <= 0;                   // 10ns x 100,000 = 1ms
                digit_select <=  digit_select + 1;
            end
            else
                digit_timer <=  digit_timer + 1;
    end

    always @(digit_select) begin
        case(digit_select)
            3'd0: digit = 8'b1111_1110; // Enable digit 0 //This will be rpmOnes
            3'd1: digit = 8'b1111_1101; // Enable digit 1 //This will be rpmTens
            3'd2: digit = 8'b1111_1011; // Enable digit 2 //This will be rpmHundreds
            3'd3: digit = 8'b1111_0111; // Enable digit 3 //This will be rpmThousands
            3'd4: digit = 8'b1110_1111; // Enable digit 4 //This will be 0
            3'd5: digit = 8'b1101_1111; // Enable digit 5 //This will be 0; 
            3'd6: digit = 8'b1011_1111; // Enable digit 6 //This will be tempOnes
            3'd7: digit = 8'b0111_1111; // Enable digit 7 //This will be tempTens
            default: digit = 8'b0000_0000; // All on (just to check change later)
        endcase
    end
    
    // Logic for driving segments based on which digit is selected and the value of each digit
    always @*
        case(digit_select)
            3'b000 : begin       // ONES DIGIT
                        case(rpmOnes)
                            4'b0000 : seg = ZERO;
                            4'b0001 : seg = ONE;
                            4'b0010 : seg = TWO;
                            4'b0011 : seg = THREE;
                            4'b0100 : seg = FOUR;
                            4'b0101 : seg = FIVE;
                            4'b0110 : seg = SIX;
                            4'b0111 : seg = SEVEN;
                            4'b1000 : seg = EIGHT;
                            4'b1001 : seg = NINE;
                        endcase
                    end
                    
            3'b001 : begin       // TENS DIGIT
                        case(rpmTens)
                            4'b0000 : seg = ZERO;
                            4'b0001 : seg = ONE;
                            4'b0010 : seg = TWO;
                            4'b0011 : seg = THREE;
                            4'b0100 : seg = FOUR;
                            4'b0101 : seg = FIVE;
                            4'b0110 : seg = SIX;
                            4'b0111 : seg = SEVEN;
                            4'b1000 : seg = EIGHT;
                            4'b1001 : seg = NINE;
                        endcase
                    end
                    
            3'b010 : begin       // HUNDREDS DIGIT
                        case(rpmHundreds)
                            4'b0000 : seg = ZERO;
                            4'b0001 : seg = ONE;
                            4'b0010 : seg = TWO;
                            4'b0011 : seg = THREE;
                            4'b0100 : seg = FOUR;
                            4'b0101 : seg = FIVE;
                            4'b0110 : seg = SIX;
                            4'b0111 : seg = SEVEN;
                            4'b1000 : seg = EIGHT;
                            4'b1001 : seg = NINE;
                        endcase
                    end
                    
            3'b011 : begin       //Thousands digit
                        case(rpmThousands)
                            4'b0000 : seg = ZERO;
                            4'b0001 : seg = ONE;
                            4'b0010 : seg = TWO;
                            4'b0011 : seg = THREE;
                            4'b0100 : seg = FOUR;
                            4'b0101 : seg = FIVE;
                            4'b0110 : seg = SIX;
                            4'b0111 : seg = SEVEN;
                            4'b1000 : seg = EIGHT;
                            4'b1001 : seg = NINE;
                        endcase
                    end
            3'b100 : begin       // 0 filler
                        seg = 7'b111_1111; 
                    end


            3'b101 : begin       // 0 filler
                        seg = 7'b111_1111; 
                    end

            3'b110 : begin       //temp ones
                        case(tempOnes)
                            4'b0000 : seg = ZERO;
                            4'b0001 : seg = ONE;
                            4'b0010 : seg = TWO;
                            4'b0011 : seg = THREE;
                            4'b0100 : seg = FOUR;
                            4'b0101 : seg = FIVE;
                            4'b0110 : seg = SIX;
                            4'b0111 : seg = SEVEN;
                            4'b1000 : seg = EIGHT;
                            4'b1001 : seg = NINE;
                        endcase 
                    end

             3'b111 : begin       //temp tens
                        case(tempTens)
                            4'b0000 : seg = ZERO;
                            4'b0001 : seg = ONE;
                            4'b0010 : seg = TWO;
                            4'b0011 : seg = THREE;
                            4'b0100 : seg = FOUR;
                            4'b0101 : seg = FIVE;
                            4'b0110 : seg = SIX;
                            4'b0111 : seg = SEVEN;
                            4'b1000 : seg = EIGHT;
                            4'b1001 : seg = NINE;
                        endcase 
                    end




        endcase

endmodule
