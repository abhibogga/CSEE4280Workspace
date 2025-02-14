`timescale 1ns / 1ns
`include "led.v"
module tb_led();
    // Testbench signals
    reg [15:0] switchPanel;
    reg clk;
    reg rst;
    wire rLED, gLED, bLED;

    // Instantiate the LED module
    //AGAIN WE MADE A MISTAKE IN OUR CODE, THIS WAS THE QUICK FIX
    led uut (
        .switchPanel(switchPanel),
        .rLED(rLED),
        .gLED(gLED),
        .bLED(bLED),
        .clk(clk),
        .rst(rst)
    );


    // Clock generation
    always #5 clk = ~clk; // 10ns period (100MHz clock)

    // Test procedure
    initial begin
        $dumpvars(0, tb_led);
        // Initialize signals
        clk = 0;
        rst = 0;
        switchPanel = 16'b0000100000100001;



        
        #2000
        /*
        rst = 0;
        
        // Test different switchPanel values
        #20 switchPanel = 16'b1111100000000000; // High red intensity
        #40 switchPanel = 16'b0000011111100000; // High green intensity
        #40 switchPanel = 16'b0000000000011111; // High blue intensity
        #40 switchPanel = 16'b0111101111011110; // Mixed colors
        
        // Apply reset again
        #20 rst = 1;
        #20 rst = 0;

        // End simulation
        #100 */
        $finish;
    end

endmodule
