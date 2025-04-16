

iverilog -o test ./tb_read_fifo.v

vvp .\test


gtkwave dump.vcd