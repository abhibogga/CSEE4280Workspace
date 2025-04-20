`timescale 1ns/1ns
`include "../transmit_uart.v"
`include "../baudRate.v"
`include "../transmit_fifo.v"
`include "../fpgaMain_transmit.v"
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

    //Now lets make the transmit fpga module
     // Inputs
    reg [3:0] switchInputs;

    wire fifoBlip;
    wire [7:0] dataOut;

    //Now we need to make our modules

    fpgaMain_transmit uut (
        .switchInputs(switchInputs),
        .clk(clk),
        .listenTx(txDone),
        .fifoBlip(fifoBlip),
        .dataOut(dataOut)
    );

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
        .writeIn(dataOut), 
        .writeReady(fifoBlip),
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
        

        //Run the clock 
        #100;
        switchInputs = 5'b00000;
        switchInputs[3] = 1'b1;
    #25000000
        


        

        $finish;
    end

    

    

endmodule