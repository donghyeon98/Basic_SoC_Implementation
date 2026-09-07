`timescale 1ns / 1ps

module LFSR(
	clk					,		
	rst_n					,		
	q					,
)						;

	input clk				;
	input rst_n				;
	output [3:0] q				;

	reg [3:0] r_q = 4'b1011			;			
	wire fb					;
	assign fb = r_q[3] ^ r_q[0]		;

	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) r_q <= 4'b1011	;
		else       r_q <= {r_q[2:0],fb}	;
	end

	assign q = r_q				;

endmodule
