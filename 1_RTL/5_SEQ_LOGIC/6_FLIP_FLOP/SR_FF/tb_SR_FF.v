`timescale 1ns / 1ps

module tb_SR_FF;
	reg clk			;
	reg rst_n		;
	reg s			;
	reg r			;
	wire q			;

	SR_FF dut(
	.clk(clk),
	.rst_n(rst_n),
	.s(s),
	.r(r),
	.q(q));

	initial begin
		clk = 1'b0;
		forever #5 clk = ~clk;
	end

	initial begin
		rst_n = 1'b0; s = 1'b0; r = 1'b0; #10;
		rst_n = 1'b0; s = 1'b0; r = 1'b1; #10;
		rst_n = 1'b0; s = 1'b1; r = 1'b1; #10;
                rst_n = 1'b0; s = 1'b1; r = 1'b0; #10;
		rst_n = 1'b1; s = 1'b0; r = 1'b0; #10;
                rst_n = 1'b1; s = 1'b0; r = 1'b1; #10;
                rst_n = 1'b1; s = 1'b1; r = 1'b1; #10;
                rst_n = 1'b1; s = 1'b1; r = 1'b0; #10;
		$finish;
	end

endmodule
