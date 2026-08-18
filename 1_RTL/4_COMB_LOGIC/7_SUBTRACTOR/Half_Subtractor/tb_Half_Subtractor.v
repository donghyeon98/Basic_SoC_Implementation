`timescale 1ns / 1ps

module tb_Half_Subtractor;
	reg a		;
	reg b		;
	wire diff	;
	wire borrow	;

	Half_Subtractor dut(
	.a(a),
	.b(b),
	.diff(diff),
	.borrow(borrow));
	
	initial begin
		a = 1'b0; b = 1'b0; #10
		a = 1'b0; b = 1'b1; #10
		a = 1'b1; b = 1'b1; #10
                a = 1'b1; b = 1'b0; #10
		$finish;
	end		

endmodule
