`timescale 1ns / 1ps 

module tb_BCD_Counter;
	reg clk			;
	reg rst_n		;
	reg enable		;
	reg up_down		;
	wire [3:0] count	;

	BCD_Counter dut(
	.clk(clk),
	.rst_n(rst_n),
	.enable(enable),
	.up_down(up_down),
	.count(count));

	initial begin
		clk = 1'b0;
		forever #5 clk = ~clk;
	end

	initial begin
		rst_n = 1'b0; enable = 1'b0; up_down = 1'b0; #10;
		rst_n = 1'b0; enable = 1'b0; up_down = 1'b1; #10;
		rst_n = 1'b0; enable = 1'b1; up_down = 1'b0; #10;
                rst_n = 1'b0; enable = 1'b1; up_down = 1'b1; #10;
		rst_n = 1'b1; enable = 1'b0; up_down = 1'b0; #10;
                rst_n = 1'b1; enable = 1'b0; up_down = 1'b1; #10;
                rst_n = 1'b1; enable = 1'b1; up_down = 1'b0; #120;
                rst_n = 1'b1; enable = 1'b1; up_down = 1'b1; #120;
		$finish;
	end

endmodule
