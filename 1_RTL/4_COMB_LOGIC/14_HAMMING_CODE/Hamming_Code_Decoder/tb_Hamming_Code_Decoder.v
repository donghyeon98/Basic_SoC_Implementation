`timescale 1ns / 1ps

module tb_Hamming_Code_Decoder;
	reg clk                       ;
        reg rst_n                     ;
        reg [12:0] code_in            ;
        reg code_valid                ;
        wire [7:0] data_out           ;
        wire data_valid               ;
        wire error_detect             ;
        wire error_uncorr             ;
        wire [3:0] error_pos          ;

	Hamming_Code_Decoder dut(
	.clk(clk)                     ,  
        .rst_n(rst_n)                 ,    
        .code_in(code_in),            ,
        .code_valid(code_valid)       ,         
        .data_out(data_out)           ,
        .data_valid(data_valid)       ,        
        .error_detect(error_detect)   ,          
        .error_uncorr(error_uncorr)   ,          
        .error_pos(error_pos)          
	);

	initial begin
		clk = 1'b0;
		forever #5 clk = ~clk;
	end

	initial begin

	end



endmodule
