`timescale 1ns / 1ps

module Hamming_Code_Encoder(
	clk					,
	rst_n					,
	data_in					,
	data_valid				,
	code_out				,
	code_valid		
);
	input clk				;
	input rst_n				;
	input [7:0] data_in			;
	input data_valid			;
	output [12:0] code_out			;
	output code_valid			;
	
	reg [12:0] code_out			;
	reg code_valid				;	

	// data bit mapping (d1~d8)
	wire d1, d2, d3, d4, d5, d6, d7, d8	;

	assign d1 = data_in[0];
        assign d2 = data_in[1];
        assign d3 = data_in[2];
        assign d4 = data_in[3];
        assign d5 = data_in[4];
        assign d6 = data_in[5];
        assign d7 = data_in[6];
        assign d8 = data_in[7];

	// Hamming parity bits (even parity)
	wire p1, p2, p3, p4			;
	assign p1 = d1 ^ d2 ^ d4 ^ d5 ^ d7	; 
	assign p2 = d1 ^ d3 ^ d4 ^ d6 ^ d7	;
	assign p4 = d2 ^ d3 ^ d4 ^ d8		; 
	assign p8 = d5 ^ d6 ^ d7 ^ d8		; 

	// overall parity (SECDED, covers pos1~12)
	wire p0; // Overall Parity BitI
	assign p0 = p1 ^ p2 ^ d1 ^ p4 ^ d2 ^ d3 ^ d4 ^ p8 ^ d5 ^ d6 ^ d7 ^ d8;

	wire [12:0] code_comb;
	assign code_comb = {d8, d7, d6, d5, p8, d4, d3, d2, p4, d1, p2, p1, p0};

	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			code_out <= 13'b0;
			code_valid <= 1'b0;
		end
		else if(data_valid) begin
			code_out <= code_comb	;
			code_valid <= 1'b1	;
		end
		else code_valid <= 1'b0		;
	end

endmodule
