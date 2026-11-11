# FPGA flow (Vivado)

We don't have a board, so the default flow is **synthesis + place & route only**, targeting the
Artix-7 35T (`xc7a35tcpg236-1`). That produces real resource and timing numbers without hardware.
See [`docs/adr/ADR-003-fpga-target.md`](../docs/adr/ADR-003-fpga-target.md).

| File | Purpose |
|---|---|
| `build.tcl` | Vivado batch build (no-board by default, `board` mode for later) |
| `timing_ooc.xdc` | Clock constraint for the no-board build |
| `fpga_top.sv` | Board wrapper -- only used in `board` mode |
| `constraints.xdc` | Pin map -- only used in `board` mode, placeholders for now |

## Run
```
vivado -mode batch -source fpga/build.tcl
```
Reports land in `build/fpga/`:
- `cpu_top_post_route_util.rpt` -- LUTs / flip-flops / RAM used
- `cpu_top_timing.rpt` -- worst slack at the target clock (WNS >= 0 means it meets timing)

## If we get a board later
1. Update `PART` in `build.tcl` if it isn't a Basys 3.
2. Copy pins from the board's master `.xdc` into `constraints.xdc`.
3. Finish `fpga_top.sv`.
4. `vivado -mode batch -source fpga/build.tcl -tclargs board`
