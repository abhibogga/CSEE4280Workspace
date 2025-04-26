`timescale 1ns/1ns

module singlePortRam(
    input wire clk,
    input wire writeEnable,
    input wire [15:0] address,         
    input wire [15:0] writeIn,
    output reg [15:0] writeOut
);

    // === Parameters ===
    parameter DEPTH = 500;           // 500 memory locations
    parameter WIDTH = 16;            // 16-bit words

    // === RAM Declaration ===
    reg [WIDTH-1:0] ram [0:DEPTH-1];

    // === RAM Logic ===
    always @(posedge clk) begin
        if (writeEnable) begin
            if (address < DEPTH) begin
                ram[address] <= writeIn;    
            end
        end

        if (address < DEPTH) begin
            writeOut <= ram[address];
        end else begin
            writeOut <= 0;
        end
    end

endmodule
