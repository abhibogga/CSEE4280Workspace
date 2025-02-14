iverilog -o test .\tb_ssd.v

vvp .\test

gtkwave dump.vcd