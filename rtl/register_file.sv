// =============================================================================
// register_file.sv  --  32 x 32-bit general-purpose registers
// Owner: Nishant Tripathi
// -----------------------------------------------------------------------------
// WHAT THIS FILE NEEDS TO DO
//   * Two COMBINATIONAL read ports (rs1, rs2).
//   * One SYNCHRONOUS write port: on rising clk, if we && rd_addr != 0,
//     write rd_data into rd_addr.
//   * x0 always reads as 0, no matter what was written to it.
//   * On reset, clear all registers to 0 (makes tests deterministic).
//   * Reading and writing the same register in one cycle returns the OLD
//     value (fine for single-cycle -- the write lands at the clock edge).
//
// UNIT TEST (tb/unit/tb_register_file.sv)
//   * Write/read back all 31 writable registers.
//   * Write to x0, confirm it still reads 0.
//   * we == 0 does not write.
// =============================================================================
`timescale 1ns/1ps

module register_file (
    input  logic        clk,
    input  logic        rst_n,
    input  logic [4:0]  rs1_addr,
    input  logic [4:0]  rs2_addr,
    output logic [31:0] rs1_data,
    output logic [31:0] rs2_data,
    input  logic        we,
    input  logic [4:0]  rd_addr,
    input  logic [31:0] rd_data
);

    logic [31:0] regs [32];

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            for (int i = 0; i < 32; i++) begin
                regs[i] <= 32'b0;
            end
        end else if (we && rd_addr != 0) begin
            regs[rd_addr] <= rd_data;
        end
    end

    assign rs1_data = (rs1_addr == 0) ? 32'b0 : regs[rs1_addr];
    assign rs2_data = (rs2_addr == 0) ? 32'b0 : regs[rs2_addr];



endmodule
