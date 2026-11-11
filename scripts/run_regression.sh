#!/usr/bin/env bash
# =============================================================================
# run_regression.sh  --  the ONE command that must pass before any merge
# -----------------------------------------------------------------------------
# WHAT THIS SCRIPT DOES
#   1. Runs every tb/unit/tb_*.sv.
#   2. Runs tb/integration/tb_cpu_top.sv for each program in programs/hex/
#      (TODO: once tb_cpu_top supports +PROG=...).
#   3. Exits non-zero if any test prints [FAIL] or fails to compile.
# =============================================================================
set -uo pipefail
cd "$(dirname "$0")/.."
mkdir -p build
RTL="rtl/riscv_pkg.sv $(ls rtl/*.sv | grep -v riscv_pkg)"
fails=0

run() {   # $1 = name, $2 = testbench file
    echo "== $1"
    if ! iverilog -g2012 -I tb/common -o "build/$1.vvp" $RTL "$2"; then
        echo "[FAIL] $1: compile error"; fails=$((fails+1)); return
    fi
    out="$(vvp "build/$1.vvp")"; echo "$out"
    grep -q "\[PASS\]" <<<"$out" || fails=$((fails+1))
}

for tb in tb/unit/tb_*.sv; do run "$(basename "$tb" .sv)" "$tb"; done
run tb_cpu_top tb/integration/tb_cpu_top.sv

echo
if [ $fails -eq 0 ]; then echo "REGRESSION PASSED"; else echo "REGRESSION FAILED ($fails)"; fi
exit $fails
