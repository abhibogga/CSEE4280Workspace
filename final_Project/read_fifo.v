
module read_fifo(signalReady, dataIn, readBegin, clk, dataOut, rxDone, segments, digits, rst, led, greenLed, redLed);
    input signalReady; 
    input [7:0] dataIn;
    input readBegin;  
    input clk;

   
    //Set up inputs for ssd
    input rst; 
    output wire [0:6] segments; 
    output wire [7:0] digits;
    
    //Ouputs for RAM
    output reg redLed; 
    output reg greenLed; 

    //output reg [15:0] dataOut; 
    (* keep = "true" *) output  reg [15:0] dataOut;
    (* keep = "true" *) output reg rxDone; 
    output reg led; 
    
    //Lets define the RAM the right way!
    //First we need to know what we need, the inputs are -> write enable, address, dataIn, clk | outputs are -> writeOut
    //First lets define write enable, this only needs to be a register since its just turning on and off wheater we are adding to this array
    reg writeEnable; 
    
    //Next we need to define our address, this also needs to be a register that moves up and down depending on what we want to write to the     
    reg [15:0] addressCounter; 
    
    //Now we need some sort of wire to store read out  and readIn variable
    wire [15:0] readOut; 
    reg [15:0] readIn;
    
    //Now lets define the module
    singlePortRam ram(
        .clk(clk), 
        .wren(writeEnable), 
        .addressIn(addressCounter), 
        .writeIn(readIn), 
        .readOut(readOut)
    );
    
    
    //Function for LUT
    function [3:0] ascii_to_hex;
        input [7:0] ascii_char;
        begin
            case (ascii_char)
                8'h30: ascii_to_hex = 4'h0;  // '0'
                8'h31: ascii_to_hex = 4'h1;  // '1'
                8'h32: ascii_to_hex = 4'h2;  // '2'
                8'h33: ascii_to_hex = 4'h3;  // '3'
                8'h34: ascii_to_hex = 4'h4;  // '4'
                8'h35: ascii_to_hex = 4'h5;  // '5'
                8'h36: ascii_to_hex = 4'h6;  // '6'
                8'h37: ascii_to_hex = 4'h7;  // '7'
                8'h38: ascii_to_hex = 4'h8;  // '8'
                8'h39: ascii_to_hex = 4'h9;  // '9'
                8'h41: ascii_to_hex = 4'hA;  // 'A'
                8'h42: ascii_to_hex = 4'hB;  // 'B'
                8'h43: ascii_to_hex = 4'hC;  // 'C'
                8'h44: ascii_to_hex = 4'hD;  // 'D'
                8'h45: ascii_to_hex = 4'hE;  // 'E'
                8'h46: ascii_to_hex = 4'hF;  // 'F'
                8'h61: ascii_to_hex = 4'hA;  // 'a'
                8'h62: ascii_to_hex = 4'hB;  // 'b'
                8'h63: ascii_to_hex = 4'hC;  // 'c'
                8'h64: ascii_to_hex = 4'hD;  // 'd'
                8'h65: ascii_to_hex = 4'hE;  // 'e'
                8'h66: ascii_to_hex = 4'hF;  // 'f'
                default: ascii_to_hex = 4'h0;
            endcase
        end
    endfunction

    reg [3:0] rpmOnes, rpmTens, rpmHundreds, rpmThousands;
    reg [3:0] tempOnes, tempTens;

    //Initialize the ssd module

    ssd ssd (
        .clk(clk), 
        .rst(rst), 
        .rpmOnes(rpmOnes), 
        .rpmTens(rpmTens), 
        .rpmHundreds(rpmHundreds), 
        .rpmThousands(rpmThousands), 
        .tempOnes(tempOnes), 
        .tempTens(tempTens),
        .seg(segments), 
        .digit(digits)

    );


    //Make registers here: 
    reg [7:0] fifoRegister [0:31];
    reg [7:0] byteRegister [0:8];

    reg [5:0] counter; 
    reg [5:0] byteCounter;

    reg [5:0] passoverCounter;
    reg [5:0] insertCounter;   

    reg [3:0] topNibble; 
    reg [3:0] bottomNibble; 
    reg [7:0] fullByte; 
    
    reg [7:0] rpmParam1; 
    reg [7:0] rpmParam2; 

    reg [7:0] coolantParam; 

    reg nibbleFormed; 
    reg coolantFound; 
    reg rpmFound; 

    
    //Make the states

    //The idea for the states is that we should enter an idle state when we don't need to be reciving any data
    //The next state is the load state where we essentially take in the byte of memory and put it in the fifo
    //The last state is the passover state where we will give all the data to the main code to decode and well worry about that later
    //We also might need a wait state to wait for signals to go low 

    parameter sIdle = 0, sLoad = 1, sPassover = 2, sWait = 3, sCalc = 4, sRam = 5, sWaitRam = 6;  

    reg [2:0] state, stateNext; 


    always @(posedge clk) begin 
        //Default
        if (rst) begin
            state <= sIdle;
            addressCounter <= 0;
            rxDone <= 0;
            writeEnable <= 0;
            led <= 0;
            dataOut <= 0;
            greenLed <= 0;
            redLed <= 0;
        end else begin
            state <= stateNext; 
        end 

        
        //Case statements
        case(state) 
            sIdle: begin
                rxDone = 0;  
                dataOut = 0; 
                
                
                //Lets load in the ram Parameters
                writeEnable = 0; 
                
                //For this we need to watch the signalReady input
                if (readBegin) begin 
                    //This means that we are ready to accept data and we need to move into the next state; 
                    counter = 0; 
                    
                    led = 0; 
                    stateNext = sLoad; 
                end else begin 
                    stateNext = sIdle; 
                    rxDone = 0; 
                end
            end

            sLoad: begin
                if (signalReady) begin
                    led = 1; 
                    
                    //Now what we need to do is look for the dataOut
                    if (dataIn == 8'h3E) begin 
                        //rpmTens = 5; 
                        //This means that we can take the data from fifoRegister and start decoding it
                        fifoRegister[counter] = dataIn; 
                        counter = counter + 1; 
                        stateNext = sPassover; 

                        coolantFound = 0; 
                        rpmFound = 0; 
                        passoverCounter = 0;
                        insertCounter = 0;  
                        byteCounter = 0;

                        

                    end else begin
                        $display("dataIn", dataIn);
                        stateNext = sWait; 
                        //Now what we need to do is load in the data and send the fsm to a wait state
                        //Load the new data in 
                        fifoRegister[counter] = dataIn; 
                        counter = counter + 1; 
                    end
                end else begin 
                    stateNext = sLoad; 
                end
            end

            sWait: begin 
                if (signalReady) begin 
                    stateNext = sWait; 
                end else begin 
                    stateNext = sLoad; 
                end
            end

            sPassover: begin 
                //Now in the passover phase what we need to do is use a lookup table to find what things we need to send over
                if (passoverCounter < counter) begin
                    stateNext = sPassover; 
                    
                    //Now we need to build up our nibbles
                    if (fifoRegister[passoverCounter] != 8'h20 && fifoRegister[passoverCounter] != 8'h0D && fifoRegister[passoverCounter] != 8'h3E) begin 
                        $display("fifoReg:", fifoRegister[passoverCounter], " passoverCounter", passoverCounter);
                        if (insertCounter % 2 == 0) begin 
                            //This means that it is even so it will go in firstNibble
                            topNibble = ascii_to_hex(fifoRegister[passoverCounter]);
                            
                            insertCounter = insertCounter + 1; 
                            passoverCounter = passoverCounter + 1; 
                        end else if (insertCounter % 2 == 1) begin 
                            //This means that it is odd so it should fill out the second nibble and analyze
                            bottomNibble = ascii_to_hex(fifoRegister[passoverCounter]);

                            insertCounter = insertCounter + 1; 
                            passoverCounter = passoverCounter + 1; 

                            //Now lets build our byte
                            fullByte = {topNibble, bottomNibble}; 
                            
                            byteRegister[byteCounter] = fullByte; 
                            byteCounter = byteCounter + 1; 
                        end
                    end else begin 
                        passoverCounter = passoverCounter + 1; 
                    end 

                end else begin 
                    stateNext = sCalc; 
                end
            
            end

            sCalc: begin 
                if (byteRegister[0] == 8'h41) begin 
                    if (byteRegister[1] == 8'h0C) begin 
                        dataOut = (((byteRegister[2] << 8) | byteRegister[3]) >> 2);
                        
                        //Now lets update Read in
                        readIn = dataOut; 
                        
                        //Now lets turn writeEnable high: 
                        writeEnable = 1; 

                        // Split RPM into decimal digits
                        rpmThousands = (dataOut / 1000) % 10;
                        rpmHundreds  = (dataOut / 100) % 10;
                        rpmTens      = (dataOut / 10) % 10;
                        rpmOnes      = (dataOut / 1) % 10;
                        
                        stateNext = sWaitRam; 
                        rxDone = 1; 
                        
                        //Now that we have our data in data Out
                        
                    end else if (byteRegister[1] == 8'h05) begin
                        dataOut = byteRegister[2] - 40; 
                        

                        // Split temperature into decimal digits
                        tempTens = (dataOut / 10) % 10;
                        tempOnes = (dataOut / 1) % 10;
                        
                        stateNext = sIdle; 
                        rxDone = 1; 
                                                           
                    end
                end else begin 
                    rxDone = 1; 
                    stateNext = sIdle;
                end

                 
            end
            
            
            sWaitRam: begin 
                stateNext = sRam; 
            end
            
            sRam: begin 
                //Here we need to turn off write enable and update our counter
                //Before we do all that we need to figure out what we need to do with that ram tho, so we need to read from it
                
                if (readOut > 5000) begin 
                    greenLed = 0; 
                    redLed = 1; 
                end else begin 
                    greenLed = 1; 
                    redLed = 0; 
                end
                
                //Now lets update address counter
                addressCounter = addressCounter + 1; 
                
                stateNext = sIdle; 
                
            end


            default: begin 
                stateNext = sIdle; 
                //Ram resets
                addressCounter = 0; 
            end
        endcase


    end
   

endmodule
