`timescale 1ns / 1ps

module Gray_Counter(
	clk		,
	rst_n		,
	gray	
);

	input clk		;
	input rst_n		;
	output [3:0] gray	;

	reg [3:0] bin		;

	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) bin <= 4'd0;
		else bin <= bin + 1;
	end

	assign gray = bin ^ (bin >> 1);

endmodule
