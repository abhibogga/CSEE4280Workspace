`timescale 1ns/1ns
`include "fullAdder.v"
module tb_fullAdder(); //Keep in mind that most tb will not have any sort of parameters

    //Define inputs 
    reg [3:0] a_tb,b_tb; //There are no inputs and outputs in a tb file since all of that is determined by the module you are using
    reg cIn_tb;

    //Define outputs
    wire [3:0] sum_tb; //We must use wires here since they are the outputs of a module
    wire cOut_tb; //wire and reg cannot be used in the same statement, they are just meant for different purposes

    //define the clock statement
    reg Clk_s;

    //Initialize the module
    fullAdder fa (
        .a(a_tb),
        .b(b_tb),
        .cIn(cIn_tb),
        .sum(sum_tb),
        .cOut(cOut_tb)
    );
    //Clock, we want to be able to cycle out the test cases
    always begin
        Clk_s <= 0;
        #10;
        Clk_s <= 1;
        #10;
    end

    initial begin //When we are making a testbench we want to make our test cases with an intial begin, keep in mind that intial begin cannot be synthsized onto FPGA
        $dumpvars(0, tb_fullAdder);

        // Test case 1
        a_tb = 4'b0000; b_tb = 4'b0000; cIn_tb = 1'b0;
        @(posedge Clk_s);

        // Test case 2
        a_tb = 4'b1111; b_tb = 4'b1111; cIn_tb = 1'b0;
        @(posedge Clk_s);

        // Test case 3
        a_tb = 4'b1010; b_tb = 4'b1100; cIn_tb = 1'b1;
        @(posedge Clk_s);

        // Test case 4
        a_tb = 4'b1111; b_tb = 4'b0001; cIn_tb = 1'b1;
        @(posedge Clk_s);

        // Test case 5
        a_tb = 4'b0001; b_tb = 4'b0001; cIn_tb = 1'b0;
        @(posedge Clk_s);

        // Test case 6
        a_tb = 4'b1001; b_tb = 4'b0110; cIn_tb = 1'b1;
        @(posedge Clk_s);

        // Finish simulation
        $finish;
    end
endmodule