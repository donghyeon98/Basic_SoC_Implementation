`timescale 1ns / 1ps 

module Full_Adder(
	// port list
	a		,
	b		,
	cin		,
	sum		,
	carry
);

	// port declaration
	input a		;
	input b		;
	input cin 	;
	output sum	;
	output carry	;

	// modeling
	reg sum		;
	reg carry	;

	always@(*) begin
		case({a,b,cin})
			3'b000 : begin sum = 1'b0; carry = 1'b0; end	
			3'b001 : begin sum = 1'b1; carry = 1'b0; end   
			3'b011 : begin sum = 1'b0; carry = 1'b1; end   
                        3'b010 : begin sum = 1'b1; carry = 1'b0; end   
			3'b110 : begin sum = 1'b0; carry = 1'b1; end   
                        3'b111 : begin sum = 1'b1; carry = 1'b1; end   
                        3'b101 : begin sum = 1'b0; carry = 1'b1; end   
                        3'b100 : begin sum = 1'b1; carry = 1'b0; end   
		endcase
	end

	/*
 	always@(*) begin
		{carry,sum} = a + b + cin;
	end
        */ 

	/*
	wire sum_0;
	wire carry_0;
	wire carry_1;
	
	Half_Adder fa1(
	.a(a),
	.b(b),
	.sum(sum_0),
	.carry(carry_0));

	Half_Adder fa2(
        .a(sum_0),
        .b(cin),
        .sum(sum),
        .carry(carry_1));

	or(carry, carry_0, carry_1);
	*/


endmodule
