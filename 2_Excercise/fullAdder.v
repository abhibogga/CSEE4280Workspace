module fullAdder(a, b, cIn, sum, cOut);

//Define Inputs
input [3:0] a, b;
input cIn;

//Define Outputs
output reg [3:0] sum; //We need this to be a reg since it is begin changed within an @always block
output reg cOut; 

//Define wires or midway points
reg [4:0] tempOutput; //We need this to be a reg since it is begin changed within an @always block


always @(*) begin //The always @ (x) is for setting up a conditional, the * indicates that this points towards all inputs and outputs, think "when x changes, this block will activate"
    //Here we want to describe what we need to happen for the full adder to work 
    tempOutput = a + b;
    tempOutput = tempOutput + cIn; 

    sum = tempOutput[3:0];
    cOut = tempOutput[4];
end

endmodule 