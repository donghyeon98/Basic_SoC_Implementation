`timescale 1ns / 1ps

module FSM3(
	// port list
	clk,
	rst_n,
	go,
	ws,
	rd,
	ds
);
	// port declaration
	input clk;
	input rst_n;
	input go;
	input ws;
	output rd;
	output ds;

	// parameters for each state
	localparam IDLE = 2'b00;
	localparam READ = 2'b01;
	localparam DLY  = 2'b11;
	localparam DONE = 2'b10;
	
	// internal registers to store current state
	reg [1:0] state;
	reg [1:0] next_state;

	// 1. current state register
	reg rd;
	reg ds;
	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) state <= IDLE;
		else 	   state <= next_state;
	end

	// 2. next state logic
	always@(state, go, ws) begin
		next = 2'bx;
		case(state)
			IDLE : if(go)  next_state = READ;
			       else    next_state = IDLE;
			READ :	       next_state = DLY;
			DLY  : if(!ws) next_state = DONE;
			       else    next_state = READ;
			DONE :	       next_state = IDLE;
		endcase
	end

	// 3. output logi(behavioral modeling)
	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			rd <= 1'b0;
			ds <= 1'b0;
		end
		else begin
			case(next_state)
				READ : rd <= 1'b1;
				DLY  : rd <= 1'b1;
				DONE : ds <= 1'b1;
			endcase
		end
	end

endmodule
