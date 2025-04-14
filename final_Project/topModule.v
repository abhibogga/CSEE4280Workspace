`timescale 1ns/1ns

module topMod(clk, rst, switchInputs, bitStream);

    input wire clk;               // System clock
    input wire rst;                 // Active-high reset
    input wire [3:0] switchInputs;  // Input switches for control
    output wire bitStream;           // UART output bit stream
    

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

endmodule