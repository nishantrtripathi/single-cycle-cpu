// =============================================================================
// alu.sv  --  32-bit arithmetic/logic unit
// Owner: Developer A
// -----------------------------------------------------------------------------
// WHAT THIS FILE NEEDS TO DO
//   * Purely combinational. Compute result from a, b and alu_op:
//       ALU_ADD : a + b
//       ALU_SUB : a - b
//       ALU_AND : a & b
//       ALU_OR  : a | b
//       ALU_XOR : a ^ b
//       ALU_SLL : a << b[4:0]        (only the low 5 bits of b shift)
//       ALU_SRL : a >> b[4:0]        (logical, zero-fill)
//       ALU_SLT : ($signed(a) < $signed(b)) ? 1 : 0
//   * zero = (result == 0). branch_unit uses it for BEQ/BNE.
//   * Default case -> result = 0 so synthesis never infers a latch.
//
// UNIT TEST (tb/unit/tb_alu.sv)
//   * Each op with directed corner cases (overflow wrap, shift by 0 and 31,
//     SLT with negative numbers) plus a few hundred random vectors checked
//     against a reference model written in the testbench.
// =============================================================================
`timescale 1ns/1ps

module alu
    import riscv_pkg::*;
(
    input  logic [31:0] a,
    input  logic [31:0] b,
    input  alu_op_t     alu_op,
    output logic [31:0] result,
    output logic        zero
);

    // TODO: always_comb case (alu_op)
    always_comb result = 32'b0;

    assign zero = (result == 32'b0);

endmodule
