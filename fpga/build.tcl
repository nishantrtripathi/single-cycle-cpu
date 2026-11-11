# =============================================================================
# build.tcl  --  reproducible Vivado non-project build
# -----------------------------------------------------------------------------
# WHAT THIS SCRIPT NEEDS TO DO
#   * Read all RTL (riscv_pkg.sv first), fpga_top.sv and constraints.xdc.
#   * Synthesize, place, route for PART.
#   * Write utilization + timing reports and the bitstream to build/fpga/.
#   * Fail loudly (exit non-zero) if timing is not met.
# USAGE: vivado -mode batch -source fpga/build.tcl
# =============================================================================

set PART   "TODO-part-number"   ;# e.g. xc7a35tcpg236-1 for Basys 3
set TOP    fpga_top
set OUTDIR build/fpga
file mkdir $OUTDIR

read_verilog -sv rtl/riscv_pkg.sv
foreach f [glob rtl/*.sv] {
    if {[file tail $f] ne "riscv_pkg.sv"} { read_verilog -sv $f }
}
read_verilog -sv fpga/fpga_top.sv
read_xdc fpga/constraints.xdc

synth_design -top $TOP -part $PART
report_utilization -file $OUTDIR/post_synth_util.rpt

opt_design
place_design
route_design

report_timing_summary -file $OUTDIR/timing.rpt
report_utilization    -file $OUTDIR/post_route_util.rpt

# TODO: check WNS and exit 1 if negative

write_bitstream -force $OUTDIR/$TOP.bit
