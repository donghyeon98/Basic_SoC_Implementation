`timescale 1ns / 1ps

module FSM1(
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
	output ds	;

	localparam IDLE	= 2'b00;
	localparam READ = 2'b01;
	localparam DLY  = 2'b11;
	localparam DONE = 2'b10;

	// internal register to store current state
	reg [1:0]      state;
	reg [1:0] next_state;

	// 1. current state register
	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) state <= IDLE;
		else state <= next_state;
	end
	// 2. next state register
	always@(posedge clk or negedge rst_n) begin
		next_state = 2'bx;
		case(state)
			IDLE: if(go)  next_state = READ;
			      else    next_state = IDLE;
			READ:         next_state = DLY;
			DLY:  if(!ws) next_state = DONE;
			      else    next_state = READ;
			DONE:         next_state = IDLE;
		endcase
	end	

	// 3. output logic(data flow modeling) : Moore Machine
	assign rd = (state == READ) || (state == DLY);
	assign ds = (state == DONE);

endmodule
