// =============================================================================
// branch_unit.sv  --  branch decision + next-PC selection
// Owner: Developer A
// -----------------------------------------------------------------------------
// WHAT THIS FILE NEEDS TO DO
//   * Decide whether a branch is taken:
//       BEQ (funct3 000): taken = branch && alu_zero
//       BNE (funct3 001): taken = branch && !alu_zero
//   * Compute the next PC:
//       pc_plus4      = pc + 4
//       branch_target = pc + imm          (imm already has bit 0 = 0)
//       pc_next       = taken ? branch_target : pc_plus4
//   * v1.1: add BLT/BGE/BLTU/BGEU (needs signed/unsigned compare, not just
//     zero) and JAL/JALR (unconditional, JALR target = (rs1 + imm) & ~1).
//
// UNIT TEST (tb/unit/tb_branch_unit.sv)
//   * Taken and not-taken for BEQ and BNE.
//   * Forward and backward (negative imm) targets.
//   * branch == 0 always gives pc + 4.
// =============================================================================
`timescale 1ns/1ps

module branch_unit
    import riscv_pkg::*;
(
    input  logic [31:0] pc,
    input  logic [31:0] imm,
    input  logic        branch,
    input  logic [2:0]  funct3,
    input  logic        alu_zero,
    output logic        taken,
    output logic [31:0] pc_next
);

    // TODO: taken logic + pc_next mux

endmodule
