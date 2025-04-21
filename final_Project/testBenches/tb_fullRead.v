`include "../receiver_uart.v"
`include "../read_fifo.v"
`include "../fpgaMain_read.v"
`include "../baudRateRead.v"
`include "../singlePortRam.v"
`include "../ssd.v"
`timescale 1ns/1ns
module tb_fullRead();

    // Inputs for baudRate
    reg clk; 
    reg rst; 

    // Output from baudRate
    wire outBaud; 

    // Instantiate baudRate module
    baudRateRead br(
        .clk(clk), 
        .rst(rst), 
        .outBaud(outBaud)
    );

    // UART bitstream input
    reg bitStream; 

    // Outputs from UART receiver
    wire [7:0] dOut; 
    wire readDone; 

    // Instantiate UART receiver
    receiver_uart recBit(
        .clk(clk),
        .baudRate(outBaud), 
        .rst(rst), 
        .bitStream(bitStream), 
        .dataOut(dOut), 
        .dataReady(readDone)
    ); 

    // Wire intermediate decoded result
    wire [15:0] bigDOut; 
    wire dInSignal; 

    // FIFO output handling
    read_fifo rf(
        .signalReady(readDone),
        .dataIn(dOut), 
        .readBegin(1'b1), 
        .clk(clk), 
        .dataOut(bigDOut), 
        .rxDone(dInSignal)
    );

    // Final output from top module
    wire [15:0] writeOut; 

    // Instantiate fpgaMain module
    fpgaMain_read uut(
        .clk(clk), 
        .dataInSignal(dInSignal), 
        .dataIn(bigDOut), 
        .rst(rst), 
        .writeOut(writeOut)
    );

    // Testbench baud generator + simulation
    reg baudRate; 
    
    always #5 clk = ~clk; // 100MHz clock
    always #52083 baudRate = ~baudRate; // 9600 baud period (x2) = 1 tick per 104167ns

    // UART byte sending task
    task send_uart_byte;
        input [7:0] byte;
        begin
            bitStream = 0; // Start bit
            @(posedge baudRate);
            for (integer i = 0; i < 8; i = i + 1) begin
                bitStream = byte[i];
                @(posedge baudRate);
            end
            bitStream = 1; // Stop bit
            @(posedge baudRate);
        end
    endtask

    initial begin
        $dumpvars(0, tb_fullRead);
        clk = 0;
        rst = 1;
        baudRate = 1; 
        bitStream = 1;
        #100;
        rst = 0;

        // Let system idle before transmission
        repeat (30) @(posedge baudRate);

        // ==== TRANSMISSION 1 ====
        // Send: "41 0C 0C 94\r"
        send_uart_byte(8'h34);  // '4'
        send_uart_byte(8'h31);  // '1'
        send_uart_byte(8'h20);  // ' '
        send_uart_byte(8'h30);  // '0'
        send_uart_byte(8'h43);  // 'C'
        send_uart_byte(8'h20);  // ' '
        send_uart_byte(8'h30);  // '0'
        send_uart_byte(8'h43);  // 'C'
        send_uart_byte(8'h20);  // ' '
        send_uart_byte(8'h39);  // '9'
        send_uart_byte(8'h34);  // '4'
        send_uart_byte(8'h20);  // ' '
        send_uart_byte(8'h0D);  // '\r'
        send_uart_byte(8'h0D);  // '\r'
        send_uart_byte(8'h3E);  // '>'

        repeat (30) @(posedge baudRate);

        // ==== TRANSMISSION 2 ====
        // Send: "41 05 82\r" (Coolant Temp)
        send_uart_byte(8'h34);  // '4'
        send_uart_byte(8'h31);  // '1'
        send_uart_byte(8'h20);  // ' '
        send_uart_byte(8'h30);  // '0'
        send_uart_byte(8'h35);  // '5'
        send_uart_byte(8'h20);  // ' '
        send_uart_byte(8'h38);  // '8'
        send_uart_byte(8'h32);  // '2'
        send_uart_byte(8'h20);  // ' '
        send_uart_byte(8'h0D);  // '\r'
        send_uart_byte(8'h0D);  // '\r'
        send_uart_byte(8'h3E);  // '>'

        repeat (30) @(posedge baudRate);

        // ==== TRANSMISSION 3 ====
        // Send: "41 0C 1A F8\r"
        send_uart_byte(8'h34);  // '4'
        send_uart_byte(8'h31);  // '1'
        send_uart_byte(8'h20);  // ' '
        send_uart_byte(8'h30);  // '0'
        send_uart_byte(8'h43);  // 'C'
        send_uart_byte(8'h20);  // ' '
        send_uart_byte(8'h31);  // '1'
        send_uart_byte(8'h41);  // 'A'
        send_uart_byte(8'h20);  // ' '
        send_uart_byte(8'h46);  // 'F'
        send_uart_byte(8'h38);  // '8'
        send_uart_byte(8'h20);  // ' '
        send_uart_byte(8'h0D);  // '\r'
        send_uart_byte(8'h0D);  // '\r'
        send_uart_byte(8'h3E);  // '>'

        // End simulation
        repeat (100) @(posedge baudRate);
        $finish;
    end
endmodule
