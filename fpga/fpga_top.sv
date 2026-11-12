// =============================================================================
// fpga_top.sv  --  board-level wrapper around cpu_top
// Owner: Nishant Tripathi
// -----------------------------------------------------------------------------
// WHAT THIS FILE NEEDS TO DO
//   * Take the board clock and a reset push-button.
//   * Debounce/synchronize the reset button (2-flop sync is enough) and turn
//     it into active-low rst_n for cpu_top.
//   * Optionally divide the clock down (e.g. to ~1 Hz with a switch for
//     full speed) so you can watch the CPU step on LEDs.
//   * Show something visible: e.g. low 16 bits of the last writeback value
//     on the LEDs, or a chosen register on the 7-segment display.
//   * Point cpu_top's IMEM_INIT at the demo program hex.
//   * Keep ALL board-specific stuff here -- cpu_top must stay board-agnostic.
// =============================================================================
`timescale 1ns/1ps

module fpga_top (
    input  logic        clk_board,   // board oscillator (see constraints.xdc)
    input  logic        btn_reset,   // active-high push button
    output logic [15:0] led
);

    // TODO: reset synchronizer
    // TODO: optional clock divider / clock enable
    // TODO: cpu_top instance
    // TODO: drive led from dbg_wb_data (latched on dbg_wb_en)

endmodule
