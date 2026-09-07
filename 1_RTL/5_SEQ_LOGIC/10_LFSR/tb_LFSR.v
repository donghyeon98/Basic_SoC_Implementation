`timescale 1ns / 1ps

module tb_LFSR;
	reg clk                         ;
        reg rst_n                       ;
        wire [3:0] q                    ;

	LFSR dut(
	.clk(clk),
	.rst_n(rst_n),
	.q(q)
	)				;

	initial begin	
		clk = 1'b0		;
		forever #5 clk = ~clk	;
	end

	initial begin
		rst_n = 1'b0; #10	;
		rst_n = 1'b1; #100	;
		$finish			;
	end

endmodule
