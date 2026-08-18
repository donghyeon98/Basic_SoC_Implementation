`timescale 1ns / 1ps

module Sync_FIFO #(
	parameter DATA_WIDTH = 8					,
	parameter DEPTH      = 16
)(
	clk								,
	rst_n								,
	wr_en								,	
	rd_en								,
	data_in								,
	data_out							,
	full								,
	empty		
);

	localparam ADDR_WIDTH = $clog2(DEPTH);

	input clk							;
	input rst_n							;	
	input wr_en							;
	input rd_en							;
	input [DATA_WIDTH-1:0] data_in					;
	output [DATA_WIDTH-1:0] data_out				;
	output full							;
	output empty							;
	
	reg [DATA_WIDTH-1:0] data_out					;

	reg [DATA_WIDTH-1:0] mem [0:DEPTH-1]  			;
	reg [DATA_WIDTH-1:0] wr_ptr					;
	reg [DATA_WIDTH-1:0] rd_ptr					;

	assign full  = (wr_ptr[ADDR_WIDTH] != rd_ptr[ADDR_WIDTH]) &&
                   (wr_ptr[ADDR_WIDTH-1:0] == rd_ptr[ADDR_WIDTH-1:0])	;
    	
	assign empty = (wr_ptr == rd_ptr)				;

	// write
	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) wr_ptr <= 0;
		else if(wr_en && !full) begin
			mem[wr_ptr[ADDR_WIDTH-1:0]] <= data_in		;
            		wr_ptr                      <= wr_ptr + 1	;
		end
	end

	// read
	always@(posedge clk or negedge rst_n) begin
        	if(!rst_n) rd_ptr <= 0;
        	else if(rd_en && !empty) begin
            		data_out <= mem[rd_ptr[ADDR_WIDTH-1:0]]		;
            		rd_ptr   <= rd_ptr + 1				;
        	end
   	 end

endmodule



	
