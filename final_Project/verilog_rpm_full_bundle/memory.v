
module memory (
    input wire clk,
    input wire wr_en,
    input wire rd_en,
    input wire [9:0] addr,
    input wire [7:0] data_in,
    output reg [7:0] data_out
);

    reg [7:0] mem [0:639];

    always @(posedge clk) begin
        if (wr_en)
            mem[addr] <= data_in;
        if (rd_en)
            data_out <= mem[addr];
    end

endmodule
