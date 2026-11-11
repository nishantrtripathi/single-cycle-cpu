// =============================================================================
// tb_immediate_generator.sv  --  unit test for immediate_generator
// -----------------------------------------------------------------------------
// WHAT THIS TEST NEEDS TO DO
//   * For I, S and B formats: max positive, max negative, zero, random.
//   * B-type: bit 0 is always 0; negative offsets sign-extend.
//   * Use `CHECK_EQ for every check and end with `TB_FINISH.
//   * Must pass on its own: scripts/run_unit.sh immediate_generator
// =============================================================================
`timescale 1ns/1ps
`include "tb_utils.svh"

module tb_immediate_generator;
    import riscv_pkg::*;
    logic [31:0] instr, imm;
    imm_type_t   imm_type;

    immediate_generator dut (.*);

    initial begin
        // TODO: test cases
        `TB_FINISH
    end
endmodule
