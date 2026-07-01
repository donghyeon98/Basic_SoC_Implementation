`timescale 1ns / 1ps

module data_bus_driver(
	i_data_a,
	i_data_b,
	i_en_a,
	i_en_b,
	o_bus_data
);
	input [7:0] i_data_a	;
	input [7:0] i_data_b	;
	input	    i_en_a	;
	input 	    i_en_b	;
	output [7:0] o_bus_data	;
	
	reg [7:0] o_bus_data;
	
	always@(*) begin
		case({i_en_a, i_en_b})
			2'b10 : o_bus_data = i_data_a;
			2'b01 : o_bus_data = i_data_b;
			default : o_bus_data = 8'bz;
		endcase
	end

	/* assign o_bus_data = i_en_a ? i_data_a :
		             i_en_b ? i_data_b :
			     8'bz; */

endmodule
