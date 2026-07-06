`timescale 1ns / 1ps

module register(
	clk,
	rst_n,
	i_in1,
	i_in2,
	o_out1,
	o_out2,	
);
	input clk;
	input rst_n;
	input [31:0] i_in1;
	input [31:0] i_in2;
	output [31:0] o_out1;
	output [31:0] o_out2;

	reg [31:0] o_out1;

	always@(posedge clk or negedge rst_n)begin
		if(~rst_n) o_out1 <= 32'd0;
		else o_out1 <= i_in1;
	end
	
	reg [31:0] o_out2;

	always@(posedge clk or negedge rst_n)begin
                if(~rst_n) o_out2 <= 32'd0;
                else o_out2 <= i_in2;
        end

endmodule
