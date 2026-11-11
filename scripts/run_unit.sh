#!/usr/bin/env bash
# =============================================================================
# run_unit.sh  --  run ONE unit test with Icarus Verilog
# USAGE: scripts/run_unit.sh alu        (runs tb/unit/tb_alu.sv)
# riscv_pkg.sv is compiled first because every module imports it.
# =============================================================================
set -euo pipefail
cd "$(dirname "$0")/.."
name="$1"
mkdir -p build
iverilog -g2012 -I tb/common -o "build/tb_${name}.vvp" \
    rtl/riscv_pkg.sv $(ls rtl/*.sv | grep -v riscv_pkg) "tb/unit/tb_${name}.sv"
vvp "build/tb_${name}.vvp"
