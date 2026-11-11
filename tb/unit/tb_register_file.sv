// =============================================================================
// tb_register_file.sv  --  unit test for register_file
// -----------------------------------------------------------------------------
// WHAT THIS TEST NEEDS TO DO
//   * Write/read back x1..x31.
//   * Writing x0 has no effect.
//   * we == 0 does not write; reset clears everything.
//   * Use `CHECK_EQ for every check and end with `TB_FINISH.
//   * Must pass on its own: scripts/run_unit.sh register_file
// =============================================================================
`timescale 1ns/1ps
`include "tb_utils.svh"

module tb_register_file;
    import riscv_pkg::*;
    logic        clk = 0, rst_n, we;
    logic [4:0]  rs1_addr, rs2_addr, rd_addr;
    logic [31:0] rs1_data, rs2_data, rd_data;

    register_file dut (.*);
    always #5 clk = ~clk;

    initial begin
        // TODO: test cases
        `TB_FINISH
    end
endmodule
