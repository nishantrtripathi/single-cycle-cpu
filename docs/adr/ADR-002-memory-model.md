# ADR-002: Memory Model

**Status:** Proposed
**Date:** 2026-11-11

## Context
A single-cycle CPU must fetch the instruction and (for LW) read data memory in the same cycle the address is produced. Xilinx block RAM has a registered read (1-cycle latency), so it cannot be used directly.

## Options
1. **Asynchronous-read arrays** -> Vivado infers distributed (LUT) RAM. Simple, works for small memories (a few KB).
2. **Block RAM clocked on the falling edge** -> half-cycle budget for everything else; tighter timing.
3. **Block RAM + multi-cycle/pipelined design** -> no longer single-cycle.

## Decision
Option 1 for v1: separate `instr_mem` and `data_mem` (Harvard), both async read, 256 words each by default.

## Consequences
- Memory size limited by LUT budget; fine for test programs.
- Revisit if a demo program needs more memory.
