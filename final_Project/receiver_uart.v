`timescale 1ns / 1ps

module receiver_uart(clk, rst, bitStream, baudRate, dataReady, dataOut, led);

    // === Parameters === //
    parameter DBITS = 8; 
    parameter SB_TICK = 16;

    // === Inputs === //
    input clk;
    input rst;
    input bitStream;
    input baudRate;

    // === Outputs === //
    output reg dataReady;
    output [DBITS-1:0] dataOut;
    output reg led; 

    // === Internal Registers === //
    reg [1:0] state, stateNext;
    reg [3:0] tick, tickNext;
    reg [2:0] bitCount, bitCountNext;
    reg [7:0] dataReg, dataRegNext;

    // === State Definitions === //
    parameter sIdle = 0, sStart = 1, sData = 2, sStop = 3;

    // === Output Assignments === //
    assign dataOut = dataReg;

    // === Sequential Logic === //
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= sIdle;
            tick <= 0;
            bitCount <= 0;
            dataReg <= 0;
        end else begin
            state <= stateNext;
            tick <= tickNext;
            bitCount <= bitCountNext;
            dataReg <= dataRegNext;
        end
    end

    //Combinational FSM Logic
    always @* begin
        stateNext = state;
        tickNext = tick;
        bitCountNext = bitCount;
        dataRegNext = dataReg;
        dataReady = 0;

        case (state)
            sIdle: begin
                led = 0;
                if (~bitStream) begin
                    stateNext = sStart;
                    tickNext = 0;
                end
            end

            sStart: begin
                if (baudRate) begin
                    if (tick == 4'd7) begin
                        stateNext = sData;
                        tickNext = 0;
                        bitCountNext = 0;
                    end else begin
                        tickNext = tick + 1;
                    end
                end
            end

            sData: begin
                if (baudRate) begin 
                    if (tick == 4'd15) begin
                        tickNext = 0;
                        dataRegNext = {bitStream, dataReg[7:1]};
                        if (bitCount == (DBITS - 1)) begin
                            led = 1;
                            stateNext = sStop;
                        end else begin
                            bitCountNext = bitCount + 1;
                        end
                    end else begin
                        tickNext = tick + 1;
                    end
                end
            end

            sStop: begin
                if (baudRate) begin
                    if (tick == (SB_TICK - 1)) begin
                        stateNext = sIdle;
                        dataReady = 1;
                        led = 1;
                    end else begin
                        tickNext = tick + 1;
                    end
                end
            end
        endcase
    end

endmodule
