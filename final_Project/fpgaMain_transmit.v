module fpgaMain_transmit(switchInputs, clk, listenTx, fifoBlip, dataOut);
    input [3:0] switchInputs;
    input clk;
    input listenTx;

    output reg fifoBlip;
    output reg [7:0] dataOut;

    parameter sIdle = 0, sSendInit = 1, sSendRpm = 2, sInitIdle = 3, sSendBlip = 4, sWaitForLowTx = 5, sSendTemp = 6, sWaitTwoSec = 7, sSendAte = 8, sSendAtsp = 9;

    reg [5:0] state, stateNext, statePrev;

    reg [7:0] sendAtz [3:0];
    reg [7:0] sendAte [4:0];
    reg [7:0] sendAtsp [5:0];
    reg [7:0] sendRpm [4:0];
    reg [7:0] sendTemp [4:0];

    reg [5:0] blipCounter;
    reg [3:0] sendCommandCounter;
    reg [31:0] secondsCounter; 

    // Initialization
    initial begin
       
    end

    always @(posedge clk) begin
        state = stateNext;

        case (state)
            sIdle: begin
                fifoBlip = 0;
                if (switchInputs[3]) begin
                    sendAtz[0] = "A";
                    sendAtz[1] = "T";
                    sendAtz[2] = "Z";
                    sendAtz[3] = 8'h0D; // '\r'
                    
                    //Keep in mind that this next command is ate0 which is the turn off echo command
                    sendAte[0] = "A";
                    sendAte[1] = "T";
                    sendAte[2] = "E";
                    sendAte[3] = "0";
                    sendAte[4] = 8'h0D; // '\r'
                    
                    sendAte[0] = "A";
                    sendAte[1] = "T";
                    sendAte[2] = "S";
                    sendAte[3] = "P";
                    sendAte[4] = "6";
                    sendAte[5] = 8'h0D; // '\r'
                    
                    //Send Temp
                    sendTemp[0] = 8'h30;
                    sendTemp[1] = 8'h31;
                    sendTemp[2] = 8'h30;
                    sendTemp[3] = 8'h35;
                    sendTemp[4] = 8'h0D;
                    
                    //Send RPM
                    sendRpm[0] = 8'h30;
                    sendRpm[1] = 8'h31;
                    sendRpm[2] = 8'h30;
                    sendRpm[3] = 8'h43;
                    sendRpm[4] = 8'h0D;
                    
                    stateNext = sSendInit;
                    sendCommandCounter = 0;
                end else begin
                    stateNext = sIdle;
                end
            end

            sSendInit: begin
                if (sendCommandCounter < 4) begin
                    dataOut = sendAtz[sendCommandCounter];
                    statePrev = state;
                    stateNext = sSendBlip;
                    blipCounter = 0;
                end else begin
                    secondsCounter = 0; 
                    stateNext = sSendAte;
                end
            end
            

            sSendBlip: begin
                if (blipCounter < 50) begin
                    fifoBlip = 1;
                    blipCounter = blipCounter + 1;
                    stateNext = sSendBlip;
                end else if (listenTx) begin
                    fifoBlip = 0;
                    sendCommandCounter = sendCommandCounter + 1;
                    stateNext = sWaitForLowTx;
                end else begin
                    fifoBlip = 0;
                    stateNext = sSendBlip;
                end
            end

            sWaitForLowTx: begin 
                if (!listenTx) begin 
                    stateNext = statePrev; 
                end else begin 
                    stateNext = sWaitForLowTx; 
                end
            end
            
            sSendAte: begin 
                secondsCounter = secondsCounter+1; 
                if (secondsCounter < 200000000) begin 
                    stateNext = sSendAte;
                    sendCommandCounter = 0; 
                end else begin 
                     if (sendCommandCounter < 5) begin
                        dataOut = sendAte[sendCommandCounter];
                        statePrev = state;
                        stateNext = sSendBlip;
                        blipCounter = 0;
                    end else begin
                        secondsCounter = 0; 
                        stateNext = sSendAtsp;
                    end                 
                    //stateNext = sSendAte; 
                end
            end
            
             sSendAtsp: begin 
                secondsCounter = secondsCounter+1; 
                if (secondsCounter < 200000000) begin 
                    stateNext = sSendAtsp;
                    sendCommandCounter = 0; 
                end else begin 
                     if (sendCommandCounter < 6) begin
                        dataOut = sendAtsp[sendCommandCounter];
                        statePrev = state;
                        stateNext = sSendBlip;
                        blipCounter = 0;
                    end else begin
                        secondsCounter = 0; 
                        stateNext = sInitIdle;
                    end                 
                    //stateNext = sSendAte; 
                end
            end

            sInitIdle: begin
                fifoBlip = 0;
                secondsCounter = secondsCounter + 1; 
                if (secondsCounter < 200000000) begin 
                    stateNext = sInitIdle;  
                end else begin 
                    secondsCounter = 0; 
                    if (switchInputs[0]) begin
                        stateNext = sSendRpm;
                        sendCommandCounter = 0;
                       
                    end else begin
                        stateNext = sInitIdle;
                    end 
                end
                
            end

            sSendRpm: begin
                if (sendCommandCounter < 5) begin
                    dataOut = sendRpm[sendCommandCounter];
                    statePrev = state;
                    stateNext = sSendBlip;
                    blipCounter = 0;
                end else begin
                    secondsCounter = 0; 
                    stateNext = sWaitTwoSec;
                end
            end

            sWaitTwoSec: begin
                secondsCounter = secondsCounter+1; 
                if (secondsCounter < 200000000) begin 
                    stateNext = sWaitTwoSec; 
                end else begin 
                    sendCommandCounter = 0; 
                    sendTemp[0] = 8'h30;
                    sendTemp[1] = 8'h31;
                    sendTemp[2] = 8'h30;
                    sendTemp[3] = 8'h35;
                    sendTemp[4] = 8'h0D;
                    stateNext = sSendTemp; 
                end
            end

            sSendTemp: begin 
                if (sendCommandCounter < 5) begin
                    dataOut = sendTemp[sendCommandCounter];
                    statePrev = state;
                    stateNext = sSendBlip;
                    blipCounter = 0;
                end else begin
                    secondsCounter = 0; 
                    stateNext = sInitIdle;
                end
            end


            default: begin
                stateNext = sIdle;
            end
        endcase
    end
endmodule
