`timescale 1ns / 1ps

module tb_Adder_Subtractor;
	reg [3:0] a		;
	reg [3:0] b		;
	reg sub			;
	wire [3:0] result 	;
	wire cout		;
	
	Adder_Subtractor dut(
	.a(a),
	.b(b),
	.sub(sub),
	.result(result),
	.cout(cout));

	integer i, j, k		;
	
	initial begin
		for(i = 0; i < 16; i = i + 1) begin
			for(j = 0; j < 16; j = j + 1) begin
				for(k = 0; k < 2; k = k + 1) begin
					a = i;
					b = j;
					sub = k;
					#10;
				end
			end
		end
		$finish;
	end

endmodule
