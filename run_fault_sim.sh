#!/bin/bash

# CVW Fault Simulation Script
# Usage: ./run_fault_sim.sh

set -e

cd ~/project/cvw
source setup.sh
source eda_tools_setup

echo "=== Step 1: Initialize submodules ==="
git submodule update --init addins/verilog-ethernet/

echo "=== Step 2: Generate derivative config ==="
make deriv

echo "=== Step 3: Compile SBST ==="
cd examples/asm/sbst
make clean
make
cd ~/project/cvw

echo "=== Step 4: Run synthesis ==="
cd synthDC
./wallySynth_polito.py --tech nangate45 -t 1500 -v syn_polito_rv32e -c 16
cd ~/project/cvw

echo "=== Step 5: Run gate-level simulation ==="
wsim syn_polito_rv32e --elf ./examples/asm/sbst/sbst.elf --define +define+GATE_LEVEL=1 --sim questa --tb testbench --vcd --gate

echo "=== Step 6: Run fault simulation with zoix ==="
cd zoix
./zoix_cvw.sh syn_polito_rv32e

echo "=== Done ==="
echo "Reports: zoix/run_zoix/cvw_coverage.sff"
