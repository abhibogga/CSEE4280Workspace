`timescale 1ns / 1ps

module receiver_uart(
    input clk,
    input rst,
    input bitStream,
    input baudRate,                 // Should pulse at 16x baud (e.g., 153.6kHz for 9600 baud)
    output reg dataReady,
    output [7:0] dataOut,
    output reg led
);

    // === Parameters === //
    parameter DBITS = 8;
    parameter SB_TICK = 16;

    // === State Definitions === //
    parameter sIdle = 0, sStart = 1, sData = 2, sStop = 3;

    // === Registers === //
    reg [1:0] state;
    reg [3:0] tick;
    reg [2:0] bitCount;
    reg [7:0] dataReg;

    assign dataOut = dataReg;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state     <= sIdle;
            tick      <= 0;
            bitCount  <= 0;
            dataReg   <= 0;
            dataReady <= 0;
            led       <= 0;
        end else begin
            dataReady <= 0; // Default low, pulse for 1 clock on valid data
            led <= 0;       // Pulse LED on final data bit or stop bit

            case (state)
                sIdle: begin
                    if (~bitStream) begin // Start bit detected (falling edge)
                        state <= sStart;
                        tick <= 0;
                    end
                end

                sStart: begin
                    if (baudRate) begin
                        if (tick == 4'd7) begin // Midpoint of start bit
                            state <= sData;
                            tick <= 0;
                            bitCount <= 0;
                        end else begin
                            tick <= tick + 1;
                        end
                    end
                end

                sData: begin
                    if (baudRate) begin
                        if (tick == 4'd15) begin // Sample at end of bit period
                            tick <= 0;
                            dataReg <= {bitStream, dataReg[7:1]}; // LSB-first
                            if (bitCount == (DBITS - 1)) begin
                                state <= sStop;
                                led <= 1;
                            end else begin
                                bitCount <= bitCount + 1;
                            end
                        end else begin
                            tick <= tick + 1;
                        end
                    end
                end

                sStop: begin
                    if (baudRate) begin
                        if (tick == (SB_TICK - 1)) begin
                            state <= sIdle;
                            dataReady <= 1; // Pulse ready
                            led <= 1;
                            tick <= 0;
                        end else begin
                            tick <= tick + 1;
                        end
                    end
                end
            endcase
        end
    end

endmodule
