#!/usr/bin/env bash
# =============================================================================
# asm2hex.sh  --  assemble programs/asm/*.S into programs/hex/*.hex
# -----------------------------------------------------------------------------
# WHAT THIS SCRIPT DOES
#   * For each .S file (or the one named as $1): assemble with the RISC-V GCC
#     toolchain for rv32i, link at address 0, dump .text as one 32-bit hex
#     word per line (the format $readmemh expects).
#   * Requires riscv64-unknown-elf-gcc (or riscv32-...) on PATH.
#     Set PREFIX to override, e.g. PREFIX=riscv32-unknown-elf- ./asm2hex.sh
#
# USAGE:  scripts/asm2hex.sh            # all programs
#         scripts/asm2hex.sh arith_chain
# =============================================================================
set -euo pipefail
cd "$(dirname "$0")/.."
PREFIX="${PREFIX:-riscv64-unknown-elf-}"
mkdir -p build programs/hex

progs=("$@")
[ ${#progs[@]} -eq 0 ] && progs=($(ls programs/asm/*.S | xargs -n1 basename | sed 's/\.S$//'))

for p in "${progs[@]}"; do
    echo "== $p"
    ${PREFIX}gcc -march=rv32i -mabi=ilp32 -nostdlib -nostartfiles \
        -Wl,-Ttext=0x0 -o "build/$p.elf" "programs/asm/$p.S"
    ${PREFIX}objcopy -O binary -j .text "build/$p.elf" "build/$p.bin"
    # 4-byte little-endian words -> one hex word per line
    od -An -v -tx4 -w4 "build/$p.bin" | tr -d ' ' > "programs/hex/$p.hex"
done
