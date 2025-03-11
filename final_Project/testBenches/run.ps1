

iverilog -o test ./tb_baud.v

vvp .\test

gtkwave dump.vcd