`timescale 1ns/1ns
`include "../transmit_uart.v"
`include "../baudRate.v"
`include "../transmit_fifo.v"
module tb_sendAtzTransmit();
    /**For this test bench what i want to aim for is to be able to use the transmit fifo to pass in the command 
        sequence for the initialization sequence for the ECU
        Here this sequence is ATZ. But in reality the string of 8 bit code will look like this: 
        ascii a: 0x61 || 0b01100001 -- Transmitted in BCD
        ascii t: 0x74 || 0b01110100 -- Transmitted in BCD
        acsii z: 0x7A || 0b01111010 -- Transmitted in BCD
    **/


    //First lets make our FIFO needs inputs are reg and outputs are wires
    reg clk; 
    reg [7:0] writeIn; 
    reg writeReady; 

    wire [7:0] writeOut; 
    wire writeFinished; 

    //Now lets make the inputs and outputs that the transmit module needs 
    wire bitStream; 
    wire txDone; 

    //Now lets make the baudRate gen inputs and outputs
    reg baudRst; 
    wire outBaud; 

    //Now we need to make our modules
    transmit_uart uartController(
        .dataIn(writeOut), 
        .rst(~writeFinished), 
        .clk(outBaud), 
        .bitStream(bitStream), 
        .txDone(txDone)
    );

    baudRate bd(
        .clk(clk),
        .rst(baudRst),
        .outBaud(outBaud)
    );

    transmit_fifo fifo(
        .writeIn(writeIn), 
        .writeReady(writeReady),
        .writeDone(txDone), 
        .writeOut(writeOut), 
        .writeFinished(writeFinished), 
        .clk(clk)
    );

    //Move clocks
    always #5 clk = ~clk;


    initial begin 
        $dumpvars(0,tb_sendAtzTransmit);
        
        //For now lets just see what we want and we can add in some real time changes later
        

        //lets set what we need first
        clk = 1; 

        //Keep in mind that writeReady is controlling this whole process
        writeReady = 0;

        //Run the clock 
        #100;

        //now drop writeReady
        writeIn =  8'b01100001;
        writeReady = 1; 
        #50
        writeReady = 0;
        #2500000;
         
        #2500000;
        writeReady = 1;
        #50 
        writeReady = 0; 
        writeIn =  8'b01100001;
        #2500000;

        

        $finish;
    end

    

    

endmodule