`timescale 1ns / 1ps 

module tb_interrupt_controller;
	// stimulus signal
	reg [7:0] 	i_int		;
	reg 		i_int_ack	;
	/// monitor signal
	wire [2:0] 	o_int_id	;
	wire 		o_int_req	;
	
	// dut instantiation
	interrupt_controller dut(
	.i_int		(i_int		),
	.i_int_ack	(i_int_ack	),
	.o_int_id	(o_int_id	),
	.o_int_req	(o_int_req	)
);
	
	// dunpfile gen
	initial begin
		$dumpfile("./interrupt_controller.vcd")	;
		$dumpvars(0, tb_interrupt_controller)	;
	end
	
	// apply stimulus
	initial begin
		// monitoring
		$monitor("Time=%0t | i_int=%b | i_int_ack=%b | o_int_id=%b | o_int_req=%b",
			$time, i_int, i_int_ack, o_int_id, o_int_req);
	
		// init		
		i_int = 8'b0000_0000;
		i_int_ack = 1'b0;
		
		// apply stimulus
		#10 i_int = 8'b1000_1111;
		#10 i_int = 8'b0010_1011;
		#10 i_int = 8'b0000_0110;
		#10 i_int_ack = 1'b1;
		#10 i_int_ack = 1'b0;
		
		#10 i_int = 8'b0110_0101;
		#10 i_int_ack = 1'b1;
		#10 i_int_ack = 1'b0;
		
		#10 i_int = 8'b0000_0000;

		#20 $finish;

	end

endmodule
