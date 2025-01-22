
`include "fullAdder.v"
module fourFullAdder(a, b, cIn, cOutFinal, sumFinal);

    //Initalize all the inputs
    input [15:0] a, b;
    input cIn;


    //Intialize all the wires since we are moving from one module to another
    wire [3:0] cOut; //These must be wire since they are the output of a fullAdder operation
    wire [15:0] sum;


    //Initailze all outputs
    output reg [3:0] cOutFinal;
    output reg [15:0] sumFinal;

    //Now we need to make sure that all the modules for the full adders are correctly made
    fullAdder zeroToThree (
        .a(a[3:0]),
        .b(b[3:0]),
        .cIn(cIn),
        .cOut(cOut[0]),
        .sum(sum[3:0])
    );

    fullAdder fourToSeven (
        .a(a[7:4]),
        .b(b[7:4]),
        .cIn(cOut[0]),
        .cOut(cOut[1]),
        .sum(sum[7:4])
    );

    fullAdder eightToEleven (
        .a(a[11:8]),
        .b(b[11:8]),
        .cIn(cOut[1]),
        .cOut(cOut[2]),
        .sum(sum[11:8])
    );


    fullAdder twelveToFifteen (
        .a(a[15:12]),
        .b(b[15:12]),
        .cIn(cOut[2]),
        .cOut(cOut[3]),
        .sum(sum[15:12])
    );

    //Whenever a change is detected, lets update our final updates
    always @(*) begin
        cOutFinal =  cOut;
        sumFinal = sum; 
    end


endmodule