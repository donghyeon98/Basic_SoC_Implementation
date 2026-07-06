`timescale 1ns / 1ps

module fdivider #(parameter DIVISOR = 10)(
	// port list
	clk_in,
	rst_n,
	o_clk_out
);

	input clk_in;
	input rst_n;
	output o_clk_out;
		
	localparam WIDTH =$clog2(DIVISOR);	
	
	// internal register
	reg [WIDTH-1:0] r_count;

	reg o_clk_out;
	always@(posedge clk_in or negedge rst_n) begin
		if(!rst_n) begin
			o_clk_out <= 1'b0;
			r_count <= 0;
		end
		else begin
			if(r_count == DIVISOR - 1) r_count <= 0;
			else r_count <= r_count +1'b1;
		end
		
		// toggle divided clock when r_count comes to the half
		if(r_count == (DIVISOR/2) - 1) o_clk_out <= 1'b1;
		else if(r_count == DIVISOR -1) o_clk_out <= 1'b0;
	end
	
endmodule
	
