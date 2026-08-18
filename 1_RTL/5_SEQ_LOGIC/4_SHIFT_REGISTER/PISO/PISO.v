`timescale 1ns / 1ps

module PISO #(parameter N =8)(
	clk			,
	rst_n			,
	parallel_in		,
	load			,
	serial_out	
);

	input clk			;
	input rst_n			;
	input [N-1:0] parallel_in	;
	input load			;
	output serial_out		;
	
	reg [N-1:0] shift_reg		;
	
	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) shift_reg <= {N{1'b0}};
		else begin
			if(load) shift_reg <= parallel_in;
			else shift_reg <= {shift_reg[N-2:0], 1'b0};
		end
	end

	assign serial_out = shift_reg[N-1];

endmodule
