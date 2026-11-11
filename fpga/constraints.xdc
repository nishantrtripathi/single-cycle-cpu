## =============================================================================
## constraints.xdc  --  pin + timing constraints
## -----------------------------------------------------------------------------
## WHAT THIS FILE NEEDS TO DO
##   * Map every fpga_top port to a real package pin for the chosen board.
##   * Define the board clock with create_clock so timing analysis runs.
##   * The values below are PLACEHOLDERS -- copy the real ones from your
##     board's master .xdc (Digilent publishes these for Basys 3, Nexys A7, ...).
## =============================================================================

## Clock (example: 100 MHz)
# set_property -dict { PACKAGE_PIN <PIN> IOSTANDARD LVCMOS33 } [get_ports clk_board]
# create_clock -period 10.000 -name sys_clk [get_ports clk_board]

## Reset button
# set_property -dict { PACKAGE_PIN <PIN> IOSTANDARD LVCMOS33 } [get_ports btn_reset]

## LEDs
# set_property -dict { PACKAGE_PIN <PIN> IOSTANDARD LVCMOS33 } [get_ports {led[0]}]
# ... repeat for led[1] .. led[15]
