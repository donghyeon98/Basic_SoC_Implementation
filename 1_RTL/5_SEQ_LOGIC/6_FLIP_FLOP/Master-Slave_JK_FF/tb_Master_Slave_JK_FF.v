`timescale 1ns / 1ps

module tb_Master_Slave_JK_FF;
	reg clk		;
	reg rst_n	;
	reg j		;
	reg k		;
	wire q		;

	Master_Slave_JK_FF dut(
	.clk(clk),
	.rst_n(rst_n),
	.j(j),
	.k(k),
	.q(q));
	
	initial begin	
		clk = 1'b0;
		forever #5 clk = ~clk;
	end

	initial begin
		rst_n = 1'b0; j = 1'b0; k = 1'b0; #10;
		rst_n = 1'b0; j = 1'b0; k = 1'b1; #10;
		rst_n = 1'b0; j = 1'b1; k = 1'b1; #10;
		rst_n = 1'b0; j = 1'b1; k = 1'b0; #10;
		rst_n = 1'b1; j = 1'b0; k = 1'b0; #10;
                rst_n = 1'b1; j = 1'b0; k = 1'b1; #10;
                rst_n = 1'b1; j = 1'b1; k = 1'b1; #10;
                rst_n = 1'b1; j = 1'b1; k = 1'b0; #10;
		$finish;
	end

endmodule
