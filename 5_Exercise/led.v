`include "pwm.v"
module led(switchPanel, rLED, gLED, bLED, clk, rst);

    //define the inputs here
    input [15:0] switchPanel; 
    input clk;
    input rst; 

    //Assign outputs here
    output reg rLED, gLED, bLED;

    //Assign input wires here
    wire [4:0] rIn;
    assign rIn = switchPanel[15:11];
    reg [7:0] rDutyCycle;

    wire [5:0] bIn; 
    assign bIn = switchPanel[10:5];
    reg [7:0] bDutyCycle;

    wire [4:0] gIn; 
    assign gIn = switchPanel[4:0];
    reg [7:0] gDutyCycle;


    //Define case statements
    parameter sIdle = 0, sOn = 1; 
    reg state, stateNext; 
    
    wire rpwm, gpwm, bpwm; 



    //Now create pwm modules and assign the numbers to them

    pwm rLight(
        .clk(clk), 
        .rst(rst), 
        .period(10), 
        .dutyCycle(rDutyCycle),
        .typeBurst(0), 
        .modeBurst(0), 
        .pwmOut(rpwm)
    );

    pwm gLight(
        .clk(clk), 
        .rst(rst), 
        .period(10), 
        .dutyCycle(gDutyCycle),
        .typeBurst(0), 
        .modeBurst(0),
        .pwmOut(gpwm)
    );

    pwm bLight(
        .clk(clk), 
        .rst(rst), 
        .period(10), 
        .dutyCycle(bDutyCycle),
        .typeBurst(0), 
        .modeBurst(0),
        .pwmOut(bpwm)
    );

    //Drive the state
    always @(posedge clk) begin 
        state <= stateNext; 
    end

    always @(posedge clk) begin 

        if (rst == 1) begin 
            stateNext = sIdle;
        end

        case(state)

            sIdle: begin 
                //Drive outputs
                rDutyCycle = 0; 
                gDutyCycle = 0; 
                bDutyCycle = 0;

                bLED = 0;
                gLED = 0;
                rLED = 0;
                //We have 2 options when considering this state
                //Either stay in sIdle or go to sOn

                if (rst == 1) begin 
                    stateNext = sIdle; 
                end else begin 
                    stateNext = sOn;
                end
            end

            sOn: begin 
                //We need to check if we need to go back to sIdle
                if (rst == 1) begin 
                    stateNext = sIdle; 
                end else begin 
                    stateNext = sOn;
                end


            
                //Drive the outputs
                bLED = bpwm;
                gLED = gpwm;
                rLED = rpwm;

                rDutyCycle = (rIn*100) >> 5; 
                gDutyCycle = (gIn*100) >> 5;
                bDutyCycle = (bIn*100) >> 6;

            end
            
            default: 
                stateNext = sIdle; 
            
        endcase

    end
endmodule