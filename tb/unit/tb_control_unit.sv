// =============================================================================
// tb_control_unit.sv  --  unit test for control_unit
// -----------------------------------------------------------------------------
// WHAT THIS TEST NEEDS TO DO
//   * One check per opcode row in the control_unit truth table.
//   * Unknown opcode -> illegal_instr = 1, reg_write = 0, mem_write = 0.
//   * Use `CHECK_EQ for every check and end with `TB_FINISH.
//   * Must pass on its own: scripts/run_unit.sh control_unit
// =============================================================================
`timescale 1ns/1ps
`include "tb_utils.svh"

module tb_control_unit;
    import riscv_pkg::*;
    logic [6:0]  opcode;
    logic        reg_write, alu_src_imm, mem_write, mem_to_reg, branch, illegal_instr;
    imm_type_t   imm_type;
    alu_intent_t alu_intent;

    control_unit dut (.*);

    initial begin
        // TODO: test cases
        `TB_FINISH
    end
endmodule
