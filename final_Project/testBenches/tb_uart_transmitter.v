`timescale 1ns/1ns
`include "../transmit_uart.v"
`include "../baudRate.v"
module tb_uart_transmitter();
    //Inputs for baudRate
    reg clk;
    reg clkRst; 

    //Outputs for baudRate
    wire outBaud; 

    //Init baudRate controller
    baudRate baudRate(
        .clk(clk), 
        .outBaud(outBaud), 
        .rst(clkRst)
    );

    //Lets declare inputs for transmitter
    reg [7:0] dataIn; 
    reg rst; 

    //Declare outputs for transmitter
    wire bitStream; 
    wire txDone; 

    //Init module
    transmit_uart transmitter(
        .dataIn(dataIn), 
        .rst(rst), 
        .clk(outBaud), 
        .bitStream(bitStream), 
        .txDone(txDone)
    );

    //Make ref 9600 clk
    reg pwm; 

    //Move clocks
    always #52083 pwm = ~pwm;

    always #5 clk = ~clk;

    //Set up intial conditions: 
    initial begin
        $dumpvars(0, tb_uart_transmitter);  
        clk = 1; 

        clkRst = 1; // Assert reset
        rst = 1; 
        dataIn = 8'b10001001;


        clkRst = 0; // Deassert reset
        rst = 0; 

         @(posedge txDone) begin 
            rst = 1; // Reassert reset after transmission is done
         end
        #2500000; // Run for a while
        $finish;
    end


    

    
endmodule

