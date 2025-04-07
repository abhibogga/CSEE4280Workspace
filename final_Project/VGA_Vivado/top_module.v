module top_module (
    input  wire        CLK_I,
    output wire        VGA_HS_O,
    output wire        VGA_VS_O,
    output wire [3:0]  VGA_R,
    output wire [3:0]  VGA_G,
    output wire [3:0]  VGA_B
);

// Clock wizard instance
wire pxl_clk;
clk_wiz_0 clk_div_inst (
    .clk_in1(CLK_I),
    .clk_out1(pxl_clk)
);

// VGA Timing for 1920x1080 @ 60Hz
localparam FRAME_WIDTH  = 1920;
localparam FRAME_HEIGHT = 1080;
localparam H_FP  = 88;
localparam H_PW  = 44;
localparam H_MAX = 2200;
localparam V_FP  = 4;
localparam V_PW  = 5;
localparam V_MAX = 1125;
localparam H_POL = 1'b1;
localparam V_POL = 1'b1;

// Horizontal and Vertical counters
reg [11:0] h_cntr_reg = 0;
reg [11:0] v_cntr_reg = 0;

// Sync signals
reg h_sync_reg = ~H_POL;
reg v_sync_reg = ~V_POL;
reg h_sync_dly_reg = ~H_POL;
reg v_sync_dly_reg = ~V_POL;

// Active video region
wire active = (h_cntr_reg < FRAME_WIDTH) && (v_cntr_reg < FRAME_HEIGHT);

// AXIS CONDITIONS (centered)
wire is_vert_axis = (h_cntr_reg >= 958 && h_cntr_reg <= 962); // X = 960 ±2
wire is_horz_axis = (v_cntr_reg >= 538 && v_cntr_reg <= 542); // Y = 540 ±2
wire axis_pixel = is_vert_axis || is_horz_axis;

// COLOR OUTPUT (white unless on axis)
assign VGA_R = (active && !axis_pixel) ? 4'b1111 : 4'b0000;
assign VGA_G = (active && !axis_pixel) ? 4'b1111 : 4'b0000;
assign VGA_B = (active && !axis_pixel) ? 4'b1111 : 4'b0000;

// -------------------- Horizontal Counter --------------------
always @(posedge pxl_clk) begin
    if (h_cntr_reg == H_MAX - 1)
        h_cntr_reg <= 0;
    else
        h_cntr_reg <= h_cntr_reg + 1;
end

// -------------------- Vertical Counter --------------------
always @(posedge pxl_clk) begin
    if (h_cntr_reg == H_MAX - 1) begin
        if (v_cntr_reg == V_MAX - 1)
            v_cntr_reg <= 0;
        else
            v_cntr_reg <= v_cntr_reg + 1;
    end
end

// -------------------- Horizontal Sync --------------------
always @(posedge pxl_clk) begin
    if (h_cntr_reg >= (H_FP + FRAME_WIDTH - 1) &&
        h_cntr_reg <  (H_FP + FRAME_WIDTH + H_PW - 1))
        h_sync_reg <= H_POL;
    else
        h_sync_reg <= ~H_POL;
end

// -------------------- Vertical Sync --------------------
always @(posedge pxl_clk) begin
    if (v_cntr_reg >= (V_FP + FRAME_HEIGHT - 1) &&
        v_cntr_reg <  (V_FP + FRAME_HEIGHT + V_PW - 1))
        v_sync_reg <= V_POL;
    else
        v_sync_reg <= ~V_POL;
end

// -------------------- Sync Output Delay --------------------
always @(posedge pxl_clk) begin
    h_sync_dly_reg <= h_sync_reg;
    v_sync_dly_reg <= v_sync_reg;
end

assign VGA_HS_O = h_sync_dly_reg;
assign VGA_VS_O = v_sync_dly_reg;

endmodule
