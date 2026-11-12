// =============================================================================
// instr_mem.sv  --  instruction memory (ROM)
// Owner: Nishant Tripathi
// -----------------------------------------------------------------------------
// WHAT THIS FILE NEEDS TO DO
//   * Store DEPTH 32-bit words, preloaded from INIT_FILE with $readmemh
//     (files come from programs/hex/, produced by scripts/asm2hex.sh).
//   * COMBINATIONAL read: instr must be valid in the SAME cycle addr changes.
//     A single-cycle CPU cannot wait a cycle for its instruction.
//   * addr is a BYTE address. Index the array with addr[$clog2(DEPTH)+1:2]
//     (drop the bottom 2 bits -- instructions are word-aligned).
//   * Out-of-range reads should return a NOP (32'h0000_0013, i.e. ADDI x0,x0,0).
//
// FPGA NOTE
//   Block RAM has a 1-cycle read latency, so it will NOT work here as-is.
//   Async read infers distributed (LUT) RAM in Vivado, which is fine for
//   small programs. Record this in docs/adr/ADR-002-memory-model.md.
//
// UNIT TEST (tb/unit/tb_instr_mem.sv)
//   * Load a known hex file, read back several addresses, check contents.
// =============================================================================
`timescale 1ns/1ps

module instr_mem #(
    parameter int    DEPTH     = 256,
    parameter string INIT_FILE = ""
) (
    input  logic [31:0] addr,
    output logic [31:0] instr
);

    // TODO: logic [31:0] mem [DEPTH];
    // TODO: initial if (INIT_FILE != "") $readmemh(INIT_FILE, mem);
    // TODO: combinational read with word indexing

endmodule
