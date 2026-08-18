`timescale 1ns / 1ps

module tb_Mod_N_Counter;

	parameter N = 10;

	reg clk			;
	reg rst_n		;
	reg enable		;
	wire [$clog2(N)-1:0] count	;

	Mod_N_Counter #(.N(N)) dut(
	.clk(clk),
	.rst_n(rst_n),
	.enable(enable),
	.count(count));

	initial begin
		clk = 1'b0;
		forever #5 clk = ~clk;
	end

	initial begin
		rst_n = 1'b0; enable = 1'b0; #10;
		rst_n = 1'b0; enable = 1'b1; #10;
		rst_n = 1'b1; enable = 1'b0; #10;
		rst_n = 1'b1; enable = 1'b1; #150;
		$finish;
	end

endmodule

