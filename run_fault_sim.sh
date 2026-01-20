#\!/bin/bash

# CVW Fault Simulation Script for MDU
# Usage: ./run_fault_sim.sh
# This script runs the complete fault simulation flow

cd ~/project/cvw
source setup.sh || true
source eda_tools_setup || true

set -e  # Exit on error from here onwards

echo "=== Step 1: Initialize submodules ==="
git submodule update --init addins/verilog-ethernet/

echo "=== Step 2: Generate derivative config ==="
make deriv

echo "=== Step 3: Compile SBST ==="
cd ~/project/cvw/examples/asm/sbst
make clean
make
cd ~/project/cvw

echo "=== Step 4: Run gate-level simulation ==="
wsim syn_polito_rv32e_m --elf ./examples/asm/sbst/sbst.elf --define +define+GATE_LEVEL=1 --sim questa --tb testbench --vcd --gate

echo "=== Step 5: Run fault simulation with Z01X ==="
cd ~/project/cvw/zoix
./zoix_cvw.sh syn_polito_rv32e_m questa

echo ""
echo "=== Done ==="
echo "Fault simulation complete\!"
echo "Reports located at: ~/project/cvw/zoix/run_zoix/"
echo "  - sim.rpt              : Detailed fault report"  
echo "  - testability.txt      : Coverage summary"
echo "  - fmsh.log             : Simulation log"
