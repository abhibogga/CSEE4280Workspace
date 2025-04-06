
`timescale 1ns / 1ns

module tb_top_mod;

    reg clk;
    reg reset;
    reg start;
    reg wr_en;
    reg [7:0] wr_addr;
    reg [7:0] data_in;

    wire [7:0] vga_pixel;
    wire vga_valid;

    // Instantiate top module
    top_mod uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .wr_en(wr_en),
        .wr_addr(wr_addr),
        .data_in(data_in),
        .vga_pixel(vga_pixel),
        .vga_valid(vga_valid)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Simulation
    integer i;
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_top_mod);

        reset = 1;
        start = 0;
        wr_en = 0;
        wr_addr = 0;
        data_in = 0;

        #20 reset = 0;

        // Write pixel data to memory (grayscale pattern)
        for (i = 0; i < 64; i = i + 1) begin
            @(posedge clk);
            wr_en   = 1;
            wr_addr = i;
            data_in = i * 4;  // simple gradient
        end

        @(posedge clk);
        wr_en = 0;

        // Start frame loading
        @(posedge clk);
        start = 1;
        @(posedge clk);
        start = 0;

        // Capture output for a while
        for (i = 0; i < 100; i = i + 1) begin
            @(posedge clk);
            if (vga_valid)
                $display("VGA Pixel Out: %h", vga_pixel);
        end

        $finish;
    end

endmodule
