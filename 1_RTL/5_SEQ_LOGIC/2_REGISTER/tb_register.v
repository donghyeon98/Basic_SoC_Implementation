`timescale 1ns / 1ps

module tb_register;
	reg clk;
	reg rst_n;
	reg [31:0] i_in1;
	reg [31:0] i_in2;
	wire [31:0] o_out1;
	wire [31:0] o_out2;

	register dut(
	.clk(clk),
	.rst_n(rst_n),
	.i_in1(i_in1),
	.i_in2(i_in2),
	.o_out1(o_out1),
	.o_out2(o_out2));

	initial begin
		$dumpfile("./register.vcd");
		$dumpvars(0,tb_register);
	end
	
	initial begin
		clk = 0;
		forever #5 clk = ~clk;
	end

	initial begin
		rst_n = 1'b0; i_in1 = 32'd1; i_in2 = 32'd1; #10;
		rst_n =1'b1; #10;
		i_in1 = 32'd10; i_in2 = 32'd30; #10;
		$finish;  
	end

endmodule
