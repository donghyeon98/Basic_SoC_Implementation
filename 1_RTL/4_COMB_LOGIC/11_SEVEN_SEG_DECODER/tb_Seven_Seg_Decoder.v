`timescale 1ns / 1ps

module tb_Seven_Seg_Decoder;
	reg [3:0] bcd;
	wire [7:0] seg;

	Seven_Seg_Decoder dut(
	.bcd(bcd),
	.seg(seg));

	integer i;

	initial begin
		for(i = 0; i < 16; i = i + 1) begin
			bcd = i;
			#10;
		end
		$finish;
	end	

endmodule
