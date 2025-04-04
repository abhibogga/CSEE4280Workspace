

iverilog -o test ./tb_sendAtzTransmit.v

vvp .\test


gtkwave dump.vcd