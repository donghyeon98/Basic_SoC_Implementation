`timescale 1ns / 1ps

module tb_comparator;
	parameter N = 32;
	// stimulus
	reg [N-1:0] i_in1;
	reg [N-1:0] i_in2;
	// monitor
	wire o_equal;
	wire o_great;
	wire o_less;
	
	// dut instantiation
	comparator #(.N(32)) dut(
	.i_in1(i_in1),
	.i_in2(i_in2),
	.o_equal(o_equal),
	.o_great(o_great),
	.o_less(o_less));

	// dumpfile gen
	initial begin
		$dumpfile(".comparator.vcd");
		$dumpvars(0, tb_comparator);
	end
	
	// test scenario
	initial begin	
		// system task for monitoring
		$monitor("Time=%0t | INPUT A=%b | INPUT B=%b | OUTPUT EQUAL=%b | OUTPUT GREAT=%b | OUTPUT LESS=%b", $time, i_in1, i_in2, o_equal, o_great, o_less);
		
		// apply stimulus
		i_in1 = 32'd30; i_in2 = 32'd30; #10;
		i_in1 = 32'd100; i_in2 = 32'd50; #10;
		i_in1 = 32'd1394; i_in2 = 32'd1542; #10;
		$finish;
	end

endmodule
