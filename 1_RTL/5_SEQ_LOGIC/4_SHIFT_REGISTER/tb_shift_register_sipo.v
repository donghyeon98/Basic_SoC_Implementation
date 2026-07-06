`timescale 1ns / 1ps

module tb_shift_register_sipo;
	parameter WIDTH = 8;
	reg clk;
	reg rst_n;
	reg i_serial_in;
	reg load;
	wire [WIDTH-1:0] o_parallel_out;

	shift_register_sipo #(.WIDTH(WIDTH)) dut (
	.clk(clk),
	.rst_n(rst_n),
	.i_serial_in(i_serial_in),
	.load(load),
	.o_parallel_out(o_parallel_out));
	
	initial begin
		clk = 0;
		forever #5 clk = ~clk;
	end
	
	initial begin
		rst_n = 1'b0; i_serial_in = 1'b1; load = 1'b0; #10;
		rst_n = 1'b1; #10;
		i_serial_in = 1'b1; #10;
		i_serial_in = 1'b1; #10;
		i_serial_in = 1'b1; #10;
                i_serial_in = 1'b1; #10;
		i_serial_in = 1'b0; #10;
                i_serial_in = 1'b0; #10;
                i_serial_in = 1'b1; #10;
		load = 1'b1; #10;
		load = 1'b0; i_serial_in = 1'b0; #10;
		i_serial_in = 1'b1; #10;
                i_serial_in = 1'b0; #10;
                i_serial_in = 1'b1; #10;
                i_serial_in = 1'b0; #10;
                i_serial_in = 1'b1; #10;
                i_serial_in = 1'b0; #10;
                i_serial_in = 1'b1; #10;
                load = 1'b1; #10; 
		$finish;
	end

endmodule
