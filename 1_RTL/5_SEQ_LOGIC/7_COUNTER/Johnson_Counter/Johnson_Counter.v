`timescale 1ns / 1ps

module Johnson_Counter(
	clk		,
	rst_n		,
	q		
);

	input clk		;
	input rst_n		;
	output [3:0] q		;

	reg [3:0] q		;

	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) q <= 4'd0;
		else q <= {q[2:0],~q[3]};
	end

endmodule
