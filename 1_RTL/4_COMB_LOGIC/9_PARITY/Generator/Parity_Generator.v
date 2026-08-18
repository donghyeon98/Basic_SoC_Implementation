`timescale 1ns / 1ps

module Parity_Generator(
	data,
	parity
);
	input [3:0] data		;
	output parity			;

	assign parity = ^data;

endmodule
