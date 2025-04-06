# Clean up previous builds
Remove-Item -Force sim_out.exe -ErrorAction Ignore
Remove-Item -Force dump.vcd -ErrorAction Ignore

# Compile all Verilog files
iverilog -o sim_out memory.v frame_loader.v frame_buffer.v top_mod.v tb_top_mod.v

# Run simulation
vvp sim_out

# Open waveform
gtkwave dump.vcd
