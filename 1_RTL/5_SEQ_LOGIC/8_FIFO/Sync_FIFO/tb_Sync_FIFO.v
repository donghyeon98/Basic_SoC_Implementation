`timescale 1ns / 1ps

module tb_Sync_FIFO;
	parameter DATA_WIDTH = 8	;
	parameter DEPTH	     = 16	;

	reg clk				;
	reg rst_n			;
	reg wr_en			;
	reg rd_en			;
	reg [DATA_WIDTH-1:0] data_in	;
	wire [DATA_WIDTH-1:0] data_out  ;
	wire full			;
	wire empty			;
		
	Sync_FIFO #(.DATA_WIDTH(DATA_WIDTH),
		    .DEPTH(DEPTH)) dut(
	.clk(clk),
	.rst_n(rst_n),
	.wr_en(wr_en),
	.rd_en(rd_en),
	.data_in(data_in),
	.data_out(data_out),
	.full(full),
	.empty(empty));

	initial begin
		clk = 1'b0;
		forever #5 clk = ~clk;
	end

	initial begin
		rst_n = 1'b0; wr_en = 1'b0; rd_en = 1'b0; 
		data_in = 8'b0000_0000; #10;
		rst_n = 1'b1; 
		// write data
		wr_en = 1'b1;
		repeat (16) begin
           		@(posedge clk);
			@(negedge clk);
            		data_in = data_in + 1'b1;
        	end
		@(negedge clk);
                wr_en = 1'b0;

		@(negedge clk);
                rd_en = 1'b1;
                repeat (16) begin
                        @(posedge clk);
                end
		@(negedge clk);
                rd_en = 1'b0;
                #10;
		$finish;
	end

endmodule





