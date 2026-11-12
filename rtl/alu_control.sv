// =============================================================================
// alu_control.sv  --  pick the exact ALU operation
// Owner: Ishan Katakam
// -----------------------------------------------------------------------------
// WHAT THIS FILE NEEDS TO DO
//   * Combine alu_intent (from control_unit) with funct3/funct7 to produce
//     the alu_op_t the ALU executes.
//       ALU_INTENT_ADD   -> ALU_ADD                 (LW/SW address calc)
//       ALU_INTENT_SUB   -> ALU_SUB                 (branch compare)
//       ALU_INTENT_FUNCT -> decode funct3/funct7:
//           funct3 000: ADD, or SUB if is_rtype && funct7 == F7_SUB
//                       (ADDI must NEVER become SUB -- its bit 30 is
//                        part of the immediate, so check is_rtype)
//           funct3 001: SLL      funct3 010: SLT
//           funct3 100: XOR      funct3 101: SRL
//           funct3 110: OR       funct3 111: AND
//   * Any unsupported combination -> ALU_ADD (and optionally a sim warning).
//
// UNIT TEST (tb/unit/tb_alu_control.sv)
//   * Every R-type and I-type instruction in the v1 subset.
//   * ADDI with an immediate whose bit 30 is set must still give ALU_ADD.
// =============================================================================
`timescale 1ns/1ps

module alu_control
    import riscv_pkg::*;
(
    input  alu_intent_t alu_intent,
    input  logic        is_rtype,   // opcode == OP_RTYPE
    input  logic [2:0]  funct3,
    input  logic [6:0]  funct7,
    output alu_op_t     alu_op
);

    // TODO: always_comb decode

endmodule
