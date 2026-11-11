// =============================================================================
// tb_program_counter.sv  --  unit test for program_counter
// -----------------------------------------------------------------------------
// WHAT THIS TEST NEEDS TO DO
//   * pc == RESET_VECTOR after reset.
//   * pc takes pc_next on each clock edge.
//   * Use `CHECK_EQ for every check and end with `TB_FINISH.
//   * Must pass on its own: scripts/run_unit.sh program_counter
// =============================================================================
`timescale 1ns/1ps
`include "tb_utils.svh"

module tb_program_counter;
    import riscv_pkg::*;
    logic        clk = 0, rst_n;
    logic [31:0] pc_next, pc;

    program_counter dut (.*);
    always #5 clk = ~clk;

    initial begin
        // TODO: test cases
        `TB_FINISH
    end
endmodule
