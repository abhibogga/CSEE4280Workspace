
module top_mod (
    input wire clk,
    input wire reset,
    input wire start,

    input wire [7:0] data_in,
    input wire data_valid,
    output wire data_ready,

    // AXI interface to MIG
    output wire [31:0] M_AXI_AWADDR,
    output wire        M_AXI_AWVALID,
    input  wire        M_AXI_AWREADY,

    output wire [31:0] M_AXI_WDATA,
    output wire [3:0]  M_AXI_WSTRB,
    output wire        M_AXI_WVALID,
    input  wire        M_AXI_WREADY,

    input  wire [1:0]  M_AXI_BRESP,
    input  wire        M_AXI_BVALID,
    output wire        M_AXI_BREADY,

    output wire [31:0] M_AXI_ARADDR,
    output wire        M_AXI_ARVALID,
    input  wire        M_AXI_ARREADY,

    input  wire [31:0] M_AXI_RDATA,
    input  wire [1:0]  M_AXI_RRESP,
    input  wire        M_AXI_RVALID,
    output wire        M_AXI_RREADY,

    output wire [7:0] vga_pixel,
    output wire vga_valid
);

    axi_pixel_dma dma (
        .clk(clk),
        .reset(reset),
        .start(start),

        .pixel_data(data_in),
        .pixel_valid(data_valid),
        .pixel_ready(data_ready),

        .M_AXI_AWADDR(M_AXI_AWADDR),
        .M_AXI_AWVALID(M_AXI_AWVALID),
        .M_AXI_AWREADY(M_AXI_AWREADY),
        .M_AXI_WDATA(M_AXI_WDATA),
        .M_AXI_WSTRB(M_AXI_WSTRB),
        .M_AXI_WVALID(M_AXI_WVALID),
        .M_AXI_WREADY(M_AXI_WREADY),
        .M_AXI_BRESP(M_AXI_BRESP),
        .M_AXI_BVALID(M_AXI_BVALID),
        .M_AXI_BREADY(M_AXI_BREADY),
        .M_AXI_ARADDR(M_AXI_ARADDR),
        .M_AXI_ARVALID(M_AXI_ARVALID),
        .M_AXI_ARREADY(M_AXI_ARREADY),
        .M_AXI_RDATA(M_AXI_RDATA),
        .M_AXI_RRESP(M_AXI_RRESP),
        .M_AXI_RVALID(M_AXI_RVALID),
        .M_AXI_RREADY(M_AXI_RREADY),

        .pixel_out(vga_pixel),
        .pixel_out_valid(vga_valid)
    );

endmodule
