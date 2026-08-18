`timescale 1ns / 1ps

module tb_Parity_Checker;
	reg [3:0] data		;
	reg parity		;
	wire error		;

	Parity_Checker dut(
	.data(data),
	.parity(parity),
	.error(error));

	integer i, j;

	initial begin
		for(i = 0; i < 16; i = i + 1) begin
			for(j = 0; j < 2; j = j + 1) begin
				data = i;
				parity = j;
				#10;
			end
		end
		$finish;
	end

endmodule
