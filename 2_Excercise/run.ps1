iverilog -o testbench .\tb_fourFullAdder.v

vvp .\testbench

gtkwave .\dump.vcd