`include "led.v"
`include "ssd.v"
`include "seven_segment.v"
module topModule(SW, LED16_B, LED16_G, LED16_R, CLK100MHZ, BTNC, AN, SD);

    //Define the inputs here
    input [15:0] SW; 
    input CLK100MHZ; 
    input BTNC;

    //Define outputs here
    output LED16_B, LED16_G, LED16_R;
    output wire [7:0] SD; // ask herring about this: why do i need wire and not reg
    output wire [7:0] AN;


    wire [4:0] JA;

    wire [31:0] encoded;
    assign encoded[3:0] = 4'h0;
    assign encoded[7:4] = 4'h0;
    assign encoded[11:8] = SW[3:0];
    assign encoded[15:12] = {3'b0, SW[4]};
    assign encoded[19:16] = SW[8:5];
    assign encoded[23:20] = {2'b0, SW[10:9]};
    assign encoded[27:24] = SW[14:11];
    assign encoded[31:28] = {3'b0, SW[15]};
    
    //Create led controller obj
    led leftLED(
        .switchPanel(SW), 
        .rLED(LED16_R), 
        .gLED(LED16_G), 
        .bLED(LED16_B),
        .clk(CLK100MHZ), 
        .rst(BTNC)
    );

    seven_segment controlSSD (CLK100MHZ, BTNC, encoded, AN, SD);

    /*ssd display(
        .clk(CLK100MHZ), 
        .switches(SW), 
        .sevenSeg(SD), 
        .commonAnode(AN)
    ); */

    assign JA[0] = LED16_R;
    assign JA[1] = LED16_B; 
    assign JA[2] = LED16_B;
    assign JA[3] = CLK100MHZ;





endmodule