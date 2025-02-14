module ssd(switches, clk, commonAnode, sevenSeg); 

    // Define the inputs here
    input [15:0] switches; 
    input clk; 

    output reg [6:0] commonAnode; 
    output reg [6:0] sevenSeg; 

    // Define counter here
    reg [3:0] counter; 

    always @(posedge clk) begin 
        if (counter == 8) begin
            counter = 2; 
        end else begin 
            counter = counter + 1; 
        end

        
    end
    
    
    

endmodule