`timescale 1ns / 1ps

module tb_fdivider;
	// stimulus signal
	reg clk_in;
	reg rst_n;
	// monitor_signal
	wire o_clk_out;
	
	// DUT 	instantation with the designated param
	fdivider #(.DIVISOR(10)) dut (
	.clk_in(clk_in),
	.rst_n(rst_n),
	.o_clk_out(o_clk_out)
);

	initial begin
		clk_in = 0;
		forever #5 clk_in = ~clk_in;
	end
	
	// Test scenario
	initial begin
		rst_n = 1'b0; #10;
		rst_n = 1'b1; #200;
		$finish;
	end


endmodule 
