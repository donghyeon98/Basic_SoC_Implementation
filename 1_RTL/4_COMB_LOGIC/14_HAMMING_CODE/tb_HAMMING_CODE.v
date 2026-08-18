`timescale 1ns / 1ps

module tb_HAMMING_CODE;

	reg clk						;
	reg rst_n					;
	reg [7:0] data_in				;
	reg data_valid					;
	reg [1:0] err_mode				;
	reg [3:0] err_bit1, err_bit2			;

	wire [12:0] code_out				;
	wire code_valid					;	
	reg [12:0] code_in_err				;
	
	wire [7:0] data_out				;
	wire data_valid_o, error_detect, error_uncorr	;
	wire [3:0] error_pos				;

	always@(*) begin
		case(err_mode)
			2'd0: code_in_err = code_out	;
			2'd1: code_in_err = code_out ^ (13'd1 << err_bit1);
			2'd2: code_in_err = code_out ^ (13'd1 << err_bit1) ^ (13'd1 << err_bit2);
			default: code_in_err = code_out;
		endcase
	end

	Hamming_Code_Encoder u_enc (
        .clk        (clk),
        .rst_n      (rst_n),
        .data_in    (data_in),
        .data_valid (data_valid),
        .code_out   (code_out),
        .code_valid (code_valid)
    	);

	Hamming_Code_Decoder u_dec (
        .clk         (clk),
        .rst_n       (rst_n),
        .code_in     (code_in_err),
        .code_valid  (code_valid),
        .data_out    (data_out),
        .data_valid  (data_valid_o),
        .error_detect(error_detect),
        .error_uncorr(error_uncorr),
        .error_pos   (error_pos)
    	);

	initial begin
       		 clk = 1'b0;
        	forever #5 clk = ~clk;
    	end

	integer error_cnt;
    	initial error_cnt = 0;

	initial begin
        	rst_n      = 1'b0;
        	data_in    = 8'b0000_0000;
        	data_valid = 1'b0;
        	err_mode   = 2'd0;
        	err_bit1   = 4'd0;
        	err_bit2   = 4'd0;
        	repeat(3) @(negedge clk);
        	rst_n = 1'b1;
		
		// case1 : no error
		@(negedge clk);
        	data_in    = 8'b0101_0101;   
        	data_valid = 1'b1;
        	err_mode   = 2'd0; 
		repeat(2) @(posedge clk); #1;

		// case2 : 1bit error
		data_in    = 8'b0101_0101;
        	data_valid = 1'b1;
        	err_mode   = 2'd1;
		err_bit1   = 4'd7;
		repeat(2) @(posedge clk); #1;

		// case3 : 2bit error
		@(negedge clk);
        	data_in    = 8'b0101_0101;
        	data_valid = 1'b1;
        	err_mode   = 2'd2;
		err_bit1   = 4'd3;
        	err_bit2   = 4'd7;
		repeat(2) @(posedge clk); #1;

		@(negedge clk);
        	data_valid = 1'b0;
        	#20;
		$finish;
	end

endmodule	

