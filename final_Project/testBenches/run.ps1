

iverilog -o test tb_fpgaMain_read.v

vvp .\test


gtkwave dump.vcd