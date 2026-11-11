# Architecture

<!-- WHAT THIS DOC NEEDS TO HAVE
     * A datapath block diagram (draw.io / SVG in docs/img/).
     * The control truth table (one row per instruction) -- copy from control_unit.sv once final.
     * Every design decision that isn't obvious from the code.
     Keep it in sync with the RTL: a PR that changes the datapath updates this file. -->

## Overview
Single-cycle RV32I core: every instruction completes in one clock cycle.

## Datapath
<!-- TODO: block diagram -->

## Modules
| Module | Responsibility | Owner |
|---|---|---|
| `riscv_pkg` | Opcodes, funct codes, ALU ops, immediate types | Both |
| `program_counter` | PC register, resets to `RESET_VECTOR` | A |
| `instr_mem` | Instruction ROM, async read, `$readmemh` init | A |
| `data_mem` | Data RAM, async read / sync write | A |
| `instruction_decoder` | Splits instruction into fields | B |
| `control_unit` | Opcode -> datapath control signals | B |
| `alu_control` | Intent + funct3/funct7 -> ALU op | B |
| `immediate_generator` | I/S/B immediates, sign-extended | B |
| `register_file` | 32x32, 2R/1W, x0 = 0 | A |
| `alu` | Arithmetic/logic ops, `zero` flag | A |
| `branch_unit` | Branch decision, next PC | A |
| `cpu_top` | Integration and muxes | A |
| `fpga_top` | Board wrapper (`fpga/`) | A |

## Control Signals
<!-- TODO: truth table -->

## Design Decisions
- Reset style: TODO (sync recommended for Vivado)
- Memory model: see ADR-002
- Halt convention: programs end with `beq x0, x0, 0`
