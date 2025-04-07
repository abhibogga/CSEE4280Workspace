/*module transmit_fifo(writeIn, writeReady, writeDone, clk, writeOut, writeFinished);
    input [7:0] writeIn; 
    input writeReady; 
    input writeDone; 
    input clk; 

    output reg [7:0] writeOut; 
    output reg writeFinished; 
    

    always @(posedge clk) begin 
        if (writeReady) begin 
            writeOut = writeIn; 
            writeFinished = 1; 
        end

         if (writeDone) begin 
            writeOut = 0; 
            writeFinished = 0; 
        end
    end

endmodule */

module transmit_fifo(writeIn, writeReady, writeDone, clk, writeOut, writeFinished);
    input [7:0] writeIn; 
    input writeReady; 
    input writeDone; 
    input clk; 

    output reg [7:0] writeOut; 
    output reg writeFinished; 

    //Declare states
    parameter sIdle = 0, sSend = 1; 

    reg state, stateNext;  

    always @(posedge clk) begin 
        state <= stateNext; 
    end

    always @(posedge clk) begin 
        case (state) 

            sIdle: begin

                if (writeReady) begin 
                    stateNext = sSend; 
                end else begin 
                    writeOut = 0; 
                    writeFinished = 0; 
                end

            end

            sSend: begin 
                writeOut = writeIn; 
                writeFinished = 1;
                if (writeDone) begin 
                    stateNext = sIdle;
                end else begin 
                    stateNext = sSend; 
                end
            end

            default: begin 
                stateNext = sIdle; 
            end
        
        endcase
    end
endmodule