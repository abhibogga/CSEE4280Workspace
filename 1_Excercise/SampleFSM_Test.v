// Testbench for Sample FSM

`timescale 1ns/1ns
`include "SampleFSM.v"

module SampleFSM_Test();

reg Clk_s, Rst_s, B_s;
wire X_s;

SampleFSM  CompToTest(B_s, X_s, Clk_s, Rst_s);

//Clock

always begin
	Clk_s <= 0;
	#10;
	Clk_s <= 1;
	#10;
end

// Test inputs

initial begin
$dumpvars(0,SampleFSM_Test);
	Rst_s <= 1;
	B_s <= 0;
	@(posedge Clk_s);
	#5 Rst_s <= 0;
	@(posedge Clk_s);
	#5 B_s <= 1;
	@(posedge Clk_s);
	#5 B_s <= 0;
	@(posedge Clk_s);
	@(posedge Clk_s);
	@(posedge Clk_s);
	@(posedge Clk_s);
#10 $finish;
end
endmodule
	