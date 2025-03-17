`timescale 1ns/1ns
`include "../baudRate.v"

module tb_baud();

    reg rst;
    reg clk;

    wire outBaud;

    baudRate bd(
        .rst(rst),
        .clk(clk),
        .outBaud(outBaud)
    );

    always #5 clk = ~clk; // 10ns period (100MHz clock)

    initial begin
        $dumpvars(0, tb_baud);

        clk = 0;
        rst = 1;

        repeat(5) @(posedge clk);
        rst = 0;

        repeat(6520) @(posedge clk);

        $display("Simulation complete at time %t", $time);
        $finish;
    end


endmodule
