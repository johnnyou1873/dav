vlib work

# Compile DUT and testbench
vlog fft_butterfly.sv
vlog fft_butterfly_tb.sv

# Start simulation of testbench
vsim work.fft_butterfly_tb

# Run the simulation
run 100ns