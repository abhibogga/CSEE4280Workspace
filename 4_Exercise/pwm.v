
module pwm (clk, rst, period, dutyCycle, modeBurst, typeBurst, pwmOut, outRST);

    //Define the inputs here - remeber inputs don't need reg key word but outputs do
    input clk; 
    input rst;
    input [15:0] period;
    input [7:0] dutyCycle;
    input typeBurst; 
    input modeBurst;

    //define outputs here
    output reg pwmOut; 
    output reg outRST; 

    //define states here
    parameter sIdle = 0, sInit = 1, sOn = 2, sOff = 3, sOnBurst = 4, sOffBurst = 5;

    //States
    reg [2:0] state, stateNext; 

    //Extranous variables
    reg [32:0] onTime;
    reg [32:0] offTime; 

    //burst variables
    reg [32:0] burst_onTime, burst_offTime;  
    reg [32:0] burstDiv; 
    reg [32:0] burstCounter; 
    reg [32:0] tickTime;
    initial begin 
        $display(1000000000/period);
        if (typeBurst == 1) begin 
            burstDiv = 32; 
            burstCounter = 16; 
        end else begin 
            burstDiv = 16; 
            burstCounter = 8; 
        end
    end
    
         
    

    /* Moore Machines consist of 3 always blocks 
        - The first is to drive the states
        - The second is to drive the logic
        - The thrid is to drive the outputs
    */

    //always block to drive the states
    always @(posedge clk) begin
        state <= stateNext; 
    end


    //always block to drive the logic
    always @(posedge clk, rst) begin 
        if (rst == 1) begin 
            state = sIdle; 
        end else begin 
            state = stateNext; 
        end
        case (state)

            sIdle: begin 
                //sIdle needs to only go to sInit, when rst = 0, else stay on sIdle
                if (rst == 0) begin 
                    stateNext = sInit;
                end else begin 
                    stateNext = sIdle; 
                end
            end

            sInit: begin 
                //sInit should always move to sOn unless rst goes back on
                if (rst == 1) begin
                    //go back to sIdle
                    stateNext = sIdle; 
                end else begin 

                    if (modeBurst) begin 
                        stateNext = sOnBurst; 
                    end else begin 
                        stateNext = sOn; 
                    end; 

                    tickTime = 1000000000/period;
                    tickTime = 1000000000/tickTime;
                    //Lets also calcuate on and off times so we don't have to worry about that 
                    onTime = (tickTime * dutyCycle)/100; 
                    offTime = (tickTime*(100 - dutyCycle))/100; 

                    burst_onTime = onTime/burstDiv; 
                    burst_offTime = onTime/burstDiv; 
                    
                end
            end

            sOn: begin
                //Drive output
                pwmOut = 1;


                /* There are 3 options for movement within this stage
                    - sOn has not finished its duty cycle so it goes back to sOn
                    - sOn has finsihed its duty cycle so it moves to sOff
                    - rst is turned on and the system needs to go back to the idle state
                */

                if (rst == 1) begin 
                    //set idle back on 
                    stateNext = sIdle; 
                end else if (onTime != 0) begin 
                    onTime--; 
                    stateNext = sOn;   
                end else begin 
                    stateNext = sOff; 
                    onTime = (tickTime * dutyCycle)/100; 
                end
            end

            sOff: begin
                //Drive output
                pwmOut = 0;


                /* There are 3 options for movement within this stage
                    - sOff has not finished its duty cycle so it goes back to sOf
                    - sOff has finsihed its duty cycle so it moves to sOn or sOnBurst
                    - rst is turned on and the system needs to go back to the idle state
                */
                if (rst == 1) begin 
                    //set idle back on 
                    stateNext = sIdle; 
                end else if (offTime != 0) begin 
                    offTime--; 
                    stateNext = sOff; 
                end else begin 
                    if (modeBurst) begin 
                        stateNext = sOnBurst; 
                    end else begin
                        stateNext = sOn; 
                    end  
                    offTime = (tickTime * (100 - dutyCycle))/100; 
                end
            end

            sOnBurst: begin
                //Drive output
                pwmOut = 0;

                if (rst == 1) begin 
                    stateNext = sIdle;
                end else if (burstCounter > 0) begin //we need to decide wheater we need to go to sOff or sBurstOff or stay on burstOn
                    //Now we look at either sburston or sburstoff
                    if (burst_onTime > 0) begin 
                        burst_onTime--; 
                        stateNext = sOnBurst; 
                    end else begin 
                        //This means that it is time to go to burstOff 
                        burstCounter--; 
                        burst_onTime = ((tickTime * dutyCycle)/100)/burstDiv;
                        stateNext = sOffBurst;
                    end
                end else begin //this means that the burst counter is at 0
                    //Drive the state to sOff
                    stateNext = sOff; 

                    //Drive output
                    if (typeBurst == 1) begin 
                        burstCounter = 16; 
                    end else begin 
                        burstCounter = 8; 
                    end
                end
            end

            sOffBurst: begin
                //Drive output
                pwmOut = 1;


                /* There are 2 cases in which this state can move to
                    - It can go to offBurst while count is less than 8 or 16 depending on burst type
                    - or it can go to idle if reset is activated
                */

                if (rst == 1) begin 
                    stateNext = sIdle; 
                end else if (burst_offTime > 0) begin 
                    burst_offTime--;
                    stateNext = sOffBurst; 
                end else begin //This is when burstOff time is done
                    burst_offTime = ((tickTime * dutyCycle)/100)/burstDiv;
                    stateNext = sOnBurst;
                end
            end

            default: //NEVER FORGET THE DEFAULT CASE STATEMENT!!!
                stateNext = sInit; 
            


        endcase

    end



endmodule