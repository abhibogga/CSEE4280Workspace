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
  reg [7:0] expected_cathode;
  reg [NUM_SEGMENTS-1:0] expected_anode;
  reg goodOrNot;

  // Task to check outputs
  task check_outputs;
    input [NUM_SEGMENTS-1:0] expected_anode;
    input [7:0] expected_cathode;
    begin
      if (anode == expected_anode) begin
        goodOrNot = 0;
        $display("Looks Good: At time %0t, expected anode=%b, got %b", $time, expected_anode, anode);
      end else if (cathode == expected_cathode) begin
        goodOrNot = 0;
        $display("Looks Good: At time %0t, expected cathode=%b, got %b", $time, expected_cathode, cathode);
      end else begin
        goodOrNot = 1;
      end
    end
  endtask

  // Test Sequence
  initial begin
    $dumpfile("tb_ssd.vcd");
    $dumpvars(0, tb_ssd);

    // Initialize Signals
    Clk = 0;
    Reset = 1;
    encoded = 32'h01234567; // Example encoded values

    // Reset Phase
    #20 Reset = 0;

    // Example Test Case
    expected_anode = 8'b11111110; // Activating first segment
    expected_cathode = 8'b11000000; // Expected value for '0'
    #CLK_PER;
    check_outputs(expected_anode, expected_cathode);

    $display("Test completed.");
    $finish;
  end

endmodule
