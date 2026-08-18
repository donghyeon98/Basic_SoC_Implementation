`timescale 1ns / 1ps

module tb_ALU;
	reg [3:0] a		;
	reg [3:0] b		;
	reg [2:0] op		;
	wire [3:0] result	;
	wire cout		;
	wire zero		;
	
	ALU dut(
	.a(a),
	.b(b),
	.op(op),
	.result(result),
	.cout(cout),
	.zero(zero));

	integer i, j, k;

	initial begin
		for (i = 0; i < 16; i = i + 1) begin
			for (j = 0; j < 16; j = j + 1) begin
				for (k = 0; k < 8; k = k + 1) begin
					a  = i;
                   			b  = j;
                    			op = k;
                    			#10;
				end
			end
		end
		$finish;
	end

endmodule
