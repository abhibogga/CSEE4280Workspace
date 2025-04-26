

iverilog -o test tb_uart_transmitter.v

vvp .\test


gtkwave dump.vcd

