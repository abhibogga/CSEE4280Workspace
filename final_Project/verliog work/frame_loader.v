module frame_loader #(
    parameter FRAME_SIZE = 256,
    parameter DATA_WIDTH = 8
)(
    input wire clk,
    input wire reset,
    input wire start,
    input wire [DATA_WIDTH-1:0] mem_data_in,
    output reg [DATA_WIDTH-1:0] frame_data,
    output reg frame_valid,
    output reg frame_done,
    output reg [$clog2(FRAME_SIZE)-1:0] mem_addr
);

    reg [$clog2(FRAME_SIZE)-1:0] count;
    reg loading;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            loading     <= 0;
            count       <= 0;
            mem_addr    <= 0;
            frame_data  <= 0;
            frame_valid <= 0;
            frame_done  <= 0;
        end else begin
            if (start && !loading) begin
                loading     <= 1;
                count       <= 0;
                mem_addr    <= 0;
                frame_valid <= 0;
                frame_done  <= 0;
            end else if (loading) begin
                frame_data  <= mem_data_in;
                frame_valid <= 1;
                mem_addr    <= mem_addr + 1;
                count       <= count + 1;
                
                if (count == FRAME_SIZE - 1) begin
                    loading     <= 0;
                    frame_done  <= 1;
                end
            end else begin
                frame_valid <= 0;
                frame_done  <= 0;
            end
        end
    end
endmodule
