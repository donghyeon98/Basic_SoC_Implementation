`timescale 1ns / 1ps

module T_FF(
	clk		,
	rst_n		,
	t		,
	q	
);

	input clk		;
	input rst_n		;
	input t			;
	output q		;

	reg q			;

	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) q <= 1'b0;
		else begin
			if(t) q <= ~q;
			else q <= q;
		end
	end

endmodule
