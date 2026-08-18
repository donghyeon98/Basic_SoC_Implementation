`timescale 1ns / 1ps 

module Half_Adder(
	// port list
	a,
	b,
	sum,
	carry
);

	// port declaration
	input a		;
	input b		;	
	output sum	;
	output carry	;

	// modeling
	reg sum		;
	reg carry	;

	always@(*) begin
		case({a,b}) 
			2'b00 : begin sum = 1'b0; carry = 1'b0; end
			2'b01 : begin sum = 1'b1; carry = 1'b0; end
			2'b11 : begin sum = 1'b0; carry = 1'b1; end
			2'b10 : begin sum = 1'b1; carry = 1'b0; end
		endcase
	end	
	/*
 	xor(sum, a, b);
	and(carry, a, b);
	*/
	
	/*
        always@(*) begin
		{carry,sum} = a + b;
	end
        */

endmodule
