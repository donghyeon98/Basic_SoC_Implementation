`timescale 1ns / 1ps

module tb_decoder;

	// stimulus signal	
	reg [3:0] i_bcd;
	// monitor signal
	wire [6:0] o_seg;
	
	// dut instantiation	
	decoder dut(
	.i_bcd(i_bcd),
	.o_seg(o_seg));
	
	// dumpfile gen
	initial begin
		$dumpfile("./decoder.vcd");
		$dumpvars(0, tb_decoder);
	end
		
	// apply stimulus
	integer i;

	initial begin
		// monitoring
		$monitor("Time=%0t | i_bcd Input=$b | Seven Segment Output=%b", $time, i_bcd, o_seg);
		
		// apply stimulus
		for(i=0; i < 10; i = i + 1) begin
			i_bcd = i;
			#10;
		end
		$finish;
	/*	i_bcd = 4'b0000; #10;
		i_bcd = 4'b0001; #10;	
		i_bcd = 4'b0010; #10;
                i_bcd = 4'b0011; #10;
		i_bcd = 4'b0100; #10;
                i_bcd = 4'b0101; #10;
                i_bcd = 4'b0110; #10;
                i_bcd = 4'b0111; #10;
		i_bcd = 4'b1000; #10;
                i_bcd = 4'b1001; #10;
		$finish;   */
	end

endmodule 
