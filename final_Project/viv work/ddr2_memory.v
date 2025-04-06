
module ddr2_memory #(
    parameter ADDR_WIDTH = 8,
    parameter DATA_WIDTH = 8,
    parameter MEM_DEPTH = 256
)(
    input wire clk,
    input wire rst,
    input wire wr_en,
    input wire rd_en,
    input wire [ADDR_WIDTH-1:0] addr,
    input wire [DATA_WIDTH-1:0] data_in,
    output reg [DATA_WIDTH-1:0] data_out,
    output reg data_valid
);

    reg [DATA_WIDTH-1:0] mem [0:MEM_DEPTH-1];
    reg rd_en_d;

    // Initialize memory with zeros
    integer i;
    initial begin
        for (i = 0; i < MEM_DEPTH; i = i + 1)
            mem[i] = 0;
    end

    always @(posedge clk) begin
        if (rst) begin
            data_out   <= 0;
            data_valid <= 0;
            rd_en_d    <= 0;
        end else begin
            rd_en_d <= rd_en;

            if (wr_en) begin
                mem[addr] <= data_in;
            end

            if (rd_en_d) begin
                data_out   <= mem[addr];
                data_valid <= 1;
            end else begin
                data_valid <= 0;
            end
        end
    end
endmodule
