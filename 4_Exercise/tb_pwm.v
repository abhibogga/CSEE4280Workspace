`timescale 1ns/1ps
`include "pwm.v"

module tb_pwm;
    // Declare inputs as reg and outputs as wire
    reg clk;
    reg rst;
    reg [15:0] period;
    reg [7:0] dutyCycle;
    reg modeBurst;
    reg typeBurst;
    wire pwmOut;
    wire outRST;

    // Instantiate the PWM module
    pwm signal (
        .clk(clk),
        .rst(rst),
        .period(period),
        .dutyCycle(dutyCycle),
        .modeBurst(modeBurst),
        .typeBurst(typeBurst),
        .pwmOut(pwmOut),
        .outRST(outRST)
    );

    // This should generate a clock signal at 1 GHz
    always begin
        clk = 1;
        #0.5;
        clk = 0;
        #0.5;
    end

    // Test procedure
    initial begin
        $dumpvars(0, tb_pwm);

        typeBurst = 0; 
        modeBurst = 0; 
        // Set initial values
        rst = 0;
        //Transfer Function: MHz / 1G
        period = 1000;  // Set period
        dutyCycle = 50;    // Set duty cycle


        #5000;

        $finish;
    end

endmodule
