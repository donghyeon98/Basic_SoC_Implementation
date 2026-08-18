`timescale 1ns / 1ps

module tb_Hamming_Code_Encoder		;
        reg clk               		;
        reg rst_n             		;
        reg [7:0] data_in     		;
        reg data_valid        		;
        wire [12:0] code_out  		;
        wire code_valid       		;

	Hamming_Code_Encoder dut(
	.clk(clk)			,
	.rst_n(rst_n)			,
	.data_in(data_in)		,
	.data_valid(data_valid)		,
	.code_out(code_out)		,
	.code_valid(code_valid)
	);

	initial begin
		clk = 1'b0		;
		forever #5 clk = ~clk	;
	end	

	initial begin

	end

endmodule
