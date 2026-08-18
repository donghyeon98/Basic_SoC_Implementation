`timescale 1ns / 1ps

module Up_Counter(
	clk		,
	rst_n		,
	enable		,
	count 
);

	input clk		;
	input rst_n		;
	input enable		;
	output [3:0] count	;

	reg [3:0] count		;

	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) count <= 4'd0;
		else if(enable) count <= count + 1;	
	end

endmodule
