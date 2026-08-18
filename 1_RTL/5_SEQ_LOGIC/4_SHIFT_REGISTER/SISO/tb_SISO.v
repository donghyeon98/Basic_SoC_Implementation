`timescale 1ns / 1ps

module tb_SISO;
	reg clk		;
	reg rst_n	;
	reg serial_in	;
	wire serial_out	;

	parameter N = 8;

	SISO #(.N(N)) dut(
	.clk(clk),
	.rst_n(rst_n),
	.serial_in(serial_in),
	.serial_out(serial_out));

	initial begin
		clk = 1'b0;
		forever #5 clk = ~clk;
	end

	initial begin
		rst_n = 1'b0; serial_in = 1'b0;  #10;
		rst_n = 1'b1; serial_in = 1'b0;  #10;
		serial_in = 1'b0; #10;
        	serial_in = 1'b1; #10;
        	serial_in = 1'b0; #10;
        	serial_in = 1'b1; #10;
        	serial_in = 1'b1; #10;
		serial_in = 1'b1; #10;
        	serial_in = 1'b0; #100;
		$finish;
	end

endmodule
