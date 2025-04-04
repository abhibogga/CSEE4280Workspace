module transmit_uart(dataIn, rst, clk, bitStream, txDone);

    //Declare inputs here 
    input [7:0] dataIn; 
    input rst; 
    input clk; //This will be the baudRateGen so 153.6k bps 

    //Delcare outputs here
    output reg bitStream; 
    output reg txDone; 


    //Delcare other variables here
    reg [4:0] counter; 
    reg [3:0] datCounter; 
    reg [9:0] inputStream; 

    

    /*
        In terms of machine movment I think there should be 4 states
        - The first state is the idle state, that keeps bitstream high until rst is low
        - The next state should be the state that runs the transmit process, it will send out the start bit 
            and the data bits as well as the stop bit, hopefully this works
    */

    //Declare states
    parameter sIdle = 0, sTransmit = 1; 

    reg state, stateNext; 

    //Moving states
    always @(posedge clk) begin
        state <= stateNext; 
    end

    //Case statements
    always @(posedge clk) begin
        case (state)

            sIdle: begin
                //Here we just need to keep bitstream high until rst goes low
                if (rst == 0) begin
                    stateNext = sTransmit; 
                    //Set up rest of the outputs
                    txDone = 0; 
                    datCounter = 0; 
                    counter = 0; 

                    //Setup input stream 
                    inputStream[9] = 1;
                    inputStream[8:1] = dataIn;
                    inputStream[0] = 0; 
                    
                end else begin
                    stateNext = sIdle; 
                    bitStream = 1; 
                end
            end

            sTransmit: begin 
                if (datCounter < 10 ) begin 
                    //This means we need to keep going back to here
                    if (counter < 7) begin 
                        bitStream = inputStream[datCounter]; 
                        counter = counter + 1; 
                    end else begin 
                        $display(inputStream[datCounter]);
                        datCounter = datCounter + 1; 
                        counter = 0; 
                    end 
                    stateNext = sTransmit; 
                end else begin 
                    //This means that we are done with tranmission so we can let the FIFO know we are done
                    $display("Reached here");
                    txDone = 1; 
                    stateNext = sIdle; 
                    
                end
            end

            default: begin 
                stateNext = sIdle; 
            end

        endcase

    end

    

endmodule
