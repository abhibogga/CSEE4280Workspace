`include "../fpgaMain_transmit.v"
`timescale 1ns / 1ps

module tb_fpgaMain_transmit();

    // Inputs
    reg [3:0] switchInputs;
    reg clk;
    reg txListen; 

    // Outputs
    wire fifoBlip;
    wire [7:0] dataOut;

    // Instantiate the Unit Under Test (UUT)
    fpgaMain_transmit uut (
        .switchInputs(switchInputs),
        .clk(clk),
        .listenTx(txListen),
        .fifoBlip(fifoBlip),
        .dataOut(dataOut)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100MHz clock (10ns period)
    end

    // Stimulus
    initial begin
        txListen = 0;
        $dumpvars(0, tb_fpgaMain_transmit);
        switchInputs = 5'b00000;
        switchInputs[3] = 1'b1;

        // Let ATZ command process
        #1500
        txListen = 1;
        #10
        txListen = 0;
        // Let ATZ command process
        #1500
        txListen = 1;
        #10
        txListen = 0;
        // Let ATZ command process
        #1500
        txListen = 1;
        #10
        txListen = 0;
        // Let ATZ command process
        #1500
        txListen = 1;
        #10
        txListen = 0;
        // Let ATZ command process
        #1500
        txListen = 1;
        #10
        txListen = 0;


        // === Trigger RPM command using switchInputs[0] ===
    /*
        switchInputs[0] = 1'b1;
        #20;
        switchInputs[0] = 1'b0;
*/
        // Let RPM command process
        #2500;

        $finish;
    end

endmodule
