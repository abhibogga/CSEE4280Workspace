`timescale 1ns / 1ps

module topModuleSSD(
    input clk,
    input rst,  // Use center button as reset
    output [0:6] seg,
    output [7:0] digit
    );

    wire rst;

    // Example data: RPM = 1234, Temp = 56
    wire [3:0] rpmOnes      = 4'd4;
    wire [3:0] rpmTens      = 4'd3;
    wire [3:0] rpmHundreds  = 4'd2;
    wire [3:0] rpmThousands = 4'd1;
    wire [3:0] tempOnes     = 4'd6;
    wire [3:0] tempTens     = 4'd5;

    ssd display_unit(
        .clk(clk),
        .rst(rst),
        .rpmOnes(rpmOnes),
        .rpmTens(rpmTens),
        .rpmHundreds(rpmHundreds),
        .rpmThousands(rpmThousands),
        .tempOnes(tempOnes),
        .tempTens(tempTens),
        .seg(seg),
        .digit(digit)
    );

endmodule
