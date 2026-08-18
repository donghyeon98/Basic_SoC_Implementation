`timescale 1ns / 1ps 

module tb_T_FF;
	reg clk	;
	reg rst_n	;
	reg t		;	
	wire q		;

	T_FF dut(
	.clk(clk),
	.rst_n(rst_n),
	.t(t),
	.q(q));

	initial begin
		clk = 1'b0;
		forever #5 clk = ~clk;
	end

	initial begin
		rst_n = 1'b0; t = 1'b0; #10;
		rst_n = 1'b0; t = 1'b1; #10;
		rst_n = 1'b1; t = 1'b0; #10;
		rst_n = 1'b1; t = 1'b1; #10;
		$finish;
	end
	
endmodule 
