`timescale 1ns / 1ps 

module SISO #(parameter N = 8) (
	clk		,
	rst_n		,
	serial_in	,
	serial_out
);

	input clk 		;
	input rst_n		;
	input serial_in		;
	output serial_out	;

	reg [N-1:0] shift_reg	;

	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) shift_reg <= {N{1'b0}};
		else shift_reg <= {shift_reg[N-2:0],serial_in};
	end

	assign serial_out = shift_reg[N-1];

endmodule
