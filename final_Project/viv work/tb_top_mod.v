
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

    integer i;
    integer pixel_log;

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_top_mod);

        pixel_log = $fopen("pixel_output.log", "w");

        reset = 1;
        start = 0;
        wr_en = 0;
        wr_addr = 0;
        data_in = 0;

        #20 reset = 0;

        // Write individual pixel bytes (black: 8'h00) to memory
        for (i = 0; i < 64; i = i + 1) begin
            @(posedge clk);
            wr_en = 1;
            wr_addr = i;
            data_in = 8'h00;  // black pixel
        end

        @(posedge clk);
        wr_en = 0;

        // Trigger frame loading
        @(posedge clk);
        start = 1;
        @(posedge clk);
        start = 0;

        // Observe output and write to log
        for (i = 0; i < 200; i = i + 1) begin
            @(posedge clk);
            if (vga_valid)
                $fwrite(pixel_log, "%d %d\n", $time, vga_pixel);
        end

        $fclose(pixel_log);
        $finish;
    end

endmodule
