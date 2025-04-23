module baudRateRead(clk, outBaud, rst);
    input clk; 
    input rst; 
    output reg outBaud;

    reg [9:0] counter;

    always @(posedge clk) begin
        if (rst) begin
            counter <= 0;
            outBaud <= 0;
        end else begin
            if (counter == 651) begin
                outBaud <= 1;   // emit 1-cycle pulse
                counter <= 0;
            end else begin
                outBaud <= 0;   // default low
                counter <= counter + 1;
            end
        end
    end
endmodule