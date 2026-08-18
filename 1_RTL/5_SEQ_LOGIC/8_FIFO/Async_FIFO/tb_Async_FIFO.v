`timescale 1ns / 1ps

module tb_Async_FIFO;
	parameter DATA_WIDTH = 8;
	parameter DEPTH      = 16;
	
	reg wr_clk			;
	reg wr_rst_n			;
	reg wr_en			;
	reg rd_clk			;
	reg rd_rst_n			;
	reg rd_en			;
	reg [DATA_WIDTH-1:0] data_in	;
	wire [DATA_WIDTH-1:0] data_out	;
	wire full			;
	wire empty			;

	Async_FIFO #(DATA_WIDTH(DATA_WIDTH),
		     DEPTH(DEPTH)) dut(
		



endmodule
