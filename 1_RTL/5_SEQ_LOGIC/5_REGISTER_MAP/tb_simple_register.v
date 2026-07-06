`timescale 1ns / 1ps 

module tb_simple_register;
	parameter N =32;
	reg clk;
	reg rst_n;
	reg wen;
	reg [N-1:0] i_wdata;
	wire [N-1:0] o_rdata;
	
	simple_register #(.N(N)) dut(
	.clk(clk),
	.rst_n(rst_n),
	.wen(wen),
	.i_wdata(i_wdata),
	.o_rdata(o_rdata));

	initial begin
		clk = 0;
		forever #5 clk = ~clk;
	end

	initial begin
		rst_n = 1'b0; i_wdata = 32'd1; wen = 1'b0; #10;
		rst_n = 1'b1; #10;
		wen = 1'b1; #10;
		i_wdata = 32'd400; #10;
		i_wdata = 32'd50; #10;
		wen = 1'b0; i_wdata = 32'd100; #30;
		wen = 1'b1; #30;
		$finish;	
	end

endmodule 
