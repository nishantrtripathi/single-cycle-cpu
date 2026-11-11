# =============================================================================
# Dev container for single-cycle-cpu
# -----------------------------------------------------------------------------
# Gives everyone the same toolchain:
#   * iverilog / vvp      -- simulation (scripts/run_unit.sh, run_regression.sh)
#   * verilator           -- lint (verilator --lint-only) and fast sim later
#   * riscv64-unknown-elf -- GCC + binutils for scripts/asm2hex.sh (rv32i)
#
# Vivado is NOT in here (too large, license setup); run it on the host.
# Rebuild after editing: Command Palette -> "Dev Containers: Rebuild Container"
# =============================================================================
FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        iverilog \
        verilator \
        gcc-riscv64-unknown-elf \
        binutils-riscv64-unknown-elf \
        make \
        python3 \
 && rm -rf /var/lib/apt/lists/*
