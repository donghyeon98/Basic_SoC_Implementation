`timescale 1ns / 1ps 

module Full_Subtractor(
	a		,
	b		,
	cin		,
	diff		,
	borrow		,
);

	input a		;
	input b		;
	input cin	;
	output diff	;
	output borrow	;

	reg diff	;
	reg borrow	;

	always@(*) begin
		case({a,b,cin})
			3'b000 : begin diff = 1'b0; borrow = 1'b0; end
			3'b001 : begin diff = 1'b1; borrow = 1'b1; end
			3'b011 : begin diff = 1'b0; borrow = 1'b1; end
                        3'b010 : begin diff = 1'b1; borrow = 1'b1; end
			3'b110 : begin diff = 1'b0; borrow = 1'b0; end
                        3'b111 : begin diff = 1'b1; borrow = 1'b1; end
                        3'b101 : begin diff = 1'b0; borrow = 1'b0; end
                        3'b100 : begin diff = 1'b1; borrow = 1'b0; end
		endcase
	end

	/*
	always@(*) begin
		{borrow,diff} = a - b - cin;
	end
	*/

	/*
	wire diff_0;
	wire borrow_0;
	wire borrow_1;

	Half_Subtractor h0(
	.a(a),
	.b(b),
	.diff(diff_0),
	.borrow(borrow_0));

	Half_Subtractor h0(
        .a(diff_0),
        .b(cin),
        .diff(diff),
        .borrow(borrow_1));

	or(borrow, borrow_0, borrow_1);
	*/


endmodule
