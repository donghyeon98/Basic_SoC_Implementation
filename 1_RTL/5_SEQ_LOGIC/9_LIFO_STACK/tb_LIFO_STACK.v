`timescale 1ns / 1ps

module tb_LIFO_STACK;
	parameter DATA_WIDTH = 8				;
        parameter DEPTH = 16					;
        parameter PTR_WIDTH = $clog2(DEPTH) + 1			;

	reg clk                               			;
        reg rst_n                             			;
        reg pop                               			;
        reg push                              			;
        reg [DATA_WIDTH-1:0] data_in          			;
        wire [DATA_WIDTH-1:0] data_out        			;
        wire full                             			;
        wire empty                            			;

	LIFO_STACK #(
	.DATA_WIDTH(DATA_WIDTH)					,	
	.DEPTH(DEPTH)						,
	.PTR_WIDTH(PTR_WIDTH)
	) dut(
	.clk(clk)						,
	.rst_n(rst_n)						,
	.pop(pop)						,
	.push(push)						,
	.data_in(data_in)					,
	.data_out(data_out)					,
	.full(full)						,
	.empty(empty)
	)							;

	initial begin
		clk = 1'b0					;
		forever #5 clk = ~clk				;
	end

	initial begin
		rst_n = 1'b0					; 
		pop = 1'b0					; 
		push = 1'b0      				;
		data_in = 8'b00000000				;
		#10						;
		rst_n = 1'b1					; 
		pop = 1'b0					; 
		push = 1'b1					;
		repeat (16) begin
			@(posedge clk)				;
			@(negedge clk)				;
			data_in = data_in + 1'b1		;
		end 
		pop = 1'b1					; 
		push = 1'b0					;
		repeat (16) begin
			@(posedge clk)				;
		end
		@(negedge clk)					;
		pop = 1'b0					;
		push = 1'b0					;
		#10						;
		$finish						;
	end

endmodule
