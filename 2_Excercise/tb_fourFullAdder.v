`timescale 1ns/1ns
`include "fourFullAdder.v"
module tb_fourFullAdder(); 

    //Initalize the registers
    reg [15:0] a; 
    reg [15:0] b;
    reg cIn; 

    //Initalize the wires (outputs)
    wire [3:0] cOutFinal; 
    wire [15:0] sumFinal;

    //Intialize a fourFullAdderObject
    fourFullAdder fa(
        .a(a), 
        .b(b),
        .cIn(cIn),
        .cOutFinal(cOutFinal),
        .sumFinal(sumFinal)
    );
    
    //Define the clock 
    reg Clk; 

    //Get clock going
    always begin 
        Clk <= 0;
        #1;
        Clk <= 1; //Here i am using the non blocking since i am in one of those blocks
        #1;
    end

   // Test cases
    initial begin
        $dumpvars(0, tb_fourFullAdder); // To capture waveform data
        /*
        // Test case 1: Add 0 + 0 with carry-in 0
        a = 16'b0000000000000000;
        b = 16'b0000000000000000; //We want blocking assingment so it is sequential logic
        cIn = 0;
        @(posedge Clk);

        // Test case 2: Add maximum values without carry-in
        a = 16'b1111111111111111;
        b = 16'b1111111111111111;
        cIn = 0;
        @(posedge Clk);

        // Test case 3: Add maximum values with carry-in
        a = 16'b1111111111111111;
        b = 16'b1111111111111111;
        cIn = 1;
        @(posedge Clk);

        // Test case 4: Add random values
        a = 16'b1010101010101010;
        b = 16'b0101010101010101;
        cIn = 1;
        @(posedge Clk);

        // Test case 5: Add alternating bits
        a = 16'b0000111100001111;
        b = 16'b1111000011110000;
        cIn = 0;
        */
        a = 16'b1100101110101001;
        b = 16'b1000011101100101;
        cIn = 0;
        @(posedge Clk);

        // Finish simulation
        $finish;
    end


endmodule