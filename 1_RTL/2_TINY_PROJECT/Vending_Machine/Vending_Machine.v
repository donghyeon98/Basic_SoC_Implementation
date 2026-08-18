`timescale 1ns / 1ps 

module VendingMachine(
	clk				,
	rst_n				,
	coin_100			,
	coin_500			,
	bill_1000			,
	bill_5000			,
	bill_10000			,
	select_1			,
	select_2			,
	select_3			,
	select_4			,
	cancel				,
	product_1			,
	product_2			,
	product_3			,
	product_4			,
	change 				,	
	change_value		
);

	input clk			;
	input rst_n			;
	input coin_100			;
	input coin_500			;
	input bill_1000			;
	input bill_5000			;
	input bill_10000		;
	input select_1			;
	input select_2			;
	input select_3			;
	input select_4			;
	input cancel			;
	output product_1		;
	output product_2		;
	output product_3		;
	output product_4		;
	output change 			;
	output [14:0] change_value	;

	localparam IDLE   = 3'b000	;
	localparam INPUT  = 3'b001	;
	localparam SELECT = 3'b011	;
	localparam CHECK  = 3'b010	;
	localparam VEND   = 3'b110	; 
	localparam CHANGE = 3'b111	;
	localparam CANCEL = 3'b101	;
	
	localparam [14:0] PRICE_1 = 15'd700;
	localparam [14:0] PRICE_2 = 15'd1400;
	localparam [14:0] PRICE_3 = 15'd2000;
        localparam [14:0] PRICE_4 = 15'd2200;

	reg product_1			;
	reg product_2			;
	reg product_3			;
	reg product_4			;
	reg change 			;
	reg [14:0] change_value		;

	reg [14:0] amount		;
	reg [2:0] sel_product		;
	reg [14:0] sel_price		;

	reg [2:0] state			;
	reg [2:0] next_state		;

	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) state <= IDLE	;
		else 	   state <= next_state	;
	end

	always@(posedge clk or negedge rst_n) begin
		next_state = 3'bx; product_1 = 1'b0; product_2 = 1'b0;
		prodcut_3 = 1'b0; prodcut_4 = 1'b0; change = 1'b0;
		change_value = 15'b0;
	
		case(state)
			IDLE : next_state = INPUT;
			INPUT :
			SELECT :
			CHECK :
			VEND :
			CHANGE :
			CANCEL :
		endcase
	end



endmodule 
