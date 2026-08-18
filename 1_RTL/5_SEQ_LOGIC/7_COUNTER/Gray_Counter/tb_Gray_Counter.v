`timescale 1ns / 1ps 

module tb_Gray_Counter;
	reg clk			;
	reg rst_n		;
	wire [3:0] gray		;

	Gray_Counter dut(
	.clk(clk),
	.rst_n(rst_n),
	.gray(gray));
	
	initial begin
		clk = 1'b0;
		forever #5 clk = ~clk;
	end

	initial begin
		rst_n = 1'b0; #10;
		rst_n = 1'b1; #180;	
		$finish;
	end

endmodule
