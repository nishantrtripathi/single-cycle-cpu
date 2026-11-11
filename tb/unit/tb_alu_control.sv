// =============================================================================
// tb_alu_control.sv  --  unit test for alu_control
// -----------------------------------------------------------------------------
// WHAT THIS TEST NEEDS TO DO
//   * Every v1 R-type and I-type instruction maps to the right alu_op.
//   * ADDI whose immediate has bit 30 set still gives ALU_ADD (not SUB).
//   * ALU_INTENT_ADD / ALU_INTENT_SUB ignore funct fields.
//   * Use `CHECK_EQ for every check and end with `TB_FINISH.
//   * Must pass on its own: scripts/run_unit.sh alu_control
// =============================================================================
`timescale 1ns/1ps
`include "tb_utils.svh"

module tb_alu_control;
    import riscv_pkg::*;
    alu_intent_t alu_intent;
    logic        is_rtype;
    logic [2:0]  funct3;
    logic [6:0]  funct7;
    alu_op_t     alu_op;

    alu_control dut (.*);

    initial begin
        // TODO: test cases
        `TB_FINISH
    end
endmodule
