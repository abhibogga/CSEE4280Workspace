`include "memory.v"
`timescale 1ns/1ns

module tb_memory();

  reg clk, mrd, ewr;
  reg [7:0] m_add, ead, data_in;  
  wire [7:0] temp1;

  // Instantiate the memory module with correct port mapping
  memory m1(clk, m_add, ead, data_in, ewr, mrd, temp1);

  initial begin
    // VCD Dump File Setup
    $dumpfile("dump.vcd"); // Specifies the VCD file name
    $dumpvars(0, tb_memory); // Dumps all variables in the testbench

    clk = 0;
    mrd = 0;
    ewr = 0;

    #10 ewr = 1; ead = 8'b00000001; data_in = 8'b10101010; // Write data 0xAA to address 0x01
    #10 ewr = 0; // Disable write

    #10 mrd = 1; m_add = 8'b00000001; // Read from address 0x01
    #10 mrd = 0; // Disable read

    #40 $finish; // Stop simulation
  end

  always #5 clk = ~clk; // Clock generation

endmodule
