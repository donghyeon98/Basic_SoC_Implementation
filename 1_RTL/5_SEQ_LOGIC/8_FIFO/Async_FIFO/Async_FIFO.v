`timescale 1ns / 1ps

module Async_FIFO #
parameter DATA_WIDTH = 8, 
parameter DEPTH      = 16
)(
	wr_clk			,
	wr_rst_n		,
	wr_en			,
	data_in			,
	rd_clk			,
	rd_rst_n		,
	rd_en			,
	data_out		,
	full			,
	empty			
);

	localparam ADDR_WIDTH = $clog2(DEPTH)	;
	
	input wr_clk				;
	input wr_rst_n				;
	input wr_en				;
	input [DATA_WIDTH-1:0] data_in		;
	input rd_clk				;
	input rd_rst_n				;
	input rd_en				;
	output [DATA_WIDTH-1:0] data_out	;
	output full				;
	output empty				;

	reg [DATA_WIDTH-1:0] data_out        	;

	// WRITE

	reg  [ADDR_WIDTH:0] wr_ptr_bin, wr_ptr_gray ;
    	wire [ADDR_WIDTH:0] wr_ptr_gray_next ;
    	reg  [ADDR_WIDTH:0] rd_ptr_gray_sync1, rd_ptr_gray_sync2 ;

	assign wr_ptr_gray_next = (wr_ptr_bin + 1) ^ ((wr_ptr_bin + 1) >> 1);

	always@(posedge wr_clk or negedge wr_rst_n) begin
        	if(!wr_rst_n) begin
            		wr_ptr_bin  <= 0;
            		wr_ptr_gray <= 0;
        	end 
		else if(wr_en && !full) begin
            		mem[wr_ptr_bin[ADDR_WIDTH-1:0]] <= data_in;
            		wr_ptr_bin  <= wr_ptr_bin + 1;
            		wr_ptr_gray <= wr_ptr_gray_next;
        	end
    	end
	
	always@(posedge wr_clk or negedge wr_rst_n) begin
        	if(!wr_rst_n) begin
            		rd_ptr_gray_sync1 <= 0;
            		rd_ptr_gray_sync2 <= 0;
        	end 
		else begin
            		rd_ptr_gray_sync1 <= rd_ptr_gray;
            		rd_ptr_gray_sync2 <= rd_ptr_gray_sync1;
        	end
    	end

	assign full = (wr_ptr_gray_next == {~rd_ptr_gray_sync2[ADDR_WIDTH:ADDR_WIDTH-1],
                                            rd_ptr_gray_sync2[ADDR_WIDTH-2:0]});
	
	// READ

	reg  [ADDR_WIDTH:0] rd_ptr_bin ;
    	wire [ADDR_WIDTH:0] rd_ptr_gray_next ;
    	reg  [ADDR_WIDTH:0] wr_ptr_gray_sync1, wr_ptr_gray_sync2 ;

	assign rd_ptr_gray_next = (rd_ptr_bin + 1) ^ ((rd_ptr_bin + 1) >> 1);

    	always@(posedge rd_clk or negedge rd_rst_n) begin
        	if(!rd_rst_n) begin
            		rd_ptr_bin  <= 0;
            		rd_ptr_gray <= 0;
            		data_out    <= 0;
        	end 
		else if(rd_en && !empty) begin
            		data_out   <= mem[rd_ptr_bin[ADDR_WIDTH-1:0]];
            		rd_ptr_bin  <= rd_ptr_bin + 1;
            		rd_ptr_gray <= rd_ptr_gray_next;
        	end
    	end
	
	always@(posedge rd_clk or negedge rd_rst_n) begin
        	if(!rd_rst_n) begin
            		wr_ptr_gray_sync1 <= 0;
            		wr_ptr_gray_sync2 <= 0;
        	end 
		else begin
            		wr_ptr_gray_sync1 <= wr_ptr_gray;
            		wr_ptr_gray_sync2 <= wr_ptr_gray_sync1;
        	end
    	end

	assign empty = (rd_ptr_gray_next == wr_ptr_gray_sync2);

endmodule
