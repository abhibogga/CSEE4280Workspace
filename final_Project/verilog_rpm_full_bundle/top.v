
module top (
    input wire clk_100MHz,
    input wire reset,
    input wire [15:0] rpm_in,
    input wire rpm_valid,
    output wire hsync,
    output wire vsync,
    output wire [2:0] vga_r,
    output wire [2:0] vga_g,
    output wire [1:0] vga_b
);

    reg [1:0] clk_div = 0;
    wire clk_25MHz = clk_div[1];

    always @(posedge clk_100MHz)
        clk_div <= clk_div + 1;

    wire [7:0] scaled_rpm = (rpm_in * 255) / 8000;
    wire [9:0] write_addr;
    reg [9:0] write_index = 0;
    reg wr_en = 0;

    // Write data to BRAM
    always @(posedge clk_25MHz) begin
        if (reset) begin
            write_index <= 0;
            wr_en <= 0;
        end else if (rpm_valid) begin
            wr_en <= 1;
            write_index <= (write_index == 639) ? 0 : write_index + 1;
        end else begin
            wr_en <= 0;
        end
    end

    wire [9:0] read_addr;
    wire [7:0] data_out;

    memory bram (
        .clk(clk_25MHz),
        .wr_en(wr_en),
        .rd_en(1'b1),
        .addr(wr_en ? write_index : read_addr),
        .data_in(scaled_rpm),
        .data_out(data_out)
    );

    vga_rpm_grapher display (
        .clk(clk_25MHz),
        .reset(reset),
        .rpm_in({8'b0, data_out}),
        .rpm_valid(1'b1),
        .hsync(hsync),
        .vsync(vsync),
        .vga_r(vga_r),
        .vga_g(vga_g),
        .vga_b(vga_b)
    );

endmodule
