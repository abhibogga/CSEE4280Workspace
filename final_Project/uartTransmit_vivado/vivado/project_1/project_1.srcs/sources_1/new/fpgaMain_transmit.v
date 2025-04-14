module fpgaMain_transmit(switchInputs, clk, listenTx, fifoBlip, dataOut);
    input [3:0] switchInputs;
    input clk;
    input listenTx;

    output reg fifoBlip;
    output reg [7:0] dataOut;

    parameter sIdle = 0, sSendInit = 1, sSendRpm = 2, sInitIdle = 3, sSendBlip = 4, sWaitForLowTx = 5;

    reg [5:0] state, stateNext, statePrev;

    reg [7:0] sendAtz [3:0];
    reg [7:0] sendRpm [4:0];

    reg [5:0] blipCounter;
    reg [3:0] sendCommandCounter;

    // Initialization
    initial begin
        sendAtz[0] = 8'h41;
        sendAtz[1] = 8'h54;
        sendAtz[2] = 8'h5A;
        sendAtz[3] = 8'h0D;
    end

    always @(posedge clk) begin
        state = stateNext;

        case (state)
            sIdle: begin
                fifoBlip = 0;
                if (switchInputs[3]) begin
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
                    stateNext = sInitIdle;
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

            sInitIdle: begin
                fifoBlip = 0;
                if (switchInputs[0]) begin
                    stateNext = sSendRpm;
                    sendCommandCounter = 0;
                    sendRpm[0] = 8'h30;
                    sendRpm[1] = 8'h31;
                    sendRpm[2] = 8'h30;
                    sendRpm[3] = 8'h43;
                    sendRpm[4] = 8'h0D;
                end else begin
                    stateNext = sInitIdle;
                end
            end

            sSendRpm: begin
                if (sendCommandCounter < 5) begin
                    dataOut = sendRpm[sendCommandCounter];
                    statePrev = state;
                    stateNext = sSendBlip;
                    blipCounter = 0;
                end else begin
                    stateNext = sInitIdle;
                end
            end

            default: begin
                stateNext = sIdle;
            end
        endcase
    end
endmodule