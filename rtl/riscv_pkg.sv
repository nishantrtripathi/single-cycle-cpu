// =============================================================================
// riscv_pkg.sv  --  shared constants for the whole core
// Owner: both (changes need review from the other developer)
// -----------------------------------------------------------------------------
// WHAT THIS FILE NEEDS TO DO
//   * Be the ONLY place opcodes, funct codes, ALU op codes and immediate-type
//     codes are defined. Every other module does `import riscv_pkg::*;`.
//   * Never hard-code a magic number like 7'b0110011 anywhere else in rtl/.
//   * When v1.1 adds instructions (LUI, AUIPC, JAL, JALR, SRA, SLTU, ...),
//     add their opcodes / ALU ops here first.
//
// COMPILE ORDER: this file must be compiled before any file that imports it.
// =============================================================================
`timescale 1ns/1ps

package riscv_pkg;

    // ---- Opcodes (instr[6:0]) ----------------------------------------------
    localparam logic [6:0] OP_RTYPE  = 7'b0110011; // ADD SUB AND OR XOR SLL SRL SLT
    localparam logic [6:0] OP_ITYPE  = 7'b0010011; // ADDI ANDI ORI XORI
    localparam logic [6:0] OP_LOAD   = 7'b0000011; // LW
    localparam logic [6:0] OP_STORE  = 7'b0100011; // SW
    localparam logic [6:0] OP_BRANCH = 7'b1100011; // BEQ BNE

    // ---- funct3 values -----------------------------------------------------
    localparam logic [2:0] F3_ADD_SUB = 3'b000;
    localparam logic [2:0] F3_SLL     = 3'b001;
    localparam logic [2:0] F3_SLT     = 3'b010;
    localparam logic [2:0] F3_XOR     = 3'b100;
    localparam logic [2:0] F3_SRL     = 3'b101;
    localparam logic [2:0] F3_OR      = 3'b110;
    localparam logic [2:0] F3_AND     = 3'b111;
    localparam logic [2:0] F3_LW_SW   = 3'b010;
    localparam logic [2:0] F3_BEQ     = 3'b000;
    localparam logic [2:0] F3_BNE     = 3'b001;

    // ---- funct7 values -----------------------------------------------------
    localparam logic [6:0] F7_DEFAULT = 7'b0000000;
    localparam logic [6:0] F7_SUB     = 7'b0100000;

    // ---- ALU operations (control -> alu_control -> alu) ---------------------
    typedef enum logic [3:0] {
        ALU_ADD = 4'd0,
        ALU_SUB = 4'd1,
        ALU_AND = 4'd2,
        ALU_OR  = 4'd3,
        ALU_XOR = 4'd4,
        ALU_SLL = 4'd5,
        ALU_SRL = 4'd6,
        ALU_SLT = 4'd7
    } alu_op_t;

    // ---- High-level ALU intent from control_unit to alu_control -------------
    //   ADD    : force add (loads/stores compute address)
    //   SUB    : force subtract (branches compare)
    //   FUNCT  : look at funct3/funct7 (R-type and I-type ALU)
    typedef enum logic [1:0] {
        ALU_INTENT_ADD   = 2'd0,
        ALU_INTENT_SUB   = 2'd1,
        ALU_INTENT_FUNCT = 2'd2
    } alu_intent_t;

    // ---- Immediate formats --------------------------------------------------
    typedef enum logic [1:0] {
        IMM_I = 2'd0,
        IMM_S = 2'd1,
        IMM_B = 2'd2
    } imm_type_t;

endpackage
