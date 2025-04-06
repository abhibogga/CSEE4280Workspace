
module axi_pixel_dma (
    input wire clk,
    input wire reset,
    input wire start,

    // Pixel write interface
    input wire [7:0] pixel_data,
    input wire pixel_valid,
    output reg pixel_ready,

    // AXI interface (64-bit memory interface via MIG)
    output reg [31:0] M_AXI_AWADDR,
    output reg        M_AXI_AWVALID,
    input  wire       M_AXI_AWREADY,

    output reg [31:0] M_AXI_WDATA,
    output reg [3:0]  M_AXI_WSTRB,
    output reg        M_AXI_WVALID,
    input  wire       M_AXI_WREADY,

    input  wire [1:0] M_AXI_BRESP,
    input  wire       M_AXI_BVALID,
    output reg        M_AXI_BREADY,

    output reg [31:0] M_AXI_ARADDR,
    output reg        M_AXI_ARVALID,
    input  wire       M_AXI_ARREADY,

    input  wire [31:0] M_AXI_RDATA,
    input  wire [1:0]  M_AXI_RRESP,
    input  wire        M_AXI_RVALID,
    output reg         M_AXI_RREADY,

    output reg [7:0] pixel_out,
    output reg pixel_out_valid
);

    reg [7:0] write_index = 0;
    reg [7:0] read_index = 0;
    reg [3:0] state = 0;

    localparam IDLE      = 0;
    localparam WRITE     = 1;
    localparam WRITE_WAIT= 2;
    localparam READ      = 3;
    localparam READ_WAIT = 4;
    localparam DONE      = 5;

    always @(posedge clk) begin
        if (reset) begin
            state <= IDLE;
            M_AXI_AWVALID <= 0;
            M_AXI_WVALID  <= 0;
            M_AXI_BREADY  <= 0;
            M_AXI_ARVALID <= 0;
            M_AXI_RREADY  <= 0;
            pixel_ready   <= 0;
            pixel_out_valid <= 0;
        end else begin
            case (state)
                IDLE: begin
                    if (start) begin
                        write_index <= 0;
                        state <= WRITE;
                    end
                end
                WRITE: begin
                    if (pixel_valid) begin
                        M_AXI_AWADDR <= {24'b0, write_index};  // 32-bit address
                        M_AXI_AWVALID <= 1;
                        M_AXI_WDATA <= {24'b0, pixel_data}; // write 1 byte
                        M_AXI_WSTRB <= 4'b0001; // only byte 0
                        M_AXI_WVALID <= 1;
                        M_AXI_BREADY <= 1;
                        pixel_ready <= 1;
                        state <= WRITE_WAIT;
                    end
                end
                WRITE_WAIT: begin
                    pixel_ready <= 0;
                    if (M_AXI_WREADY && M_AXI_AWREADY && M_AXI_BVALID) begin
                        M_AXI_AWVALID <= 0;
                        M_AXI_WVALID <= 0;
                        M_AXI_BREADY <= 0;
                        write_index <= write_index + 1;
                        if (write_index == 63)
                            state <= READ;
                        else
                            state <= WRITE;
                    end
                end
                READ: begin
                    M_AXI_ARADDR <= {24'b0, read_index};
                    M_AXI_ARVALID <= 1;
                    M_AXI_RREADY <= 1;
                    state <= READ_WAIT;
                end
                READ_WAIT: begin
                    if (M_AXI_ARREADY && M_AXI_RVALID) begin
                        pixel_out <= M_AXI_RDATA[7:0];
                        pixel_out_valid <= 1;
                        M_AXI_ARVALID <= 0;
                        M_AXI_RREADY <= 0;
                        read_index <= read_index + 1;
                        if (read_index == 63)
                            state <= DONE;
                        else
                            state <= READ;
                    end else begin
                        pixel_out_valid <= 0;
                    end
                end
                DONE: begin
                    pixel_out_valid <= 0;
                end
            endcase
        end
    end

endmodule
