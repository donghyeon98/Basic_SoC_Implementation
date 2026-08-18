`timescale 1ns / 1ps

module Hamming_Code_Decoder(
	clk				,
	rst_n				,
	code_in				,
	code_valid			,
	data_out			,
	data_valid			,
	error_detect			,
	error_uncorr			,
	error_pos		
);

	input clk			;
	input rst_n			;
	input [12:0] code_in		;
	input code_valid		;
	output [7:0] data_out		;
	output data_valid		;
	output error_detect		;
	output error_uncorr		;
	output [3:0] error_pos		;

	reg [7:0] data_out		;
	reg data_valid			;
	reg error_detect		;
	reg error_uncorr		;
	reg [3:0] error_pos		;

	wire s1, s2, s4, s8		;
	assign s1 = code_in[1] ^ code_in[3] ^ code_in[5] ^ code_in[7]  ^ code_in[9]  ^ code_in[11];
	assign s2 = code_in[2] ^ code_in[3] ^ code_in[6] ^ code_in[7]  ^ code_in[10] ^ code_in[11];
	assign s4 = code_in[4] ^ code_in[5] ^ code_in[6] ^ code_in[7]  ^ code_in[12];
	assign s8 = code_in[8] ^ code_in[9] ^ code_in[10]^ code_in[11] ^ code_in[12];

	wire [3:0] syndrome;
        assign syndrome = {s8, s4, s2, s1};

	wire overall_parity;
        assign overall_parity = ^code_in;

	wire single_err_p0;
        wire single_err_pos;
        wire double_err;
	
	assign single_err_p0  = (syndrome == 4'd0) && overall_parity;
        assign single_err_pos = (syndrome != 4'd0) && overall_parity;
        assign double_err     = (syndrome != 4'd0) && !overall_parity;

	reg [12:0] corrected_code;

        always @(*) begin
                corrected_code = code_in;
                if (single_err_p0)
                        corrected_code[0]        = ~code_in[0];
                else if (single_err_pos)
                        corrected_code[syndrome] = ~code_in[syndrome];
        end

	wire [7:0] data_comb;
        assign data_comb = {corrected_code[12], corrected_code[11], corrected_code[10], corrected_code[9],
                             corrected_code[7],  corrected_code[6],  corrected_code[5],  corrected_code[3]};

        wire [3:0] error_pos_comb;
        assign error_pos_comb = single_err_p0 ? 4'd0 :
                                 single_err_pos ? syndrome : 4'd0;

	always @(posedge clk or negedge rst_n) begin
                if (!rst_n) begin
                        data_out     <= 8'b0;
                        data_valid   <= 1'b0;
                        error_detect <= 1'b0;
                        error_uncorr <= 1'b0;
                        error_pos    <= 4'b0;
                end
                else if (code_valid) begin
                        data_out     <= data_comb;
                        data_valid   <= 1'b1;
                        error_detect <= single_err_p0 | single_err_pos | double_err;
                        error_uncorr <= double_err;
                        error_pos    <= error_pos_comb;
                end
                else begin
                        data_valid   <= 1'b0;
                        error_detect <= 1'b0;
                        error_uncorr <= 1'b0;
                end
        end	

endmodule
