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
| `program_counter` | PC register, resets to `RESET_VECTOR` | Nishant Tripathi |
| `instr_mem` | Instruction ROM, async read, `$readmemh` init | Nishant Tripathi |
| `data_mem` | Data RAM, async read / sync write | Nishant Tripathi |
| `instruction_decoder` | Splits instruction into fields | Ishan Katakam |
| `control_unit` | Opcode -> datapath control signals | Ishan Katakam |
| `alu_control` | Intent + funct3/funct7 -> ALU op | Ishan Katakam |
| `immediate_generator` | I/S/B immediates, sign-extended | Ishan Katakam |
| `register_file` | 32x32, 2R/1W, x0 = 0 | Nishant Tripathi |
| `alu` | Arithmetic/logic ops, `zero` flag | Nishant Tripathi |
| `branch_unit` | Branch decision, next PC | Nishant Tripathi |
| `cpu_top` | Integration and muxes | Nishant Tripathi |
| `fpga_top` | Board wrapper (`fpga/`) | Nishant Tripathi |

## Control Signals
<!-- TODO: truth table -->

## Design Decisions
- Reset style: TODO (sync recommended for Vivado)
- Memory model: see ADR-002
- Halt convention: programs end with `beq x0, x0, 0`
