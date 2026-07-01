`timescale 1ns / 1ps

module pipeline(
	input clk,
	input rst_n,
	input [9:0] in1,
	input [9:0] in2,
	input [9:0] in3,
	output reg [11:0] result);
	
	reg [10:0] add_1;
	reg [9:0] in3_c;
	
	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			add_1 <= 0;
			in3_c <= 0;
		end
		else begin
			add_1 <= {1'b0, in1} + {1'b0, in2};
			in3_c <= in3; 
		end
	end

	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) result <= 0;
		else result <= {1'b0, add_1} + {2'b0, in3_c};

	end
	
endmodule
