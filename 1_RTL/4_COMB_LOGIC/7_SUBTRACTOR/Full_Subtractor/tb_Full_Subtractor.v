`timescale 1ns / 1ns

module tb_Full_Subtractor;
	reg a		;
	reg b		;
	reg cin		;
	wire diff	;
	wire borrow	;

	Full_Subtractor dut(
	.a(a),
	.b(b),
	.cin(cin),
	.diff(diff),
	.borrow(borrow));

	initial begin
		a = 1'b0; b = 1'b0; cin = 1'b0; #10
		a = 1'b1; b = 1'b0; cin = 1'b0; #10
		a = 1'b0; b = 1'b1; cin = 1'b0; #10
                a = 1'b0; b = 1'b0; cin = 1'b1; #10
		a = 1'b1; b = 1'b1; cin = 1'b0; #10
                a = 1'b1; b = 1'b0; cin = 1'b1; #10
                a = 1'b0; b = 1'b1; cin = 1'b1; #10
                a = 1'b1; b = 1'b1; cin = 1'b1; #10
		$finish;
	end

endmodule
