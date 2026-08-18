`timescale 1ns / 1ps

module tb_BARREL_SHIFTER;
	parameter WIDTH = 8	;

	reg [WIDTH-1:0] data_in			;
	reg [$clog2(WIDTH)-1:0] shift_amt	;
	wire [WIDTH-1:0] data_out		;

	BARREL_SHIFTER #(.WIDTH(WIDTH)) dut(
	.data_in(data_in),
	.shift_amt(shift_amt),
	.data_out(data_out)
	);

	initial begin
		data_in = 8'b00000011; shift_amt = 3'b000; #10;	
		shift_amt = 3'b001; #10;
		shift_amt = 3'b010; #10;
		shift_amt = 3'b000; #10;
		shift_amt = 3'b001; #10;
                shift_amt = 3'b010; #10;
		$finish;
	end

endmodule
