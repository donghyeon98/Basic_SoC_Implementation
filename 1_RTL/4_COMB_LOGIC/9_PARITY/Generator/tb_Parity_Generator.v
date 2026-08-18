`timescale 1ns / 1ps

module tb_Parity_Generator;
	reg [3:0] data;
	wire parity;

	Parity_Generator dut(
	.data(data),
	.parity(parity));

	integer i;

	initial begin
		for(i = 0; i < 16; i = i + 1) begin
			data = i;
			#10;
		end
		$finish;
	end

endmodule
