`timescale 1ns / 1ps

module BCD_Counter(
	clk		,
	rst_n		,
	enable		,
	up_down		,
	count		
);

	input clk		;
	input rst_n		;
	input enable		;
	input up_down		;
	output [3:0] count	;
	
	reg [3:0] count		;

	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) count <= 4'd0;
		else if(enable) begin
			if(up_down) begin
				if(count >= 4'd9) count <=0;
				else count <= count + 1;
			end
			else begin
				if(count == 4'd0) count <= 9;
				else count <= count - 1;
			end
		end
	end

endmodule
