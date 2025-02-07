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

        typeBurst = 1; //0 = 8 pulse     1 = 16 pulse
        modeBurst = 1; //This turns burst on
        // Set initial values
        rst = 0;
        //Transfer Function:  1G/MHz 
        //1Mhz = 1000
        //2Mhz = 500
        //50Mhz = 20

        period = 500;  // Set period
        dutyCycle = 90;    // Set duty cycle


        #50000;

        $finish;
    end

endmodule
