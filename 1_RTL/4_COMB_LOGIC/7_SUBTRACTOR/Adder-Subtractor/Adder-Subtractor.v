`timescale 1ns / 1ns

module Adder_Subtractor(
	a		,
	b		,
	sub		,
	result		,
	cout
);
	input [3:0] a		;
	input [3:0] b		;
	input sub		;
	output [3:0] result	;
	output cout		;
	
	wire [3:0] b_xor	;
	wire [2:0] carry_w	;
	
	assign b_xor = b ^ {4{sub}};

	Full_Adder f0(
	.a(a[0]),
	.b(b_xor[0]),
	.cin(sub),
	.sum(result[0]),
	.carry(carry_w[0]));

	Full_Adder f1(
        .a(a[1]),
        .b(b_xor[1]),
        .cin(carry_w[0]),
        .sum(result[1]),
        .carry(carry_w[1]));

	Full_Adder f2(
        .a(a[2]),
        .b(b_xor[2]),
        .cin(carry_w[1]),
        .sum(result[2]),
        .carry(carry_w[2]));

	Full_Adder f3(
        .a(a[3]),
        .b(b_xor[3]),
        .cin(carry_w[2]),
        .sum(result[3]),
        .carry(cout));

	/*
 	reg [3:0] result 	;
	reg cout 		;

	always@(*) begin
		if(sub) {cout, result} = a - b;
		else {cout, result} = a + b;
	end
	*/

	/*
        reg [3:0] result        ;
        reg cout                ;
 
        always@(*) begin
        	case(sub)
			1'b0 : {cout, result} = a + b;
			1'b1 : {cout, result} = a - b;
		endcase
	end
        */

endmodule
