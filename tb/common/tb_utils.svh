// =============================================================================
// tb_utils.svh  --  shared helpers for every self-checking testbench
// -----------------------------------------------------------------------------
// WHAT THIS FILE NEEDS TO DO
//   * Provide CHECK_EQ so every test reports failures the same way.
//   * Provide TB_FINISH which prints exactly "[PASS]" or "[FAIL]" -- the
//     regression script greps for these, so keep the format stable.
//   * Add more helpers here (e.g. a reference ALU model, a task that dumps
//     the register file) instead of copy-pasting them into each test.
// =============================================================================
`ifndef TB_UTILS_SVH
`define TB_UTILS_SVH

int tb_errors = 0;

`define CHECK_EQ(actual, expected, msg) \
    if ((actual) !== (expected)) begin \
        $error("[FAIL] %s: got 0x%08h, expected 0x%08h", msg, actual, expected); \
        tb_errors++; \
    end

`define TB_FINISH \
    begin \
        if (tb_errors == 0) $display("[PASS] %m"); \
        else $display("[FAIL] %m: %0d error(s)", tb_errors); \
        $finish; \
    end

`endif
