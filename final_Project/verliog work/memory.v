module memory(
    input clk,
    input [7:0] m_add,  // Address for reading
    input [7:0] ead,    // Address for writing
    input [7:0] data_in, // Data to be written
    input ewr,          // Write enable
    input mrd,          // Read enable
    output reg [7:0] temp1 // Output data
);

    reg [7:0] memr [0:255]; // 256-byte memory array

    // Initialize the memory from the frame_data.hex file
    initial begin
        $readmemh("frame_data.hex", memr); // Read the hex file and load into memr
    end

    always @(posedge clk) begin
        if (ewr) begin
            memr[ead] <= data_in;  // Write input data to the specified address
        end
        if (mrd) begin
            temp1 <= memr[m_add];   // Read data from the specified address
        end
    end

endmodule
