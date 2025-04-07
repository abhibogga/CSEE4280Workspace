

module baudRate(clk, outBaud, rst);

    //Define inputs here: 
    input clk; 
    input rst; 

    //Defind outputs here: 
    output reg outBaud;

    reg [9:0] counter; 

    //Define the states here: 
    parameter sIdle = 0, sCount = 1; 

    reg stateNext, state; 

    //We know that our internal clock is 100MHz and baudRate is 9600 so we won't try and make this module universal so we can do all math in hosue
    //Let's Take 16 baud symbols as one bit - 9600 * 16 = 153,000
    //Now lets take how many clock cycles we need to count before turing on and off our clock
    // 100M/153.6k = 651 cycles


    always @(posedge clk) begin 
        state <= stateNext; 
    end
    //Letsd do the programming
    always @(posedge clk) begin
        if (rst) begin
            counter = 0; 
            stateNext = sIdle; 
        end

        case (state)

            sIdle: begin 
                //This will be the reset state
                if (rst) begin
                    stateNext = sIdle; 
                    outBaud = 0; 
                end else begin
                    stateNext = sCount;
                    outBaud = 0; 
                    counter = 0;  
                end
            end

            sCount: begin
                //Here lets calcuate our couter
                if (rst) begin
                    counter = 0; 
                    stateNext = sIdle; 
                end else begin
                    counter = counter + 1; 
                    stateNext = sCount; 
                end

                if (counter == 651) begin
                    outBaud = ~outBaud;
                    counter = 0; 
                end
            end

            default: 
                stateNext = sIdle; 


        endcase

    end

endmodule