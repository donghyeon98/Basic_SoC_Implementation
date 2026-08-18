`timescale 1ns / 1ps

module Half_Subtractor(
	a		,
	b		,
	diff		,
	borrow	
);
	
	input a		;
	input b		;
	output diff	;
	output borrow	;

	reg diff;
	reg borrow;	

	always@(*) begin
		case({a,b})
			2'b00: begin diff = 1'b0; borrow = 1'b0; end
			2'b01: begin diff = 1'b1; borrow = 1'b1; end
			2'b11: begin diff = 1'b0; borrow = 1'b0; end
			2'b10: begin diff = 1'b1; borrow = 1'b0; end
		endcase
	end

	/*
 	always@(*) begin
		{borrow,diff} = a - b;
	end
 	*/ 

	/*
	wire not_a;
	not(not_a, a);
	xor(diff, a, b);
	and(borrow, not_a, b);
	*/

endmodule
