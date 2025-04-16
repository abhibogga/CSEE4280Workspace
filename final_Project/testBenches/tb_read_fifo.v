`timescale 1ns / 1ps
`include "../read_fifo.v"
module read_fifo_tb;

    // Inputs
    reg clk;
    reg signalReady;
    reg [7:0] dataIn;
    reg readBegin;

    // Outputs
    wire [31:0] dataOut;
    wire rxDone;

    // Instantiate the Unit Under Test (UUT)
    read_fifo uut (
        .clk(clk),
        .signalReady(signalReady),
        .dataIn(dataIn),
        .readBegin(readBegin),
        .dataOut(dataOut),
        .rxDone(rxDone)
    );

    // Clock generation
    always #5 clk = ~clk; // 100MHz clock (10ns period)

    // Task to send a byte with signalReady pulse
    task send_byte;
        input [7:0] byte;
        begin
            dataIn = byte;
            signalReady = 1;
            #10;
            signalReady = 0;
            #10;
        end
    endtask

    initial begin
        $dumpvars(0, read_fifo_tb);
        // Initialize Inputs
        clk = 0;
        signalReady = 0;
        dataIn = 8'h00;
        readBegin = 0;

        // Wait for global reset
        #20;

        // Begin reading
        readBegin = 1;
        #10;
        readBegin = 0;

        // Send ELM327 response: "41 05 5A >"
        send_byte("4"); // '4'
        send_byte("1"); // '1'
        send_byte(8'h20); // SPACE
        send_byte("0");
        send_byte("5");
        send_byte(8'h20);
        send_byte("5");
        send_byte("A");
        send_byte(8'h20);
        send_byte(8'h3E); // '>'
        send_byte(8'h0D); // '


        // Wait to process
        #200;

        $display("rxDone = %b, dataOut = %h", rxDone, dataOut);
        $finish;
    end

endmodule
