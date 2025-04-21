

module fpgaMain_read(clk, dataInSignal, dataIn, writeOut, rst);
    //Insert INputs here
    input clk;
    input dataInSignal; //This should be fifo blip
    input [15:0] dataIn;
    input rst; 
    
    //Inputs for RAM
    reg [15:0] address; 
    reg writeEnable;

    //Outputs for RAM 
    output [15:0] writeOut; 

    //States
    parameter sIdle = 0, sLoad = 1, sBegin = 2; ; 

    reg [1:0] state, stateNext; 
    reg prevBit, currBit; 

    //Initialize singleport ram module: 
    singlePortRam ram(
        .clk(clk), 
        .writeEnable(writeEnable), 
        .address(address), 
        .writeIn(dataIn), 
        .writeOut(writeOut) 
    ); 

   

    always @(posedge clk) begin 
        //Update state
        state = stateNext; 

        currBit = dataInSignal;
        //Here we should just load in the data into the ram 
        case(state) 
            sBegin: begin 
                if (currBit == 0 && prevBit == 1) begin 
                    //Now we can go to the next state
                    stateNext = sLoad; 
                    writeEnable = 1;
                end
            end
            sIdle: begin 
                //here we need to set the write enable to 0
                writeEnable = 0; 

                //Now we need to detect a drop or negedge in dataInSignal
                if (currBit == 0 && prevBit == 1) begin 
                    //Now we can go to the next state
                    stateNext = sLoad; 
                    writeEnable = 1;
                end

            end

            sLoad: begin 
                address = address + 1; 
                stateNext = sIdle; 
            end 

            default: begin
                stateNext = sBegin; 
                address = 0; 
            end

        endcase



        //update prevbit
        prevBit = currBit;
    end


endmodule