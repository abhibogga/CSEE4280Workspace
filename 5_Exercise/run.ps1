iverilog -o test .\tb_led.v

vvp .\test

gtkwave dump.vcd