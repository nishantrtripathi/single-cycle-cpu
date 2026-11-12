// =============================================================================
// data_mem.sv  --  data memory (RAM) for LW / SW
// Owner: Nishant Tripathi
// -----------------------------------------------------------------------------
// WHAT THIS FILE NEEDS TO DO
//   * Store DEPTH 32-bit words, initialized to zero.
//   * COMBINATIONAL read: rdata valid in the same cycle (needed for LW to
//     write back in one cycle).
//   * SYNCHRONOUS write: on rising clk edge, if we == 1, write wdata.
//   * addr is a BYTE address; index with addr[$clog2(DEPTH)+1:2].
//   * v1 supports aligned word access only. Optionally flag misaligned
//     addresses (addr[1:0] != 0) in simulation with an $error.
//   * Expose a read-only debug view (or a hierarchical path) so testbenches
//     can check final memory contents.
//
// UNIT TEST (tb/unit/tb_data_mem.sv)
//   * Write then read several addresses; a read never sees a write before
//     the clock edge; no write when we == 0.
// =============================================================================
`timescale 1ns/1ps

module data_mem #(
    parameter int DEPTH = 256
) (
    input  logic        clk,
    input  logic [31:0] addr,
    input  logic        we,
    input  logic [31:0] wdata,
    output logic [31:0] rdata
);

    // TODO: storage, zero init, sync write, combinational read

endmodule
