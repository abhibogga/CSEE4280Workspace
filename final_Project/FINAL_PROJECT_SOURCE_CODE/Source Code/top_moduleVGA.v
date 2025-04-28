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

// Character grid dimensions for 8x16 font
localparam CHAR_WIDTH = 8;
localparam CHAR_HEIGHT = 16;
localparam CHAR_COLS = FRAME_WIDTH / CHAR_WIDTH;
localparam CHAR_ROWS = FRAME_HEIGHT / CHAR_HEIGHT;

// Current character cell
wire [9:0] char_x = h_cntr_reg / CHAR_WIDTH;
wire [9:0] char_y = v_cntr_reg / CHAR_HEIGHT;
wire [3:0] row_in_char = v_cntr_reg % CHAR_HEIGHT;
wire [2:0] col_in_char = h_cntr_reg % CHAR_WIDTH;

// Font ROM and screen buffer
reg [7:0] screen_buffer [0:CHAR_ROWS-1][0:CHAR_COLS-1];
wire [7:0] char_code = screen_buffer[char_y][char_x];
wire [7:0] font_row;

font_rom font_rom_inst (
    .char_code(char_code),
    .row(row_in_char),
    .row_pixels(font_row)
);

wire pixel_on = font_row[7 - col_in_char];

// Graph axis (left and bottom only)
localparam AXIS_MARGIN = 64;

wire in_graph_area = (v_cntr_reg >= 32 && v_cntr_reg < 540);
wire is_y_axis = in_graph_area && (h_cntr_reg >= AXIS_MARGIN && h_cntr_reg < AXIS_MARGIN + 4);
wire is_x_axis = (v_cntr_reg >= 536 && v_cntr_reg < 540) && (h_cntr_reg >= AXIS_MARGIN && h_cntr_reg < FRAME_WIDTH - 350);

// Second graph axis
wire in_graph2_area = (v_cntr_reg >= 592 && v_cntr_reg < FRAME_HEIGHT - 32);
wire is_y2_axis = in_graph2_area && (h_cntr_reg >= AXIS_MARGIN && h_cntr_reg < AXIS_MARGIN + 4);
wire is_x2_axis = (v_cntr_reg >= FRAME_HEIGHT - 36 && v_cntr_reg < FRAME_HEIGHT - 32) && (h_cntr_reg >= AXIS_MARGIN && h_cntr_reg < FRAME_WIDTH - 350);

wire axis_pixel = is_y_axis || is_x_axis || is_y2_axis || is_x2_axis;

// Final color output
assign VGA_R = (active && (pixel_on || axis_pixel)) ? 4'b1111 : 4'b0000;
assign VGA_G = (active && (pixel_on || axis_pixel)) ? 4'b1111 : 4'b0000;
assign VGA_B = (active && (pixel_on || axis_pixel)) ? 4'b1111 : 4'b0000;

// Horizontal counter
always @(posedge pxl_clk) begin
    if (h_cntr_reg == H_MAX - 1)
        h_cntr_reg <= 0;
    else
        h_cntr_reg <= h_cntr_reg + 1;
end

// Vertical counter
always @(posedge pxl_clk) begin
    if (h_cntr_reg == H_MAX - 1) begin
        if (v_cntr_reg == V_MAX - 1)
            v_cntr_reg <= 0;
        else
            v_cntr_reg <= v_cntr_reg + 1;
    end
end

// Horizontal Sync
always @(posedge pxl_clk) begin
    if (h_cntr_reg >= (H_FP + FRAME_WIDTH - 1) &&
        h_cntr_reg <  (H_FP + FRAME_WIDTH + H_PW - 1))
        h_sync_reg <= H_POL;
    else
        h_sync_reg <= ~H_POL;
end

// Vertical Sync
always @(posedge pxl_clk) begin
    if (v_cntr_reg >= (V_FP + FRAME_HEIGHT - 1) &&
        v_cntr_reg <  (V_FP + FRAME_HEIGHT + V_PW - 1))
        v_sync_reg <= V_POL;
    else
        v_sync_reg <= ~V_POL;
end

// Sync output delay
always @(posedge pxl_clk) begin
    h_sync_dly_reg <= h_sync_reg;
    v_sync_dly_reg <= v_sync_reg;
end

assign VGA_HS_O = h_sync_dly_reg;
assign VGA_VS_O = v_sync_dly_reg;

// Initialize text for both graphs
integer i;
initial begin
    for (i = 0; i < CHAR_COLS; i = i + 1)
        screen_buffer[0][i] = 8'h20; // Fill with spaces

    // Top label
    screen_buffer[1][1]  = "c";
    screen_buffer[1][2]  = "o";
    screen_buffer[1][3]  = "o";
    screen_buffer[1][4]  = "l";
    screen_buffer[1][5]  = "a";
    screen_buffer[1][6]  = "n";
    screen_buffer[1][7]  = "t";
    screen_buffer[1][8]  = " ";
    screen_buffer[1][9]  = "t";
    screen_buffer[1][10] = "e";
    screen_buffer[1][11] = "m";
    screen_buffer[1][12] = "p";

    // Bottom label moved to row 35
    screen_buffer[35][1]  = "e";
    screen_buffer[35][2]  = "n";
    screen_buffer[35][3]  = "g";
    screen_buffer[35][4]  = "i";
    screen_buffer[35][5]  = "n";
    screen_buffer[35][6]  = "e";
    screen_buffer[35][7]  = " ";
    screen_buffer[35][8]  = "r";
    screen_buffer[35][9]  = "p";
    screen_buffer[35][10] = "m";
    
    // Average Temp Display
    screen_buffer[15][212] = "a";
    screen_buffer[15][213] = "v";
    screen_buffer[15][214] = "g";
    screen_buffer[15][215] = " ";
    screen_buffer[15][216] = "t";
    screen_buffer[15][217] = "e";
    screen_buffer[15][218] = "m";
    screen_buffer[15][219] = "p";
    screen_buffer[16][213] = "-";
    screen_buffer[16][214] = "-";
    screen_buffer[16][215] = "-";
    screen_buffer[16][216] = ".";
    screen_buffer[16][217] = "-";
    
    
    // Average RPM Display
    screen_buffer[47][212] = "a";
    screen_buffer[47][213] = "v";
    screen_buffer[47][214] = "g";
    screen_buffer[47][215] = " ";
    screen_buffer[47][216] = "r";
    screen_buffer[47][217] = "p";
    screen_buffer[47][218] = "m";
    screen_buffer[48][213] = "-";
    screen_buffer[48][214] = "-";
    screen_buffer[48][215] = "-";
    screen_buffer[48][216] = "-";
    screen_buffer[48][217] = "-";
end

endmodule
