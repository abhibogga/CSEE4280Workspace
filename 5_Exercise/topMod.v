`include "led.v"
module topModule(SW, LED16_B, LED16_G, LED16_R, CLK100MHZ, BTNC);

    //Define the inputs here
    input [15:0] SW; 
    input CLK100MHZ; 
    input BTNC;

    //Define outputs here
    output LED16_B, LED16_G, LED16_R;
    
    
    //Create led controller obj
    led leftLED(
        .switchPanel(SW), 
        .rLED(LED16_R), 
        .gLED(LED16_G), 
        .bLED(LED16_B),
        .clk(CLK100MHZ), 
        .rst(BTNC)
    );




endmodule