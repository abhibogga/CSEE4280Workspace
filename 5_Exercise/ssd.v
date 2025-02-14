module ssd(switches, clk, commonAnode, sevenSeg); 

    // Define the inputs here
    input [15:0] switches; 
    input clk; 

    output reg [6:0] commonAnode; 
    output reg [6:0] sevenSeg; 

    // Define counter here
    reg [3:0] counter; 

    always @(posedge clk) begin 
        if (switches > 1) begin 
            commonAnode[0] <= 1; 
            commonAnode[1] <= 1;
            commonAnode[2] <= 1;
            commonAnode[3] <= 1;
            commonAnode[4] <= 1;
            commonAnode[5] <= 1;
            commonAnode[6] <= 1;
        end else begin
            commonAnode <= 7'b0; // Reset commonAnode if switches <= 1
        end

        sevenSeg <= 7'b0; // This is fine if you want to reset sevenSeg on every clock cycle
    end
    

endmodule