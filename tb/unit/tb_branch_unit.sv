// =============================================================================
// tb_branch_unit.sv  --  unit test for branch_unit
// -----------------------------------------------------------------------------
// WHAT THIS TEST NEEDS TO DO
//   * BEQ/BNE taken and not taken.
//   * Forward and backward targets.
//   * branch == 0 always gives pc + 4.
//   * Use `CHECK_EQ for every check and end with `TB_FINISH.
//   * Must pass on its own: scripts/run_unit.sh branch_unit
// =============================================================================
`timescale 1ns/1ps
`include "tb_utils.svh"

module tb_branch_unit;
    import riscv_pkg::*;
    logic [31:0] pc, imm, pc_next;
    logic        branch, alu_zero, taken;
    logic [2:0]  funct3;

    branch_unit dut (.*);

    initial begin
        // TODO: test cases
        `TB_FINISH
    end
endmodule
