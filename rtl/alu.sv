// =============================================================================
// alu.sv  --  32-bit arithmetic/logic unit
// Owner: Nishant Tripathi
// -----------------------------------------------------------------------------
// WHAT THIS FILE NEEDS TO DO
//   * Purely combinational. Compute result from a, b and alu_op:

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

    always_comb begin
        case (alu_op)
            ALU_ADD: result = a + b;
            ALU_SUB: result = a - b;
            ALU_AND: result = a & b;
            ALU_OR:  result = a | b;
            ALU_XOR: result = a ^ b;
            ALU_SLL: result = a << b[4:0];
            ALU_SRL: result = a >> b[4:0];
            ALU_SLT: result = ($signed(a) < $signed(b)) ? 32'd1 : 32'd0;
            default: result = 32'b0;
        endcase
    end

    assign zero = (result == 32'b0);

endmodule
