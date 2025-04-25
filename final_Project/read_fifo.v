module read_fifo(signalReady, dataIn, readBegin, clk, dataOut, rxDone, segments, digits, rst, led, btnRight, memoryReadData, memoryReadAddress);
    input signalReady; 
    input [7:0] dataIn;
    input readBegin;  
    input clk;

    //Input for RAM
    input btnRight; 
    input [10:0] memoryReadData; 
    

    //Output for RAM 
    output reg [10:0] memoryReadAddress; 

    //Set up inputs for ssd
    input rst; 
    output wire [0:6] segments; 
    output wire [7:0] digits;

    //output reg [15:0] dataOut; 
    (* keep = "true" *) output  reg [15:0] dataOut;
    (* keep = "true" *) output reg rxDone; 
    output reg led; 

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

    //Register for ram
    reg [10:0] ramCounter; 
    reg [31:0] ramTotal;
    //Make the states

    //The idea for the states is that we should enter an idle state when we don't need to be reciving any data
    //The next state is the load state where we essentially take in the byte of memory and put it in the fifo
    //The last state is the passover state where we will give all the data to the main code to decode and well worry about that later
    //We also might need a wait state to wait for signals to go low 

    parameter sIdle = 0, sLoad = 1, sPassover = 2, sWait = 3, sCalc = 4, sRam = 5;  

    reg [2:0] state, stateNext; 


    always @(posedge clk) begin 
        //Default
        state = stateNext; 

        
        //Case statements
        case(state) 
            sIdle: begin
                rxDone = 0;  
                dataOut = 0; 
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
                        //Ram resets
                        ramCounter = 0;
                        ramTotal = 0;
                        memoryReadAddress = 0;

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

                        // Split RPM into decimal digits
                        rpmThousands = (dataOut / 1000) % 10;
                        rpmHundreds  = (dataOut / 100) % 10;
                        rpmTens      = (dataOut / 10) % 10;
                        rpmOnes      = (dataOut / 1) % 10;
                        
                        stateNext = sIdle; 
                        rxDone = 0; 
                        
                    end else if (byteRegister[1] == 8'h05) begin
                        dataOut = byteRegister[2] - 40; 
                        

                        // Split temperature into decimal digits
                        tempTens = (dataOut / 10) % 10;
                        tempOnes = (dataOut / 1) % 10;

                        if (ramCounter < 1024) begin //read 1024 values
                            ramTotal = ramTotal + memoryReadData;  // Accumulate the sum
                            memoryReadAddress = ramCounter + 1; // Go to the next address
                            ramCounter = ramCounter + 1;
                        end 
                        
                        stateNext = sIdle; 
                        rxDone = 1; 
                    end
                end else begin 
                    rxDone = 1; 
                    stateNext = sIdle;
                end

                 
            end

           

            default: begin 
                stateNext = sIdle; 
            end
        endcase



        // State to read from memory
            if (rst) begin
                ramCounter = 0;
                ramTotal = 0;
                memoryReadAddress = 0;
            end else begin
                dataOut = ramTotal; // Output the total
            end

            if (btnRight) begin 
                led = 1; 
                rpmThousands = (ramTotal / 1000) % 10;
                rpmHundreds  = (ramTotal / 100) % 10;
                rpmTens      = (ramTotal / 10) % 10;
                rpmOnes      = (ramTotal / 1) % 10;
            end

    end
   

endmodule
