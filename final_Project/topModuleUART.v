`timescale 1ns/1ns

module topModuleUART(clk, rst, switchInputs, bitStreamOut, seg, digit, bitStreamIn, led);

    input wire clk;               // System clock
    input wire rst;                 // Active-high reset
    input wire [3:0] switchInputs;  // Input switches for control
    output wire bitStreamOut;           // UART output bit stream
    
    output wire [0:6] seg; 
    output wire [7:0] digit;
    
    output wire led; 
    

    wire [7:0] writeOut;
    wire writeFinished;
    wire txDone;
    wire outBaud;
    wire fifoBlip;
    wire [7:0] dataOut;
    
    //Outputs for Read End
    input wire bitStreamIn; 
    
    wire outBaudRead; 
    wire dOutEight; 
    wire readDone; 
    wire dOutSixteen; 
    wire rxDone; 
    
    wire [15:0] writeOutRam; 
    

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
        .bitStream(bitStreamOut),
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
    
    
    
    ////////////////////// Read Code: 
    
   
    
    baudRateRead bdr(
        .clk(clk), 
        .rst(rst),
        .outBaud(outBaudRead)
    );
    
    // Instantiate UART receiver
    receiver_uart recBit(
        .clk(clk),
        .baudRate(outBaudRead), 
        .rst(rst), 
        .bitStream(bitStreamIn), 
        .dataOut(dOutEight), 
        .dataReady(readDone), 
        .led(led)
    ); 
    
    // FIFO output handling
    read_fifo rf(
        .signalReady(readDone),
        .dataIn(dOutEight), 
        .readBegin(switchInputs[0]), 
        .clk(clk), 
        .dataOut(dOutSixteen), 
        .rxDone(rxDone), 
        .segments(seg), 
        .digits(digit),
        .rst(rst)
    );
    
    fpgaMain_read fpgaMain(
        .clk(clk), 
        .dataInSignal(rxDone), 
        .dataIn(dOutSixteen), 
        .rst(rst), 
        .writeOut(writeOutRam)
    );
    

endmodule
