// =============================================================================
// immediate_generator.sv  --  build sign-extended immediates
// Owner: Developer B
// -----------------------------------------------------------------------------
// WHAT THIS FILE NEEDS TO DO
//   * Use imm_type (from control_unit) to choose the format, then
//     sign-extend to 32 bits using instr[31]:
//       IMM_I : { {20{instr[31]}}, instr[31:20] }
//       IMM_S : { {20{instr[31]}}, instr[31:25], instr[11:7] }
//       IMM_B : { {19{instr[31]}}, instr[31], instr[7], instr[30:25],
//                 instr[11:8], 1'b0 }            // bit 0 is always 0
//   * The B-type bit shuffle is the #1 source of bugs in this project --
//     test it with both positive and negative offsets.
//   * v1.1 will add IMM_U (LUI/AUIPC) and IMM_J (JAL).
//
// UNIT TEST (tb/unit/tb_immediate_generator.sv)
//   * Max positive, max negative, zero, and a random value for each format.
// =============================================================================
`timescale 1ns/1ps

module immediate_generator
    import riscv_pkg::*;
(
    input  logic [31:0] instr,
    input  imm_type_t   imm_type,
    output logic [31:0] imm
);

    // TODO: always_comb case (imm_type)

endmodule
