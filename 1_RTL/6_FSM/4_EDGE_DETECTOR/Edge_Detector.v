`timescale 1ns / 1ps

module Edge_Detector(
	clk					,
	rst_n					,
	cp					,
	p_edge					,
	n_edge	
)						;

	input clk				;
	input rst_n				;
	input cp				;
	output p_edge				;
	output n_edge				;

	reg ff_cur				;
	reg ff_old				;

	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			ff_cur <= 1'b0		;
			ff_old <= 1'b0		;
		end
		else begin
			ff_cur <= cp		;
			ff_old <= ff_cur	;
		end
	end

	assign p_edge = ~ff_old & ff_cur	;
	assign n_edge = ff_old & ~ff_cur	;

endmodule
