`include "primeNumber.v"
`timescale 1ns/1ns

module tb_primeNumber(); 

    //Define the inputs as reg
    reg [10:0] numMax;
    reg clk; 
    reg rst;


    //Define the outputs as wires
    wire [10:0] prime; //Again we only need 10 bits but we'll use 11 just in case
    wire [10:0] numberChecked; 
    wire [10:0] numberOfPrimes; //There is no need for this many bits to be used, if we were to optimize this project, than maybe this number would be smaller


    //Initialize primeNumber module
    primeNumber pn(
        .numMax(numMax), 
        .clk(clk), 
        .rst(rst), 

        .prime(prime), 
        .numberChecked(numberChecked), 
        .numberOfPrimes(numberOfPrimes)
    );


    //Start the clock
    always begin
        clk = 1; 
        #10;
        clk = 0;
        #10;
    end

    integer i, j; 
    //Start the test cases
    initial begin
        $dumpvars(0, tb_primeNumber);
        /*
        for (i = 0; i < 2; i++) begin //This will be the input for numMax
            numMax = i; 
            rst = 0; 

            //Now we need to run the clock cycles since this is a flop based design
            for (j = 0; j < i + 1; j++) begin 
                @(posedge clk);
            end
        end
        */



        //Singular Test Cases
        numMax = 100; 
        rst = 0; 

        //Now we need to run the clock cycles since this is a flop based design
        for (j = 0; j <  numMax+ 1; j++) begin 
            @(posedge clk);
        end

        $finish;
    end




endmodule