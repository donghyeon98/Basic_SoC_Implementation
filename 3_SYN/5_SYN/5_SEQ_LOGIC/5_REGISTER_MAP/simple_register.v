`timescale 1ns / 1ps

module simple_register #(parameter N = 32)(
	// port list
	clk,
	rst_n,
	wen,
	i_wdata,
	o_rdata
);

	input clk;
	input rst_n;
	input wen;
	input [N-1:0] i_wdata;
	output [N-1:0] o_rdata;

	reg [N-1:0] r_regdata;
	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) r_regdata <= 0;
		else if(wen) r_regdata <= i_wdata;
	end

	assign o_rdata = r_regdata;


endmodule
