//
// memtest.v -- test bench for memory controller
//


`include "ramtest/ramtest.v"
`include "ramctrl/ramctrl.v"


`timescale 1ns/10ps
`default_nettype none


module memtest;

  reg clk;			// system clock
  reg rst_in;			// reset, input
  reg rst;			// system reset

  wire inst_stb;
  wire [25:0] inst_addr;
  wire [63:0] inst_to_cache;
  wire inst_ack;
  wire inst_timeout;

  wire data_stb;
  wire data_we;
  wire [25:0] data_addr;
  wire [63:0] data_to_mctrl;
  wire [63:0] data_to_cache;
  wire data_ack;
  wire data_timeout;

  wire test_ended;
  wire test_error;

  // simulation control
  initial begin
    #0          $timeformat(-9, 1, " ns", 12);
                $dumpfile("dump.vcd");
                $dumpvars(0, memtest);
                clk = 1;
                rst_in = 1;
    #23         rst_in = 0;
    #252400     $finish;
  end

  // clock generator
  always begin
    #5 clk = ~clk;		// 10 nsec cycle time
  end

  // reset synchronizer
  always @(posedge clk) begin
    rst <= rst_in;
  end

  ramctrl ramctrl_1(
    .clk(clk),
    .rst(rst),
    .inst_stb(inst_stb),
    .inst_addr(inst_addr[25:0]),
    .inst_dout(inst_to_cache[63:0]),
    .inst_ack(inst_ack),
    .inst_timeout(inst_timeout),
    .data_stb(data_stb),
    .data_we(data_we),
    .data_addr(data_addr[25:0]),
    .data_din(data_to_mctrl[63:0]),
    .data_dout(data_to_cache[63:0]),
    .data_ack(data_ack),
    .data_timeout(data_timeout)
  );

  ramtest ramtest_1(
    .clk(clk),
    .rst(rst),
    .inst_stb(inst_stb),
    .inst_addr(inst_addr[25:0]),
    .inst_din(inst_to_cache[63:0]),
    .inst_ack(inst_ack | inst_timeout),
    .data_stb(data_stb),
    .data_we(data_we),
    .data_addr(data_addr[25:0]),
    .data_dout(data_to_mctrl[63:0]),
    .data_din(data_to_cache[63:0]),
    .data_ack(data_ack | data_timeout),
    .test_ended(test_ended),
    .test_error(test_error)
  );

endmodule
