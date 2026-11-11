# =============================================================================
# arith_chain.S  --  arithmetic dependency chain
# -----------------------------------------------------------------------------
# WHAT THIS PROGRAM NEEDS TO DO
#   * Exercise every v1 register and immediate ALU instruction.
#   * Each result feeds the next instruction (tests that writeback lands
#     before the next read).
#   * Fill in expected results in programs/expected/arith_chain.txt.
# =============================================================================
    .text
    .globl _start
_start:
    addi x1, x0, 5          # x1 = 5
    addi x2, x0, 3          # x2 = 3
    add  x3, x1, x2         # x3 = 8
    sub  x4, x3, x1         # x4 = 3
    # TODO: and, or, xor, sll, srl, slt, andi, ori, xori
halt:
    beq  x0, x0, halt
