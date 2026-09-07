`timescale 1ns / 1ps

module LIFO_STACK #(
	parameter DATA_WIDTH = 8				,
        parameter DEPTH = 16					,
        parameter PTR_WIDTH = $clog2(DEPTH) + 1
)(	clk							,
	rst_n							,
	push							,
	pop							,
	data_in							,
	data_out						,
	full							,
	empty	
);

	input clk						;
	input rst_n						;
	input pop						;
	input push						;
	input [DATA_WIDTH-1:0] data_in  			;
	output [DATA_WIDTH-1:0] data_out			;
	output full						;
	output empty						;
	
	reg [DATA_WIDTH-1:0] mem [0:DEPTH-1]			;
	reg [PTR_WIDTH-1:0] sp					;
	
	assign full  = (sp == DEPTH)				;
	assign empty = (sp == 0)				;

	reg [DATA_WIDTH-1:0] data_out        			;

	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			data_out <= 0				;
			sp 	 <= 0				;
		end
		else begin
			case ({push && !full, pop && !empty})
				2'b10: begin 
					mem[sp] <= data_in	;
					sp      <= sp + 1	;
				end
				2'b01: begin
					data_out <= mem[sp-1]	;
					sp 	 <= sp - 1	;	
				end
				default: 			;
			endcase
		end
	end

endmodule
