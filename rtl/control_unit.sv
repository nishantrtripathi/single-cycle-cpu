// =============================================================================
// control_unit.sv  --  main decoder: opcode -> datapath control signals
// Owner: Ishan Katakam
// -----------------------------------------------------------------------------
// WHAT THIS FILE NEEDS TO DO
//   * Look ONLY at the opcode (funct3/funct7 decoding belongs to alu_control
//     and branch_unit) and drive every control signal below.
//   * Default every output to a safe value (no reg write, no mem write,
//     no branch) at the top of the always_comb, then override per opcode.
//   * Unknown opcode -> illegal_instr = 1 and all writes disabled.
//
//   Target truth table (copy into docs/architecture.md when done):
//
//   opcode   | reg_write alu_src_imm mem_write mem_to_reg branch  imm_type  alu_intent
//   ---------+--------------------------------------------------------------------------
//   R-type   |    1          0          0          0        0       --      FUNCT
//   I-type   |    1          1          0          0        0      IMM_I    FUNCT
//   LW       |    1          1          0          1        0      IMM_I    ADD
//   SW       |    0          1          1          --       0      IMM_S    ADD
//   BEQ/BNE  |    0          0          0          --       1      IMM_B    SUB
//
// UNIT TEST (tb/unit/tb_control_unit.sv)
//   * One check per row of the table above, plus an illegal opcode.
// =============================================================================
`timescale 1ns/1ps

module control_unit
    import riscv_pkg::*;
(
    input  logic [6:0]  opcode,

    output logic        reg_write,     // write rd at end of cycle
    output logic        alu_src_imm,   // 1: ALU B = immediate, 0: ALU B = rs2
    output logic        mem_write,     // SW
    output logic        mem_to_reg,    // 1: writeback = load data, 0: ALU result
    output logic        branch,        // instruction is a conditional branch
    output imm_type_t   imm_type,      // which immediate format to build
    output alu_intent_t alu_intent,    // tells alu_control what to do
    output logic        illegal_instr  // opcode not in the v1 subset
);

    // TODO: always_comb with defaults + case (opcode)

endmodule
