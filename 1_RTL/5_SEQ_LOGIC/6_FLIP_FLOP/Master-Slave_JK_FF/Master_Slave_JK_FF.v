`timescale 1ns / 1ps 

module Master_Slave_JK_FF(
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
	reg q_m			;

	always@(*) begin
		if(!rst_n) q_m = 1'b0;
		else if(clk) begin
			case({j,k})
				2'b00: q_m = q_m;
				2'b01: q_m = 1'b0;
				2'b11: q_m = ~q_m;
				2'b10: q_m = ~q_m;
			endcase	
		end
	end

	always@(*) begin
		if(!rst_n) q = 1'b0;
		else if(!clk) q = q_m;
	end

endmodule
