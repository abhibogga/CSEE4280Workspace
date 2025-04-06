
module vga_rpm_grapher (
    input wire clk,           // 25 MHz VGA pixel clock
    input wire reset,
    input wire [15:0] rpm_in, // Actual RPM value
    input wire rpm_valid,

    output wire hsync,
    output wire vsync,
    output reg [2:0] vga_r,
    output reg [2:0] vga_g,
    output reg [1:0] vga_b
);

    parameter MAX_RPM = 8000;

    reg [9:0] hcount = 0;
    reg [9:0] vcount = 0;

    wire h_active = (hcount < 640);
    wire v_active = (vcount < 480);
    wire visible = h_active && v_active;

    assign hsync = ~(hcount >= 656 && hcount < 752);
    assign vsync = ~(vcount >= 490 && vcount < 492);

    reg [7:0] graph_mem [0:639];
    reg [9:0] write_index = 0;

    wire [23:0] scaled_rpm = (rpm_in * 255) / MAX_RPM;

    always @(posedge clk) begin
        if (reset) begin
            write_index <= 0;
        end else if (rpm_valid) begin
            graph_mem[write_index] <= scaled_rpm[7:0];
            write_index <= (write_index == 639) ? 0 : write_index + 1;
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            hcount <= 0;
            vcount <= 0;
        end else begin
            if (hcount == 799) begin
                hcount <= 0;
                if (vcount == 524)
                    vcount <= 0;
                else
                    vcount <= vcount + 1;
            end else begin
                hcount <= hcount + 1;
            end
        end
    end

    always @(posedge clk) begin
        if (visible && hcount < 640) begin
            if ((479 - vcount) == graph_mem[hcount]) begin
                vga_r <= 3'b111;
                vga_g <= 3'b111;
                vga_b <= 2'b11;
            end else begin
                vga_r <= 0;
                vga_g <= 0;
                vga_b <= 0;
            end
        end else begin
            vga_r <= 0;
            vga_g <= 0;
            vga_b <= 0;
        end
    end

endmodule
