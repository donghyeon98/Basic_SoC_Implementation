`timescale 1ns / 1ps

module D_FF(
	clk,
	rst_n,
	d,
	q
);
	input clk		;
	input rst_n		;
	input d			;
	output q		;

	reg q			;

	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) q <= 1'b0	;
		else q <= d		;
	end

endmodule
