module readRam(clk, addressIn, averageOut, parseReady); 

    //Lets define the inputs here
    input [15:0] addressIn; 
    input clk; 
    input parseReady; 

    //Lets define the outputs here
    output [15:0] averageOut; 


    //Lets define states here 
    parameter sIdle = 0, sLoad = 1, sWait = 2;  

    reg [1:0] state, stateNext; 

    reg [11:0] regLocations;
    reg [11:0] avgCounter; 

    //FSM
    always @(posedge clk) begin 
        state = stateNext; 

        case (state) 
            sIdle: begin 
                averageOut = 0; 
                regLocations = 0; 
                avgCounter = 0;
            end


        endcase
    end
    

endmodule