// seven_segment.sv
// ------------------------------------
// Drive multiple seven segment displays
// ------------------------------------
// Author : Frank Bruno
// Encapsulate multiple seven segment displays using the cathode driver plus an
// anode driver.
`timescale 1ns/1ps
`include "cathode_top.v"
module seven_segment
  #
  (
   parameter NUM_SEGMENTS = 8,
   parameter CLK_PER      = 10,  // Clock period in ns
   parameter REFR_RATE    = 1000 // Refresh rate in Hz
   )
  (
   input wire                         Clk,
   input wire                         Reset, // active high reset
   input wire [31:0] encoded,
   output reg [NUM_SEGMENTS-1:0]    anode,
   output reg [7:0]                 cathode
   );

  localparam INTERVAL = 10000; 

  reg [$clog2(INTERVAL)-1:0]        refresh_count;
  reg [$clog2(NUM_SEGMENTS)-1:0]    anode_count;
  wire [NUM_SEGMENTS-1:0]      segments [7:0];

  cathode_top ct_0(Clk, encoded[3:0], segments[0]);
  cathode_top ct_1(Clk, encoded[7:4], segments[1]);
  cathode_top ct_2(Clk, encoded[11:8], segments[2]);
  cathode_top ct_3(Clk, encoded[15:12],segments[3]);
  cathode_top ct_4(Clk, encoded[19:16],segments[4]);
  cathode_top ct_5(Clk, encoded[23:20], segments[5]);
  cathode_top ct_6(Clk, encoded[27:24], segments[6]);
  cathode_top ct_7(Clk, encoded[31:28], segments[7]);

  initial begin
    refresh_count = 0;
    anode_count   = 0;
  end

  always @(posedge Clk) begin
    if (refresh_count == INTERVAL) begin
      refresh_count          <= 0;
      anode_count            <= anode_count + 1'b1;
    end else refresh_count <= refresh_count + 1'b1;
    anode[0]                   <= 1;
    anode[1]                   <= 1;
    anode[2]                   <= 1;
    anode[3]                   <= 1;
    anode[4]                   <= 1;
    anode[5]                   <= 1;
    anode[6]                   <= 1;
    anode[7]                   <= 1;
    anode[anode_count]       <= 0;
    cathode                  <= segments[anode_count];
    if (Reset) begin
      refresh_count          <= 0;
      anode_count            <= 0;
    end
  end

endmodule