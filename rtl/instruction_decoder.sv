// =============================================================================
// instruction_decoder.sv  --  split an instruction into its fields
// Owner: Ishan Katakam
// -----------------------------------------------------------------------------
// WHAT THIS FILE NEEDS TO DO
//   * Pure wiring (just continuous assigns), no logic decisions:
//       opcode = instr[6:0]
//       rd     = instr[11:7]
//       funct3 = instr[14:12]
//       rs1    = instr[19:15]
//       rs2    = instr[24:20]
//       funct7 = instr[31:25]
//   * Keeps cpu_top readable. Too simple to need its own unit test --
//     it gets covered by the control_unit and integration tests.
// =============================================================================
`timescale 1ns/1ps

module instruction_decoder (
    input  logic [31:0] instr,
    output logic [6:0]  opcode,
    output logic [4:0]  rd,
    output logic [2:0]  funct3,
    output logic [4:0]  rs1,
    output logic [4:0]  rs2,
    output logic [6:0]  funct7
);

    // TODO: six assign statements

endmodule
