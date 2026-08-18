`timescale 1ns / 1ps 

module PIPO #(parameter N = 8)(
	clk			,
	rst_n			,
	load			,
	parallel_in		,
	parallel_out
);
	input clk			;
	input rst_n			;
	input load			;
	input [N-1:0] parallel_in	;
	output [N-1:0] parallel_out	;

	reg [N-1:0] parallel_out	;
	
	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) parallel_out <= {N{1'b0}};
		else if(load) parallel_out <= parallel_in;
	end

endmodule
