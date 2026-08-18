`timescale 1ns / 1ps

module tb_PIPO;

	parameter N = 8;

	reg clk				;
	reg rst_n			;
	reg load 			;
	reg [N-1:0] parallel_in		;
	wire [N-1:0] parallel_out	;

	PIPO #(.N(N)) dut(
	.clk(clk),
	.rst_n(rst_n),
	.load(load),
	.parallel_in(parallel_in),
	.parallel_out(parallel_out));

	initial begin
		clk = 1'b0;
		forever #5 clk = ~clk;
	end

	initial begin
		rst_n = 1'b0; load = 1'b0; parallel_in = 8'b00000000; #10;
		rst_n = 1'b0; load = 1'b1; parallel_in = 8'b00000000; #10;
		rst_n = 1'b1; load = 1'b0; parallel_in = 8'b00000000; #10;
		rst_n = 1'b0; load = 1'b1; parallel_in = 8'b10101010; #10;
		rst_n = 1'b0; load = 1'b0; parallel_in = 8'b10101010; #100;
		rst_n = 1'b0; load = 1'b1; parallel_in = 8'b11110000; #10;
                rst_n = 1'b0; load = 1'b0; parallel_in = 8'b11110000; #100;
		$finish;
	end


endmodule
