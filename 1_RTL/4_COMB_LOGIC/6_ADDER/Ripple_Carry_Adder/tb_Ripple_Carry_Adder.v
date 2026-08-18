`timescale 1ns / 1ps 

module tb_Ripple_Carry_Adder;
	reg [3:0] a		;
	reg [3:0] b		;
	reg cin 		;
	wire [3:0] sum		;
	wire carry		;

	Ripple_Carry_Adder dut(
	.a(a),
	.b(b),
	.cin(cin),
	.sum(sum),
	.carry(carry));

	initial begin
		 a = 4'b0001; b = 4'b0001; cin = 1'b0; #10
		 a = 4'b1111; b = 4'b1111; cin = 1'b0; #10
		 a = 4'b1001; b = 4'b0101; cin = 1'b0; #10
                 a = 4'b1111; b = 4'b1111; cin = 1'b1; #10	
		$finish;
	end

endmodule
