`timescale 1ns / 1ps
`include "../fpgaMain_read.v"
`include "../singlePortRam.v"
module tb_fpgaMain_read;

    reg clk;
    reg dataInSignal;
    reg [15:0] dataIn;
    wire [15:0] writeOut;

    // Instantiate the DUT
    fpgaMain_read uut (
        .clk(clk),
        .dataInSignal(dataInSignal),
        .dataIn(dataIn),
        .writeOut(writeOut)
    );

    // Clock generation
    always #5 clk = ~clk; // 10ns clock period

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_fpgaMain_read);

        // Init signals
        clk = 0;
        dataInSignal = 1;
        dataIn = 16'hAAAA;

        // Wait a bit then simulate a falling edge on dataInSignal
        #20;
        dataInSignal = 0;  // falling edge
        #10;
        dataInSignal = 1;  // return to high

        // Change data and trigger again
        #20;
        dataIn = 16'h5555;
        dataInSignal = 0;
        #10;
        dataInSignal = 1;

        #50;
        $finish;
    end

endmodule
