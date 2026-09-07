`timescale 1ns / 1ps

module tb_Edge_Detector;
	reg clk					;
	reg rst_n				;
	reg cp					;
	wire p_edge				;
	wire n_edge				;

	Edge_Detector dut(
	.clk(clk)				,
	.rst_n(rst_n)				,
	.cp(cp)					,
	.p_edge(p_edge)				,
	.n_edge(n_edge)		
	);

	initial begin
		clk = 1'b0			;
		forever #5 clk = ~clk		;
	end

	initial begin
		rst_n = 1'b0			;
		cp    = 1'b0			;
		#10				;
		rst_n = 1'b1			;
		cp    = 1'b1			;
		#10				;
		cp    = 1'b0			;
		#10				;
		$finish				;
	end

endmodule
