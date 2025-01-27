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
        Clk = 0;
        #1;
        Clk = 1; 
        #1;
    end

    integer i, j;
   // Test cases
    initial begin
        $dumpvars(0, tb_fourFullAdder); // To capture waveform data

        //Set the a input value
        a = 1;

        for (i = 0; i <= 15; i = i + 1) begin
            b = {i, 8'b00000000};

            cIn = 0;
            //Run the test case
            @(posedge Clk);

            //Check if it is equivalent or not
            if (a + {i, 8'b00000000} != sumFinal) begin
                $display("You Failed!: a=%d, b=%d, Value Expected=%d, Got=%d", a, {i, 8'b00000000}, a + i, sumFinal);
            end
        end
        
        // Forcing an error

        a = 16'b0000000000000000;
        b = 16'b0000000000000000; //We want blocking assingment so it is sequential logic
        cIn = 0;
        @(posedge Clk);

        //Forced error
        if (10 != sumFinal) begin
                    $display("You Failed!: a=%d, b=%d, Value Expected=%d, Got=%d", i, j, i + j, sumFinal);
        end
        /*
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
        
        a = 16'b1100101110101001;
        b = 16'b1000011101100101;
        cIn = 0;
        @(posedge Clk);
        */

        

        // Finish simulation
        $finish;
    end


endmodule