// =============================================================================
// tb_alu.sv  --  unit test for alu
// -----------------------------------------------------------------------------
// WHAT THIS TEST NEEDS TO DO
//   * Directed checks for each ALU op, including overflow wrap, shift by 0
//     and 31, SLT with negative operands.
//   * Random vectors compared against a reference model in this file.
//   * Check the zero flag.
//   * Use `CHECK_EQ for every check and end with `TB_FINISH.
//   * Must pass on its own: scripts/run_unit.sh alu
// =============================================================================
`timescale 1ns/1ps
`include "tb_utils.svh"

module tb_alu;
    import riscv_pkg::*;
    logic [31:0] a, b, result;
    alu_op_t     alu_op;
    logic        zero;

    alu dut (.*);

    initial begin
        // TODO: test cases
        `TB_FINISH
    end
endmodule
