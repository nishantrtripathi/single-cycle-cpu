// =============================================================================
// tb_register_file.sv  --  unit test for register_file
// -----------------------------------------------------------------------------
// WHAT THIS TEST NEEDS TO DO
//   * Write/read back x1..x31.
//   * Writing x0 has no effect.
//   * we == 0 does not write; reset clears everything.
//   * Use `CHECK_EQ for every check and end with `TB_FINISH.
//   * Must pass on its own: scripts/run_unit.sh register_file
// =============================================================================
`timescale 1ns/1ps
`include "tb_utils.svh"

module tb_register_file;
    import riscv_pkg::*;
    logic        clk = 0, rst_n, we; // we = write enable
    logic [4:0]  rs1_addr, rs2_addr, rd_addr;
    logic [31:0] rs1_data, rs2_data, rd_data;

    register_file dut (.*);
    always #5 clk = ~clk;

    // Write `data` into register `addr` on the next rising edge
    task automatic write_reg(input logic [4:0] addr, input logic [31:0] data);
        @(negedge clk); // change inputs away from the rising edge
        we      = 1;
        rd_addr = addr;
        rd_data = data;
        @(negedge clk); // a rising edge has passed, so the write should have happened
        we      = 0;    // turn off so nothing else gets written by accident
    endtask

    // Read register `addr` on both ports and check it equals `expected`
    task automatic read_reg(input logic [4:0] addr, input logic [31:0] expected, input string msg);
        rs1_addr = addr;
        rs2_addr = addr;
        #1; // combinational read, so wait a little for the outputs to settle
        `CHECK_EQ(rs1_data, expected, msg)
        `CHECK_EQ(rs2_data, expected, {msg, " (rs2)"})
    endtask

    initial begin
        //Step 2: reset clears every register
        rst_n = 0;
        we    = 0;
        @(posedge clk);  // synchronous reset needs a rising edge
        @(negedge clk);
        rst_n = 1;
        for (int i = 0; i < 32; i++) begin
            read_reg(i, 0, $sformatf("x%0d should be 0 after reset", i));
        end

        //Step 3: write x1..x31, then read them all back
        for (int i = 1; i < 32; i++) begin
            write_reg(i, 32'hA5A5_0000 + i);
        end
        for (int i = 1; i < 32; i++) begin
            read_reg(i, 32'hA5A5_0000 + i, $sformatf("x%0d write/read", i));
        end

        //Step 4: writing x0 has no effect
        write_reg(0, 32'hDEAD_BEEF);
        read_reg(0, 0, "x0 should still be 0 after write attempt");

        //Step 5: we = 0 must not write
        @(negedge clk);
        we      = 0;
        rd_addr = 5;
        rd_data = 32'h1234_5678;
        @(negedge clk);
        read_reg(5, 32'hA5A5_0005, "x5 should still be 0xA5A5_0005 after we=0 write attempt");

        //Step 6: read during a write sees the OLD value until the edge
        @(negedge clk);
        we      = 1;
        rd_addr = 7;
        rd_data = 32'hCAFE_0007;
        read_reg(7, 32'hA5A5_0007, "x7 before the clock edge should be the old value");
        @(negedge clk);
        read_reg(7, 32'hCAFE_0007, "x7 after the clock edge should be the new value");
        we = 0;

        //Step 7: reset clears registers that hold data
        @(negedge clk);
        rst_n = 0;
        @(negedge clk);  // a rising edge passes in between, so the reset fires
        rst_n = 1;
        for (int i = 0; i < 32; i++) begin
            read_reg(i, 0, $sformatf("x%0d should be 0 after second reset", i));
        end

        `TB_FINISH
    end
endmodule