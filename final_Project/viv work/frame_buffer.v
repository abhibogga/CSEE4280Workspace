module frame_buffer #(
    parameter FRAME_SIZE = 256,
    parameter DATA_WIDTH = 8
)(
    input wire clk,
    input wire reset,
    input wire load,                  // When frame_valid is high
    input wire [DATA_WIDTH-1:0] data_in,
    input wire [$clog2(FRAME_SIZE)-1:0] load_addr,
    input wire start_output,          // Start streaming output
    output reg [DATA_WIDTH-1:0] data_out,
    output reg valid,
    output reg done
);

    reg [DATA_WIDTH-1:0] buffer [0:FRAME_SIZE-1];
    reg [$clog2(FRAME_SIZE)-1:0] out_index;
    reg streaming;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            out_index <= 0;
            data_out <= 0;
            streaming <= 0;
            valid <= 0;
            done <= 0;
        end else begin
            if (load) begin
                buffer[load_addr] <= data_in;
            end

            if (start_output && !streaming) begin
                streaming <= 1;
                out_index <= 0;
                done <= 0;
            end else if (streaming) begin
                data_out <= buffer[out_index];
                valid <= 1;
                out_index <= out_index + 1;
                if (out_index == FRAME_SIZE - 1) begin
                    streaming <= 0;
                    done <= 1;
                    valid <= 0;
                end
            end else begin
                valid <= 0;
                done <= 0;
            end
        end
    end
endmodule
