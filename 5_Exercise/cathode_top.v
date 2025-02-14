`timescale 1ns/1ps
module cathode_top (
   input wire         Clk,
   input wire [3:0]   encoded,
   output reg [7:0]   cathode  // Declaring as reg because it's assigned inside always block
);

  always @(posedge Clk) begin
    case (encoded)
      4'h0: cathode[6:0] <= 7'b1000000;
      4'h1: cathode[6:0] <= 7'b1111001;
      4'h2: cathode[6:0] <= 7'b0100100;
      4'h3: cathode[6:0] <= 7'b0110000;
      4'h4: cathode[6:0] <= 7'b0011001;
      4'h5: cathode[6:0] <= 7'b0010010;
      4'h6: cathode[6:0] <= 7'b0000010;
      4'h7: cathode[6:0] <= 7'b1111000;
      4'h8: cathode[6:0] <= 7'b0000000;
      4'h9: cathode[6:0] <= 7'b0010000;
      4'hA: cathode[6:0] <= 7'b0001000;
      4'hB: cathode[6:0] <= 7'b0000011;
      4'hC: cathode[6:0] <= 7'b1000110;
      4'hD: cathode[6:0] <= 7'b0100001;
      4'hE: cathode[6:0] <= 7'b0000110;
      4'hF: cathode[6:0] <= 7'b0001110;
      default: cathode[6:0] <= 7'b1111111; // Default case (optional but good practice)
    endcase
  end

endmodule
