// =============================================================================
// tb_instr_mem.sv  --  unit test for instr_mem
// -----------------------------------------------------------------------------
// WHAT THIS TEST NEEDS TO DO
//   * Load tb/unit/data/instr_mem_test.hex (create it) and read back words.
//   * Out-of-range address returns NOP (32'h00000013).
//   * Use `CHECK_EQ for every check and end with `TB_FINISH.
//   * Must pass on its own: scripts/run_unit.sh instr_mem
// =============================================================================
`timescale 1ns/1ps
`include "tb_utils.svh"

module tb_instr_mem;
    import riscv_pkg::*;
    logic [31:0] addr, instr;

    instr_mem #(.INIT_FILE("tb/unit/data/instr_mem_test.hex")) dut (.*);

    initial begin
        // TODO: test cases
        `TB_FINISH
    end
endmodule
