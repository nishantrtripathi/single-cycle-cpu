// =============================================================================
// program_counter.sv  --  the PC register
// Owner: Nishant Tripathi
// -----------------------------------------------------------------------------
// WHAT THIS FILE NEEDS TO DO
//   * Hold the 32-bit address of the instruction currently executing.
//   * On every rising clock edge, load pc_next.
//   * On reset (rst_n == 0), set pc to RESET_VECTOR.
//   * Decide sync vs. async reset and record the choice in docs/architecture.md
//     (Vivado prefers synchronous reset; pick one style and use it everywhere).
//   * NO next-PC math in here -- that lives in branch_unit / cpu_top.
//
// UNIT TEST (tb/unit/tb_program_counter.sv)
//   * After reset, pc == RESET_VECTOR.
//   * pc follows pc_next one cycle later.
// =============================================================================
`timescale 1ns/1ps

module program_counter #(
    parameter logic [31:0] RESET_VECTOR = 32'h0000_0000
) (
    input  logic        clk,
    input  logic        rst_n,
    input  logic [31:0] pc_next,
    output logic [31:0] pc
);

    // TODO: always_ff register with reset

endmodule
