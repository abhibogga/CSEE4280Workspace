
module top_mod (
    input clk,
    input reset,
    input start,

    // Memory write interface (from testbench)
    input wr_en,
    input [7:0] wr_addr,
    input [7:0] data_in,

    // VGA simulated output
    output [7:0] vga_pixel,
    output vga_valid
);

    wire [7:0] mem_data_out;
    wire [7:0] mem_addr;
    wire mem_rd_en;
    wire mem_data_valid;
    wire [7:0] frame_data_out;
    wire frame_valid, frame_done;

    // DDR2-style memory
    ddr2_memory mem_inst (
        .clk(clk),
        .rst(reset),
        .wr_en(wr_en),
        .rd_en(mem_rd_en),
        .addr(mem_rd_en ? mem_addr : wr_addr),
        .data_in(data_in),
        .data_out(mem_data_out),
        .data_valid(mem_data_valid)
    );

    // Frame loader reads from memory
    frame_loader loader_inst (
        .clk(clk),
        .reset(reset),
        .start(start),
        .mem_data_in(mem_data_out),
        .frame_data(frame_data_out),
        .frame_valid(frame_valid),
        .frame_done(frame_done),
        .mem_addr(mem_addr)
    );

    // Simple output: pass-through for VGA test
    assign mem_rd_en = ~wr_en;  // Only read when not writing
    assign vga_pixel = frame_data_out;
    assign vga_valid = frame_valid;

endmodule
