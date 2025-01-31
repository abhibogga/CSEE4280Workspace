`include "primeNumber.v"
`timescale 1ns/1ns

module tb_primeNumber(); 

    //Define the inputs as reg
    reg [10:0] numMax;
    reg clk; 
    reg rst;


    //Define the outputs as wires
    wire prime; //Again we only need 10 bits but we'll use 11 just in case
    wire [10:0] numberChecked; 
    wire [10:0] numberOfPrimes; //There is no need for this many bits to be used, if we were to optimize this project, than maybe this number would be smaller

    //Create a reg to prove that it is correct or not. 

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

    integer k, primeOrNah;

    always @(numberChecked) begin
        if (numberChecked <= 1) begin
            primeOrNah = 0;  // Not prime
        end 
        else if (numberChecked <= 3) begin
            primeOrNah = 1;  // 2 and 3 are prime
        end 
        else if (numberChecked % 2 == 0) begin
            primeOrNah = 0;  // Even numbers (except 2) are not prime
        end 
        else begin
            primeOrNah = 1;  // Assume prime
            for (k = 3; k * k <= numberChecked; k = k + 2) begin
                if (numberChecked % k == 0) begin
                    primeOrNah = 0;  // Found a divisor, not prime
                end
            end
        end
    end

    integer i, j; 
    //Start the test cases
    initial begin
        $dumpvars(0, tb_primeNumber);


        //Singular Test Cases
        numMax = 100; 
        rst = 0; 

        //Now we need to run the clock cycles since this is a flop based design
        for (j = 0; j < numMax+1; j++) begin 
            @(posedge clk);
        end

        

        $finish;
    end




endmodule