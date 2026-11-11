# ADR-001: v1 RV32I Instruction Subset

**Status:** Proposed
**Date:** 2026-11-11

## Context
A full RV32I core is a lot to verify at once. A small, deliberate subset gets a working end-to-end CPU sooner and keeps every block testable.

## Decision
v1 supports:
- Register ALU: ADD, SUB, AND, OR, XOR, SLL, SRL, SLT
- Immediate ALU: ADDI, ANDI, ORI, XORI
- Memory: LW, SW
- Branch: BEQ, BNE

Deferred to v1.1: LUI, AUIPC, JAL, JALR, SLTU/SLTI/SLTIU, SRA/SRAI, remaining branches.

## Consequences
- No jumps in v1, so programs use branches for loops and the halt loop.
- Immediate generator only needs I, S and B formats.
- Unsupported opcodes assert `illegal_instr`.
