`timescale 1ns / 1ps

module tb_baud_rate_gen			;
	parameter FPGA_CLK  = 640	;
	parameter BAUD_RATE = 10	;

	reg clk				;
        reg rst_n			;
        wire os_tick			;
        wire baud_tick			;

	baud_rate_gen #(.FPGA_CLK(FPGA_CLK),
			.BAUD_RATE(BAUD_RATE)) 
	dut(
        .clk(clk)			,
        .rst_n(rst_n)			,
        .os_tick(os_tick)		,
        .baud_tick(baud_tick))		;

	initial begin
		clk = 1'b0;
		forever #5 clk = ~clk;
	end

	initial begin
		rst_n = 1'b0; #10;
		rst_n = 1'b1; #1000;
		$finish;
	end

endmodule

