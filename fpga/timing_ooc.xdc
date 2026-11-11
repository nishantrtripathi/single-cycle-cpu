## =============================================================================
## timing_ooc.xdc  --  timing-only constraints for the no-board build
## -----------------------------------------------------------------------------
## WHAT THIS FILE DOES
##   * Tells Vivado the target clock speed so the timing report means something.
##   * No pin assignments -- out-of-context synthesis doesn't use real pins.
##   * Start at 50 MHz (20 ns). A single-cycle CPU's clock period has to cover
##     the slowest instruction (LW: PC -> IMEM -> regfile -> ALU -> DMEM ->
##     writeback), so expect it to be slower than a pipelined design.
##     Tighten the period once it passes and record the max Fmax you hit.
## =============================================================================
create_clock -period 20.000 -name clk [get_ports clk]
