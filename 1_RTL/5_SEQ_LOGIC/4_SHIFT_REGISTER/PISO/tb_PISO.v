`timescale 1ns / 1ps

module tb_PISO;

	parameter N = 8		;

	reg clk			;
	reg rst_n		;
	reg [N-1:0] parallel_in	;
	reg load		;
	wire serial_out		;

	PISO #(.N(N)) dut(
	.clk(clk),
	.rst_n(rst_n),
	.parallel_in(parallel_in),
	.load(load),
	.serial_out(serial_out));

	initial begin
		clk = 1'b0;
		forever #5 clk = ~clk;
	end

	initial begin
		rst_n = 1'b0; load = 0; parallel_in = 0; #10;
		rst_n = 1'b0; load = 1; parallel_in = 0; #10;
		rst_n = 1'b1; load = 0; parallel_in = 0; #10;
		load = 1'b1; parallel_in = 8'b11111011; #10;
		load = 1'b0; #100;
		load = 1'b1; parallel_in = 8'b10101010; #10;
		load = 1'b0; #100;
		$finish;
	end

endmodule
