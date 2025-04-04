module read_fifo(signalReady, dataIn, readDone, clk, signalOut, rxDone);
    input signalReady; 
    input [7:0] dataIn;
    input readDone;  
    input clk; 

    output [7:0] signalOut; 
    output rxDone; 


    always @(posedge clk) begin 
        if (signalReady) begin 
            signalOut = dataIn; 
            rxDone = 1; 
        end

        if (readDone) begin 
            signalOut = 0; 
            rxDone = 0; 
        end

    end

endmodule