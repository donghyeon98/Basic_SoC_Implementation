`timescale 1ns/1ps

module tb_pipeline;
	reg clk;
	reg rst_n;
	reg [9:0] in1;
	reg [9:0] in2;
	reg [9:0] in3;
	wire [11:0] result;

	pipeline dut(
	.clk(clk),
	.rst_n(rst_n),
	.in1(in1),
	.in2(in2),
	.in3(in3),
	.result(result));

	initial begin
		clk = 0;
		forever #5 clk = ~clk;
	end

	initial begin
		rst_n = 1'b0; in1 = 10'd1; in2 = 10'd1; in3 = 10'd1;  #10;
		rst_n = 1'b1; #10;
		in1 = 10'd4; in2 = 10'd5; in3 =  10'd6; #10;
		in1 = 10'd51; in2 = 10'd41; in3 =  10'd31; #30;
		$finish;
	end

	pipeline uut(
	.clk(clk),
	.rst_n(rst_n),
	.in1(in1),
	.in2(in2),
	.in3(in3),
	.result(result));
	
	initial begin
		$dumpfile("./pipeline.vcd");
		$dumpvars(1, uut);
	end

endmodule
