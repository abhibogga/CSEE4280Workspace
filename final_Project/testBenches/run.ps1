

iverilog -o test ./tb_uart_receiver.v

vvp .\test


gtkwave dump.vcd