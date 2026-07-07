`timescale 1ns / 1ps

module shift_register_sipo #(parameter WIDTH = 8)(
	// port list
	clk,
	rst_n,
	i_serial_in,
	load,
	o_parallel_out
);

	input clk;
	input rst_n;
	input i_serial_in;
	input load;
	output [WIDTH-1:0] o_parallel_out;

	reg [WIDTH-1:0] r_reg_data;
	
	reg [WIDTH-1:0] o_parallel_out;
	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
	       		r_reg_data <= 0;
			o_parallel_out <= 0;
		end
		else if(load) o_parallel_out <= r_reg_data;
		else r_reg_data <= {r_reg_data[WIDTH-2:0], i_serial_in};
	end

endmodule 
	
	
