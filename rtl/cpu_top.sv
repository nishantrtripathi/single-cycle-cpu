// =============================================================================
// cpu_top.sv  --  single-cycle RV32I core (integration only)
// Owner: Developer A
// -----------------------------------------------------------------------------
// WHAT THIS FILE NEEDS TO DO
//   * Instantiate and wire every block. No real logic here beyond the 2 muxes.
//
//   Dataflow for one instruction (all in one clock cycle):
//     program_counter -> pc
//     instr_mem(pc)   -> instr
//     instruction_decoder(instr) -> opcode, rd, rs1, rs2, funct3, funct7
//     control_unit(opcode)       -> control signals
//     immediate_generator(instr, imm_type) -> imm
//     register_file(rs1, rs2)    -> rs1_data, rs2_data
//     alu_control(...)           -> alu_op
//     MUX A: alu_b = alu_src_imm ? imm : rs2_data
//     alu(rs1_data, alu_b)       -> alu_result, zero
//     data_mem(alu_result, rs2_data, mem_write) -> load_data
//     MUX B: wb_data = mem_to_reg ? load_data : alu_result
//     register_file write: rd <= wb_data if reg_write
//     branch_unit(pc, imm, branch, funct3, zero) -> pc_next
//
//   * Drive the dbg_* outputs so testbenches can watch every writeback
//     without poking into internal signals.
//   * If illegal_instr is ever 1, raise an $error in simulation.
//
// TESTS: tb/integration/tb_cpu_top.sv runs programs/hex/*.hex and compares
//        against programs/expected/*.
// =============================================================================
`timescale 1ns/1ps

module cpu_top
    import riscv_pkg::*;
#(
    parameter string IMEM_INIT  = "programs/hex/program.hex",
    parameter int    IMEM_DEPTH = 256,
    parameter int    DMEM_DEPTH = 256
) (
    input  logic        clk,
    input  logic        rst_n,

    // Debug / verification taps
    output logic [31:0] dbg_pc,
    output logic [31:0] dbg_instr,
    output logic        dbg_wb_en,
    output logic [4:0]  dbg_wb_rd,
    output logic [31:0] dbg_wb_data
);

    // TODO: internal signals
    // TODO: instantiate all blocks listed above
    // TODO: MUX A and MUX B
    // TODO: assign dbg_* outputs

endmodule
