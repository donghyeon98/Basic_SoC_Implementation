`timescale 1ns / 1ps

module Ripple_Carry_Adder(
	// port list
        a		,
	b		,
	cin		,
	sum		,
	carry		
);

	// port declaration
	input [3:0] a		;
	input [3:0] b		;
	input cin		;
	output [3:0] sum	;
	output carry		;

	// modeling
	wire [2:0] carry_w	;

	Full_Adder f0(
	.a(a[0]),
	.b(b[0]),
	.cin(cin),
	.sum(sum[0]),
	.carry(carry_w[0]));

	Full_Adder f1(
        .a(a[1]),
        .b(b[1]),
        .cin(carry_w[0]),
        .sum(sum[1]),
        .carry(carry_w[1]));

	Full_Adder f2(
        .a(a[2]),
        .b(b[2]),
        .cin(carry_w[1]),
        .sum(sum[2]),
        .carry(carry_w[2]));

        Full_Adder f3(
        .a(a[3]),
        .b(b[3]),
        .cin(carry_w[2]),
        .sum(sum[3]),
        .carry(carry));

endmodule
