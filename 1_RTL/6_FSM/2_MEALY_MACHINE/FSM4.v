`timescale 1ns / 1ps

module FSM4(
	clk,
	rst_n,
	din_bit,
	dout_bit
);

	input clk;
	input rst_n;
	input din_bit;
	output dout_bit;

	localparam START     = 3'b000;
 	localparam RD0_ONCE  = 3'b001;
	localparam RD1_ONCE  = 3'b011;
        localparam RD0_TWICE = 3'b010;
        localparam RD1_TWICE = 3'b110;

	reg [2:0] state;
	reg [2:0] next_state;
	
	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) state <= START;
		else 	   state <= next_state;
	end
	
	
	always@(state, din_bit) begin
		case(state)
			START     : if(din_bit == 0)      next_state = RD0_ONCE		;
			            else if(din_bit == 1) next_state = RD1_ONCE		;
				    else 		  next_state = START		;
			RD0_ONCE  : if(din_bit == 0)      next_state = RD0_TWICE	;
                                    else if(din_bit == 1) next_state = RD1_ONCE		;
                                    else                  next_state = START		;
			RD0_TWICE : if(din_bit == 0)      next_state = RD0_TWICE	;
                                    else if(din_bit == 1) next_state = RD1_ONCE		;
                                    else                  next_state = START		;
			RD1_ONCE  : if(din_bit == 0)      next_state = RD0_ONCE		;
                                    else if(din_bit == 1) next_state = RD1_TWICE	;
                                    else                  next_state = START		;
			RD1_TWICE : if(din_bit == 0)      next_state = RD0_ONCE		;
                                    else if(din_bit == 1) next_state = RD1_TWICE	;
                                    else                  next_state = START		;
			default   : 		 	  next_state = START		;
		endcase
	end

	assign dout_bit = (((state == RD0_TWICE) && (din_bit == 0) ||
			    (state == RD1_TWICE) && (din_bit == 1))) 	? 1 : 0;

endmodule
