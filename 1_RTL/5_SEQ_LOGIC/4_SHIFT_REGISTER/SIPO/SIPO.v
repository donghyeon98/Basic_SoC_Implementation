`timescale 1ns / 1ps

module SIPO #(parameter N = 8)(
	clk		,
	rst_n		,
	serial_in	,
	parallel_out
);

	input clk			;
	input rst_n			;
	input serial_in			;
	output [N-1:0] parallel_out	;

	reg [N-1:0] parallel_out     	;

	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) parallel_out <= {N{1'b0}};
		else parallel_out <= {parallel_out[N-2:0], serial_in};
	end

endmodule
