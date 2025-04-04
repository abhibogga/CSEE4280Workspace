module transmit_fifo(writeIn, writeReady, writeDone, clk, writeOut, writeFinished);
    input [7:0] writeIn; 
    input writeReady; 
    input writeDone; 
    input clk; 

    output reg [7:0] writeOut; 
    output writeFinished; 
    

    always @(posedge clk) begin 
        if (writeReady) begin 
            writeOut = writeIn; 
            writeFinished = 1; 
        end

        if (writeFinished) begin 
            writeOut = 0; 
            writeFinished = 0; 
        end
    end

endmodule