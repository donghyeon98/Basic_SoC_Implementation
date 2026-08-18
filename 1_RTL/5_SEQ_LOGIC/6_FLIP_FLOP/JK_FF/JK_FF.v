`timescale 1ns / 1ps

module JK_FF(
	clk		,
	rst_n		,
	j		,
	k		,	
	q
);

	input clk		;
	input rst_n		;
	input j			;
	input k			;
	output q		;

	reg q			;

	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) q <= 1'b0;
		else begin
			case({j,k})
				2'b00: q <= q;
				2'b01: q <= 1'b0;
				2'b11: q <= ~q;
				2'b10: q <= 1'b1;
			endcase
		end
	end

endmodule
