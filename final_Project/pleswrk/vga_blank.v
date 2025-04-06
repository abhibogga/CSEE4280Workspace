module vga_blank(
    input wire clk100mhz,
    output wire [3:0] vga_r,
    output wire [3:0] vga_g,
    output wire [3:0] vga_b,
    output wire vga_hs,
    output wire vga_vs
);
    reg [9:0] h_count = 0;
    reg [9:0] v_count = 0;

    wire clk25mhz;
    reg clkdiv = 0;
    always @(posedge clk100mhz) clkdiv <= ~clkdiv;
    assign clk25mhz = clkdiv;

    wire h_end = (h_count == 799);
    wire v_end = (v_count == 524);

    always @(posedge clk25mhz) begin
        if (h_end)
            h_count <= 0;
        else
            h_count <= h_count + 1;

        if (h_end) begin
            if (v_end)
                v_count <= 0;
            else
                v_count <= v_count + 1;
        end
    end

    assign vga_hs = ~(h_count >= 656 && h_count < 752);
    assign vga_vs = ~(v_count >= 490 && v_count < 492);

    wire visible = (h_count < 640 && v_count < 480);

    assign vga_r = visible ? 4'b1111 : 4'b0000;
    assign vga_g = visible ? 4'b1111 : 4'b0000;
    assign vga_b = visible ? 4'b1111 : 4'b0000;

endmodule
