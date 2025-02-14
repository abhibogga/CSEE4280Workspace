iverilog -o test .\topMod.v

vvp .\test

gtkwave dump.vcd