`timescale 1ns / 1ps

module multiplexed_bus_driver(
	// port list
	i_data_a,
	i_data_b,
	i_en_a,
	i_en_b,
	o_bus_data
);
	// port declaration
	input [31:0] i_data_a;
	input [31:0] i_data_b;
	input i_en_a;
	input i_en_b;
	output [31:0] o_bus_data;

	wire w_select;
	wire [31:0] w_mux_out;
	
	// modeling 
	assign w_select = i_en_a ^ i_en_b;
	//xor u1 (w_select, i_en_a, i_en_b);
	
	assign w_mux_out = i_en_a ? i_data_a :
			   i_en_b ? i_data_b :
			   32'dz;

	assign o_bus_data = w_select ? w_mux_out : 32'dz; 	   
	
endmodule
