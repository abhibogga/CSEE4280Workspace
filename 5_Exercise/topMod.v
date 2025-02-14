`include "led.v"
`include "ssd.v"
module topModule(SW, LED16_B, LED16_G, LED16_R, CLK100MHZ, BTNC, AN, SD);

    //Define the inputs here
    input [15:0] SW; 
    input CLK100MHZ; 
    input BTNC;

    //Define outputs here
    output LED16_B, LED16_G, LED16_R;
    output wire [6:0] SD; // ask herring about this: why do i need wire and not reg
    output wire [6:0] AN;
    
    //Create led controller obj
    led leftLED(
        .switchPanel(SW), 
        .rLED(LED16_R), 
        .gLED(LED16_G), 
        .bLED(LED16_B),
        .clk(CLK100MHZ), 
        .rst(BTNC)
    );

    ssd display(
        .clk(CLK100MHZ), 
        .switches(SW), 
        .sevenSeg(SD), 
        .commonAnode(AN)
    );




endmodule