module singlePortRam(clk, writeEnable, dataIn, greenLed, redLed, readAddress, readOut, rst);

    //Lets define inputs here
    input clk;
    input writeEnable;
    input [15:0] dataIn;
    input [10:0] readAddress; // Changed to 11 bits
    input rst; 

    //Lets define outputs here
    output reg greenLed;
    output reg redLed;
    output reg [10:0] readOut;

    //Constants in module
    parameter depth = 2048;         // 2K blocks
    parameter width = 16;           // 16 bits per word

    // Lets delcare the type of ram we are doing, this is a vivado directive
    reg [width-1:0] ram [0:depth-1];

    //Lets define states here:
    reg state, stateNext;
    reg [10:0] address; // Added address register
    parameter sLoad = 0, sIdle = 1;

    //State machine
    always @(posedge clk) begin
        state = stateNext;
        case (state)
            sIdle: begin
                address = 0;
                stateNext = sLoad;
            end
            sLoad: begin
                if (writeEnable) begin
                    ram[address] <= dataIn; // Use address for writing
                    address = address + 1;
                end
                if (address < depth) begin
                    greenLed = 1;
                    redLed = 0;
                end else begin
                    greenLed = 0;
                    redLed = 1;
                end
            end
            default: begin
                stateNext = sIdle;
            end
        endcase
    end

    //Read side
    always @(posedge clk) begin
        readOut <= ram [readAddress];
    end
endmodule