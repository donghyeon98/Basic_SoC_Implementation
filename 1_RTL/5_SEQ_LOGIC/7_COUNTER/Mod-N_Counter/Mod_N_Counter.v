`timescale 1ns / 1ps 

module Mod_N_Counter #(parameter N = 10)( 
	clk,
	rst_n,
	enable,	
	count
);

	localparam WIDTH = $clog2(N);

	input clk			;
	input rst_n			;
	input enable			;
	output [WIDTH-1:0] count	;

	reg [WIDTH-1:0] count		;
	
	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) count <= {WIDTH{1'b0}};
		else if(enable) begin
			if(count == N - 1) count <= {WIDTH{1'b0}};
			else count <= count + 1;
		end
	end

endmodule
