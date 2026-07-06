`timescale 1ns / 1ps

module comparator #(parameter N = 32)(
	// port list
	i_in1,
	i_in2,
	o_equal,
	o_great,
	o_less
);
	// port declaration
	input [N-1:0] i_in1;
	input [N-1:0] i_in2;
	output o_equal;
	output o_great;
	output o_less;
	
	// modeling
	assign o_equal = (i_in1 == i_in2) ? 1'b1 : 1'b0;
	assign o_great = (i_in1 > i_in2) ? 1'b1 : 1'b0;
	assign o_less  = (i_in1 < i_in2) ? 1'b1 : 1'b0; 
	
	/* reg o_equal;
	 reg o_great;
	 reg o_less;	

	 always@(*) begin
		o_equal = 1'b0;
		o_great = 1'b0;
		o_less = 1'b0;
		if(i_in1 == i_in2) o_equal = 1'b1;
		else if(i_in1 > i_in2) o_great = 1'b1;
		else if(i_in1 < i_in2) o_less = 1'b1;
	end */ 


endmodule
