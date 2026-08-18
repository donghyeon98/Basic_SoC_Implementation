`timescale 1ns / 1ps

module ALU(
	a		,
	b		,
	op		,
	result		,
	cout		,
	zero							
);

	input [3:0] a		;
	input [3:0] b		;
	input [2:0] op		;
	output [3:0] result	;
	output cout		;
	output zero		;

	reg [3:0] result	;
	reg cout		;

	always@(*) begin
		cout = 1'b0;
		case(op)
			3'b000: {cout, result} = a + b	;
			3'b001: {cout, result} = a - b	;
			3'b011: result = a & b		;
			3'b010: result = a | b		;
			3'b110: result = a ^ b		;
			3'b111: result = ~a		;
			3'b101: result = a << 1		;
			3'b100:	result = a >> 1		;
			default: result = 4'b0;
		endcase
	end

	assign zero = (result == 4'b0000);

endmodule
