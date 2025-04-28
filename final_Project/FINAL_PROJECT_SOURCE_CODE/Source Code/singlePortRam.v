module singlePortRam(clk, wren, addressIn, writeIn, readOut); 
    input clk; 
    input wren; 
    input [15:0] addressIn; 
    input [15:0] writeIn; 
    output reg [15:0] readOut; 
    
    parameter depth = 5000;
    parameter width = 16;
    
    (* ram_style = "block" *) reg [width-1:0] memory [0:depth-1];
    
    always @(posedge clk) begin 
        if (wren) begin 
            memory[addressIn] <= writeIn; // use <= for better synthesis behavior
        end
        
        if (addressIn <= 5000) begin 
            readOut <= memory[addressIn];
        end else begin 
            readOut <= 0;
        end
    end
endmodule
