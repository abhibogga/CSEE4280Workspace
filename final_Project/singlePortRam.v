module singlePortRam(clk, writeEnable, address, writeIn, writeOut); 
  
    //Lets define the inputs here
    input clk; 
    input writeEnable; 
    input [15:0] address; 
    input [15:0] writeIn; 

    //Lets define outputs here
    output reg [15:0] writeOut; 

    parameter depth = 500; //500 Memory Locations
    parameter width = 16; //Each block is 16 bits wide

    (* ram_style = "block" *) reg [width - 1: 0] ram [0:depth - 1]; //Initializes the BRAM with vivado directive

    always @(posedge clk) begin 
        if (writeEnable) begin 
            ram[address] <= writeIn;
        end

        if (address < depth) begin 
            writeOut <= ram[address]; 
        end else begin 
            writeOut <= 0;
        end
    end
endmodule
