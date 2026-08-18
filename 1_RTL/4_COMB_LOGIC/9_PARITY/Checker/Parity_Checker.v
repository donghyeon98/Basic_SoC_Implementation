`timescale 1ns / 1ps

module Parity_Checker(
	data,
	parity,
	error
);

	input [3:0] data		;
	input parity 			;
	output error			;

	assign error = ^{data, parity};

endmodule
