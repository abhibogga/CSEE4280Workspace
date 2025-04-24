module baudRateRead(
    input clk,
    input rst,
    output reg outBaud
);

    // Baud rate divisor for 16x oversampling (e.g., 9600 baud from 100MHz)
    parameter BAUD_DIV = 651;

    reg [9:0] counter;
    reg [1:0] pulseCounter;
    reg [1:0] state;

    localparam sWait  = 2'd0;
    localparam sPulse = 2'd1;

    always @(posedge clk) begin
        if (rst) begin
            counter <= 0;
            pulseCounter <= 0;
            outBaud <= 0;
            state <= sWait;
        end else begin
            case (state)
                sWait: begin
                    outBaud <= 0;
                    if (counter == BAUD_DIV) begin
                        counter <= 0;
                        pulseCounter <= 2; // 3 cycles total
                        outBaud <= 1;
                        state <= sPulse;
                    end else begin
                        counter <= counter + 1;
                    end
                end

                sPulse: begin
                    outBaud <= 1;
                    if (pulseCounter == 0) begin
                        outBaud <= 0;
                        state <= sWait;
                    end else begin
                        pulseCounter <= pulseCounter - 1;
                    end
                end
            endcase
        end
    end

endmodule
