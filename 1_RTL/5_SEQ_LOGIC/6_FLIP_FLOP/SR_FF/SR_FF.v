`timescale 1ns / 1ps

module SR_FF(
	clk		,
	rst_n		,
	s		,
	r		,
	q
);

	input clk		;
	input rst_n		;
	input s			;
	input r			;
	output q		;

	reg q			;

	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) q <= 0;
		else begin
			case({s,r}) 
				2'b00: q <= q;
				2'b01: q <= 1'b0;
				2'b11: q <= 1'bx;
				2'b10: q <= 1'b1;
			endcase
		end
	end

endmodule
