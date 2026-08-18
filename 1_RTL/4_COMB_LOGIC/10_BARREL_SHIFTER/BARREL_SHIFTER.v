`timescale 1ns / 1ps

module BARREL_SHIFTER #(parameter WIDTH = 8)(
	data_in					,
	shift_amt				,
	data_out
);

	input [WIDTH-1:0] data_in		;
	input [$clog2(WIDTH)-1:0] shift_amt	;
	output [WIDTH-1:0] data_out		;

	wire [WIDTH-1:0] stage0, stage1, stage2	;

	assign stage0 = shift_amt[0] ? {data_in[WIDTH-2:0], 1'b0} : data_in;
	assign stage1 = shift_amt[1] ? {stage0[WIDTH-3:0], 2'b00} : stage0;
	assign stage2 = shift_amt[2] ? {stage1[WIDTH-5:0], 4'b0000} : stage1;

	assign data_out = stage2;

endmodule
