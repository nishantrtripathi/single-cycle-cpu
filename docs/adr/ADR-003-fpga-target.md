# ADR-003: FPGA Target Without Hardware

**Status:** Proposed
**Date:** 2026-11-11

## Context
The project goals include a Vivado flow and an FPGA demo, but the team has no FPGA board. Vivado needs a specific part number to synthesize, and a board's pin map to produce a bitstream.

## Decision
- Target the Artix-7 35T, `xc7a35tcpg236-1` (the chip on the Basys 3). It's supported by the free Vivado ML Standard edition and is the most common student board, so if we ever borrow one the flow carries over unchanged.
- Default build is **out-of-context synthesis + place & route of `cpu_top`**, which needs no pins. It produces utilization and timing reports but no bitstream.
- Keep `fpga_top.sv` and `constraints.xdc` in the repo for a future `board` mode.

## Consequences
- v1.0's "Vivado synthesis completes on the selected FPGA target" is satisfied by the no-board build.
- The "small FPGA demo" goal is deferred until hardware is available.
- Reported Fmax is realistic for the chip, but I/O timing is not analyzed (no pins).
