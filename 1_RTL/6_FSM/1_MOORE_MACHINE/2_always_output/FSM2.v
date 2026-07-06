`timescale 1ns / 1ps

module FSM2(
	// port list
	clk	,
	rst_n	,
	go	,
	ws	,
	rd	,
	ds
);

	// port declaration
	input clk	;
	input rst_n	;
	input go	;
	input ws	;
	output rd	;
	output ds 	;

	// parameters for each state
	localparam IDLE = 2'b00;
	localparam READ = 2'b01;
	localparam DLY  = 2'b11;
	localparam DONE = 2'b10;
	
	// internal register to store current state
	reg [1:0] state;
	reg [1:0] next_state;

	// 1. current state register
	reg rd;
	reg ds;
	always@(posedge clk or negedge rst_n)begin
		if(!rst_n) state <= IDLE;
		else       state <= next_state;
	end

	// 2.next state logic + output logic(behavioral modeling)
	always@(posedge clk or negedge rst_n) begin
		next_state = 2'bx;
		rd	   = 1'b0;
		ds	   = 1'b0;
		case(state) 
			IDLE : if(go) next_state = READ;
			       else   next_state = IDLE;
			READ : begin
				rd = 1'b1;
				next_state = DLY;
			       end
			DLY  : begin
				rd =1'b1;
				if(!ws) next_state = DONE;
				else	next_state = READ;
		               end
			DONE : begin
				ds = 1'b1;
				next_state = IDLE;
			       end
		endcase
	end

endmodule
