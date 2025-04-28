module receiver_uart(
    input clk,
    input rst,
    input bitStream,
    input baudRate,  // 3-cycle wide pulse
    output reg dataReady,
    output reg [7:0] dataOut,
    output reg led
);

    parameter DBITS = 8;
    parameter SB_TICK = 16;

    parameter sIdle = 0, sStart = 1, sData = 2, sStop = 3;

    reg [1:0] state;
    reg [3:0] tick;
    reg [2:0] bitCount;

    reg baudRatePrev;
    reg baudRateRise;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= sIdle;
            tick <= 0;
            bitCount <= 0;
            dataReady <= 0;
            led <= 0;
            baudRatePrev <= 0;
            baudRateRise <= 0;
            dataOut <= 0;
        end else begin
            // Edge detect baudRate
            baudRateRise <= (~baudRatePrev) & baudRate;
            baudRatePrev <= baudRate;

            dataReady <= 0; // default low

            if (baudRateRise) begin
                case (state)
                    sIdle: begin
                        led <= 0;
                        if (~bitStream) begin
                            state <= sStart;
                            tick <= 0;
                        end
                    end

                    sStart: begin
                        if (tick == 4'd7) begin
                            state <= sData;
                            tick <= 0;
                            bitCount <= 0;
                        end else begin
                            tick <= tick + 1;
                        end
                    end

                    sData: begin
                        if (tick == 4'd15) begin
                            tick <= 0;
                            dataOut <= {bitStream, dataOut[7:1]}; // shift in LSB first
                            if (bitCount == (DBITS - 1)) begin
                                state <= sStop;
                            end else begin
                                bitCount <= bitCount + 1;
                            end
                        end else begin
                            tick <= tick + 1;
                        end
                    end

                    sStop: begin
                        led <= 1;
                        if (tick >= 14) begin
                            state <= sIdle;
                            tick <= 0;
                            dataReady <= 1;
                        end else begin
                            tick <= tick + 1;
                        end
                    end
                endcase
            end
        end
    end

endmodule
