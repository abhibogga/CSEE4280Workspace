iverilog -o test .\tb_primeNumber.v

vvp .\test


gtkwave dump.vcd