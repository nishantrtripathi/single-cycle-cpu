// =============================================================================
// tb_alu.sv  --  unit test for alu
// -----------------------------------------------------------------------------
// WHAT THIS TEST DOES
//   1. Directed checks: hand-picked inputs for every ALU op, including the
//      tricky edge cases (overflow wrap, shift by 0/31/32, SLT with negatives).
//   2. Zero-flag checks.
//   3. Random checks: 500 random (a, b, op) combos compared against a
//      reference model written below.
//   * Every check uses `CHECK_EQ; ends with `TB_FINISH ([PASS] / [FAIL]).
//   * Run on its own: scripts/run_unit.sh alu
// =============================================================================
`timescale 1ns/1ps
`include "tb_utils.svh"

module tb_alu;
    import riscv_pkg::*;

    logic [31:0] a, b, result;
    alu_op_t     alu_op;
    logic        zero;

    alu dut (.*);

    // ---- Reference model: what the ALU *should* output -----------------------
    function automatic logic [31:0] ref_alu(input logic [31:0] x, y, input alu_op_t op);
        case (op)
            ALU_ADD: return x + y;
            ALU_SUB: return x - y;
            ALU_AND: return x & y;
            ALU_OR:  return x | y;
            ALU_XOR: return x ^ y;
            ALU_SLL: return x << y[4:0];
            ALU_SRL: return x >> y[4:0];
            ALU_SLT: return ($signed(x) < $signed(y)) ? 32'd1 : 32'd0;
            default: return 32'd0;
        endcase
    endfunction

    // ---- Apply inputs, wait for logic to settle, check result -----------------
    task automatic check(input alu_op_t op, input logic [31:0] x, y,
                         input logic [31:0] expected, input string name);
        a = x; b = y; alu_op = op;
        #1;
        `CHECK_EQ(result, expected, name)
        `CHECK_EQ(zero, (expected == 32'd0), {name, " (zero flag)"})
    endtask

    // Variables for the random section
    alu_op_t     rand_op;
    logic [31:0] rand_a, rand_b;

    initial begin
        // ---------------- ADD ----------------
        check(ALU_ADD, 32'd5,          32'd3,          32'd8,          "ADD 5+3");
        check(ALU_ADD, 32'd0,          32'd0,          32'd0,          "ADD 0+0");
        check(ALU_ADD, 32'h7FFF_FFFF,  32'd1,          32'h8000_0000,  "ADD overflow wraps");
        check(ALU_ADD, 32'hFFFF_FFFF,  32'd1,          32'd0,          "ADD -1+1 = 0");

        // ---------------- SUB ----------------
        check(ALU_SUB, 32'd10,         32'd3,          32'd7,          "SUB 10-3");
        check(ALU_SUB, 32'd5,          32'd5,          32'd0,          "SUB equal -> 0 (BEQ case)");
        check(ALU_SUB, 32'd3,          32'd10,         32'hFFFF_FFF9,  "SUB 3-10 = -7");
        check(ALU_SUB, 32'h8000_0000,  32'd1,          32'h7FFF_FFFF,  "SUB underflow wraps");

        // ---------------- AND / OR / XOR ----------------
        check(ALU_AND, 32'hF0F0_F0F0,  32'hFF00_FF00,  32'hF000_F000,  "AND");
        check(ALU_AND, 32'hAAAA_AAAA,  32'h5555_5555,  32'd0,          "AND no overlap -> 0");
        check(ALU_OR,  32'hF0F0_0000,  32'h0000_0F0F,  32'hF0F0_0F0F,  "OR");
        check(ALU_XOR, 32'hFFFF_0000,  32'hFF00_FF00,  32'h00FF_FF00,  "XOR");
        check(ALU_XOR, 32'h1234_5678,  32'h1234_5678,  32'd0,          "XOR self -> 0");

        // ---------------- SLL ----------------
        check(ALU_SLL, 32'd5,          32'd2,          32'd20,         "SLL 5<<2");
        check(ALU_SLL, 32'h1234_5678,  32'd0,          32'h1234_5678,  "SLL by 0");
        check(ALU_SLL, 32'd1,          32'd31,         32'h8000_0000,  "SLL by 31");
        check(ALU_SLL, 32'd1,          32'd32,         32'd1,          "SLL by 32 uses b[4:0]=0");
        check(ALU_SLL, 32'd1,          32'hFFFF_FFE3,  32'd8,          "SLL ignores upper bits of b");

        // ---------------- SRL ----------------
        check(ALU_SRL, 32'd20,         32'd2,          32'd5,          "SRL 20>>2");
        check(ALU_SRL, 32'h8000_0000,  32'd31,         32'd1,          "SRL by 31");
        check(ALU_SRL, 32'h8000_0000,  32'd1,          32'h4000_0000,  "SRL fills with 0 (not sign)");
        check(ALU_SRL, 32'hFFFF_FFFF,  32'd32,         32'hFFFF_FFFF,  "SRL by 32 uses b[4:0]=0");

        // ---------------- SLT (signed!) ----------------
        check(ALU_SLT, 32'd3,          32'd7,          32'd1,          "SLT 3<7");
        check(ALU_SLT, 32'd7,          32'd3,          32'd0,          "SLT 7<3 false");
        check(ALU_SLT, 32'd5,          32'd5,          32'd0,          "SLT equal false");
        check(ALU_SLT, 32'hFFFF_FFFE,  32'd4,          32'd1,          "SLT -2<4 (signed)");
        check(ALU_SLT, 32'd4,          32'hFFFF_FFFE,  32'd0,          "SLT 4<-2 false (signed)");
        check(ALU_SLT, 32'h8000_0000,  32'h7FFF_FFFF,  32'd1,          "SLT most-neg < most-pos");

        // ---------------- Random vs. reference model ----------------
        for (int i = 0; i < 500; i++) begin
            rand_op = alu_op_t'($urandom_range(0, 7));
            rand_a  = $urandom();
            rand_b  = $urandom();
            check(rand_op, rand_a, rand_b, ref_alu(rand_a, rand_b, rand_op),
                  $sformatf("random #%0d %s", i, rand_op.name()));
        end

        `TB_FINISH
    end
endmodule
