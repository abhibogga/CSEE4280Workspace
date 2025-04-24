module singlePortRam(clk, writeEnable, address, writeIn, greenLed, redLed);

    //Lets define inputs here
    input clk;
    input writeEnable;
    input [10:0] address;        // 11 bits = 2048 locations
    input [15:0] writeIn;

    //Lets define outputs here
    output reg greenLed;
    output reg redLed; 

    //Constants in module
    parameter depth = 2048;      // 2K blocks
    parameter width = 16;        // 16 bits per word

    // Lets delcare the type of ram we are doing, this is a vivado directive
    (* ram_style = "block" *) reg [width-1:0] ram [0:depth-1];

    //State machine
    always @(posedge clk) begin
        if (writeEnable) begin
            ram[address] <= writeIn;
        end

        if (address < depth) begin
            greenLed = 1; 
            redLed = 0; 
        end else begin
            greenLed = 0; 
            redLed = 1; 
        end
    end

endmodule
