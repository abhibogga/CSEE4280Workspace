`timescale 1ns/1ns
`include "transmit_uart.v"
`include "baudRate.v"
`include "transmit_fifo.v"
`include "fpgaMain_transmit.v"
`include "ssd.v"

module topModuleTransmit(clk, rst, switchInputs, bitStream, seg, digit);

    input wire clk;               // System clock
    input wire rst;                 // Active-high reset
    input wire [3:0] switchInputs;  // Input switches for control
    output wire bitStream;           // UART output bit stream
    
    output wire [0:6] seg; 
    output wire [3:0] digit;
    

    wire [7:0] writeOut;
    wire writeFinished;
    wire txDone;
    wire outBaud;
    wire fifoBlip;
    wire [7:0] dataOut;

    // Instantiate the main logic controller
    fpgaMain_transmit uut (
        .switchInputs(switchInputs),
        .clk(clk),
        .listenTx(txDone),
        .fifoBlip(fifoBlip),
        .dataOut(dataOut)
    );
    

    // UART transmitter
    transmit_uart uartController (
        .dataIn(writeOut),
        .rst(~writeFinished),
        .clk(outBaud),
        .bitStream(bitStream),
        .txDone(txDone)
    );

    // Baud rate generator
    baudRate bd (
        .clk(clk),
        .rst(rst),
        .outBaud(outBaud)
    );
    
    

    // FIFO for transmitting data
    transmit_fifo fifo (
        .writeIn(dataOut),
        .writeReady(fifoBlip),
        .writeDone(txDone),
        .writeOut(writeOut),
        .writeFinished(writeFinished),
        .clk(clk)
    );
    
    
    
    //////////////////////
    
    //Test SSD Code, remove later: 
    // Constant digit values for "1000"
    wire [3:0] ones      = 4'd0;
    wire [3:0] tens      = 4'd0;
    wire [3:0] hundreds  = 4'd0;
    wire [3:0] thousands = 4'd1;

    // Instantiate seg7_control with fixed values
    ssd display_unit (
        .clk_100MHz(clk),
        .reset(rst),
        .ones(ones),
        .tens(tens),
        .hundreds(hundreds),
        .thousands(thousands),
        .seg(seg),
        .digit(digit)
    );

endmodule
