`timescale 1ns/1ps
`include "seven_segment.v"
module tb_ssd;
  // Parameters
  parameter NUM_SEGMENTS = 8;
  parameter CLK_PER      = 10; // 10ns clock period -> 100MHz
  parameter REFR_RATE    = 1000;

  // Signals
  reg Clk;
  reg Reset;
  reg [31:0] encoded;
  wire [NUM_SEGMENTS-1:0] anode;
  wire [7:0] cathode;

  // Instantiate DUT (Device Under Test)
  seven_segment #(
    .NUM_SEGMENTS(NUM_SEGMENTS),
    .CLK_PER(CLK_PER),
    .REFR_RATE(REFR_RATE)
  ) dut (
    .Clk(Clk),
    .Reset(Reset),
    .encoded(encoded),
    .anode(anode),
    .cathode(cathode)
  );

  // Clock Generation
  always #(CLK_PER/2) Clk = ~Clk;

  // Test Variables
  integer i;
  reg [7:0] expected_cathode[7:0];
  reg [NUM_SEGMENTS-1:0] expected_anode;
  
  reg goodOrNot; 
  // Task to check outputs
  task check_outputs;
    input [NUM_SEGMENTS-1:0] expected_anode;
    input [7:0] expected_cathode;
    begin
      if (anode !== expected_anode) begin
        goodOrNot = 0; 
        $display("ERROR: At time %0t, expected anode=%b, got %b", $time, expected_anode, anode);
      end
      else if (cathode !== expected_cathode) begin
        $display("ERROR: At time %0t, expected cathode=%b, got %b", $time, expected_cathode, cathode);
      end

      else begin 
        goodOrNot = 1; 
      end
    end
  endtask

  // Test Sequence
  initial begin
    // Initialize Signals
    Clk = 0;
    Reset = 1;
    encoded = 32'h01234567; // Example encoded values

    // Reset Phase
    #20 Reset = 0;

    // Generate Expected Cathode Patterns (Replace with actual expected values from `cathode_top`)
    expected_cathode[0] = 8'b11000000; // Example value for '0'
    expected_cathode[1] = 8'b11111001; // Example value for '1'
    expected_cathode[2] = 8'b10100100; // Example value for '2'
    expected_cathode[3] = 8'b10110000; // Example value for '3'
    expected_cathode[4] = 8'b10011001; // Example value for '4'
    expected_cathode[5] = 8'b10010010; // Example value for '5'
    expected_cathode[6] = 8'b10000010; // Example value for '6'
    expected_cathode[7] = 8'b11111000; // Example value for '7'

    // Loop through all segments
    for (i = 0; i < NUM_SEGMENTS; i = i + 1) begin
      expected_anode = 8'b11111111;  // Default all high
      expected_anode[i] = 1'b0;      // Activate only one segment
      #CLK_PER;
      check_outputs(expected_anode, expected_cathode[i]);
    end

    $display("Test completed.");
    $finish;
  end

endmodule
