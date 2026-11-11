// =============================================================================
// tb_data_mem.sv  --  unit test for data_mem
// -----------------------------------------------------------------------------
// WHAT THIS TEST NEEDS TO DO
//   * Write then read multiple addresses.
//   * we == 0 does not write; write only lands on the clock edge.
//   * Use `CHECK_EQ for every check and end with `TB_FINISH.
//   * Must pass on its own: scripts/run_unit.sh data_mem
// =============================================================================
`timescale 1ns/1ps
`include "tb_utils.svh"

module tb_data_mem;
    import riscv_pkg::*;
    logic        clk = 0, we;
    logic [31:0] addr, wdata, rdata;

    data_mem dut (.*);
    always #5 clk = ~clk;

    initial begin
        // TODO: test cases
        `TB_FINISH
    end
endmodule
