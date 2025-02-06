iverilog -o test .\tb_pwm.v

vvp .\test

gtkwave dump.vcd