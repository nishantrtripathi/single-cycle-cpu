// =============================================================================
// tb_cpu_top.sv  --  program-level test harness
// -----------------------------------------------------------------------------
// WHAT THIS TEST NEEDS TO DO
//   * Take the program name as a plusarg:  +PROG=arith_chain
//     -> load programs/hex/<PROG>.hex into instr_mem
//     -> read expected results from programs/expected/<PROG>.txt
//   * Reset the core, then run until the HALT condition:
//       the program ends with an infinite loop `beq x0, x0, 0`, so the run
//       stops when dbg_pc does not change for 2 cycles (or MAX_CYCLES hits,
//       which is a FAIL).
//   * After halting, compare final register values (and memory words, if
//     listed) to the expected file. Print one CHECK_EQ per line.
//   * Optional: log every dbg_wb_* event to build/<PROG>_trace.txt for
//     debugging.
//
// NOTE: IMEM_INIT is a parameter, so the regression script recompiles per
// program, or you switch instr_mem to load via $value$plusargs at runtime.
// =============================================================================
`timescale 1ns/1ps
`include "tb_utils.svh"

module tb_cpu_top;
    localparam int MAX_CYCLES = 10000;

    logic clk = 0, rst_n;
    logic [31:0] dbg_pc, dbg_instr, dbg_wb_data;
    logic        dbg_wb_en;
    logic [4:0]  dbg_wb_rd;

    cpu_top #(.IMEM_INIT("programs/hex/program.hex")) dut (.*);
    always #5 clk = ~clk;

    initial begin
        rst_n = 0;
        repeat (2) @(posedge clk);
        rst_n = 1;
        // TODO: run to halt, load expected file, compare state
        `TB_FINISH
    end
endmodule
