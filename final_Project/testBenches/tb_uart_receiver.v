`include "../receiver_uart.v"
`include "../baudRate.v"
`timescale 1ns/1ns
module tb_uart_receiver(); 

    //Keep in mind we need to also set up our baudRate generator 

    //Set up inputs
    reg clk; 
    reg rst_gen; 

    //Outputs
    wire outBaud;  

    //Intialize object
    baudRate gen(
        .rst(rst_gen),
        .clk(clk),
        .outBaud(outBaud)        
    );

    reg baudRate; 

    //First we need to set up our inputs
    reg rst; 
    reg bitStream; 

    //Now lets setup our outputs
    wire [7:0] dataOut; 
    wire readDone; 

    //Now lets intialize our model
    receiver_uart rU(
        .baudRate(outBaud), 
        .rst(rst), 
        .bitStream(bitStream), 
        .dataOut(dataOut), 
        .readDone(readDone)
    );

    initial begin 
        clk = 0; 
        baudRate = 0; 
        bitStream = 1;

        rst_gen = 0; 
        rst = 0;  
    end


    always #52083 baudRate = ~baudRate;

    always #5 clk = ~clk; 

    initial begin
        $dumpvars(0, tb_uart_receiver); 
        //Now lets run the clock for 5 cycles
        repeat (5) @(posedge baudRate);

        //Now lets start the transmission process

        //Start Bit
        bitStream = 0; 
        @(posedge baudRate);

        //Data Bits (8)
        bitStream = 0; 
        @(posedge baudRate);

        bitStream = 1; 
        @(posedge baudRate);

        bitStream = 1; 
        @(posedge baudRate);

        bitStream = 0; 
        @(posedge baudRate);

        bitStream = 1; 
        @(posedge baudRate);

        bitStream = 0; 
        @(posedge baudRate);

        bitStream = 1; 
        @(posedge baudRate);

        bitStream = 1; 
        @(posedge baudRate);

        //Stop bit 
        bitStream = 1; 
        @(posedge baudRate);

        $finish; 


    end

    

    



endmodule