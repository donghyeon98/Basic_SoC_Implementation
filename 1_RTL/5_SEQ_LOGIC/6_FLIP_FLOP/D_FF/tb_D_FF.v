`timescale 1ns / 1ps

module tb_D_FF;
	reg clk		;
	reg rst_n	;
	reg d		;
	wire q		;

	D_FF dut(
	.clk(clk),
	.rst_n(rst_n),
	.d(d),
	.q(q));

	initial begin
		clk = 1'b0;
		forever #5 clk = ~clk;
	end

	initial begin
		rst_n = 1'b0; d = 1'b0; #10;
		rst_n = 1'b0; d = 1'b1; #10;
 		rst_n = 1'b1; d = 1'b0; #10;
                rst_n = 1'b1; d = 1'b1; #10;		
		$finish;
	end

endmodule
