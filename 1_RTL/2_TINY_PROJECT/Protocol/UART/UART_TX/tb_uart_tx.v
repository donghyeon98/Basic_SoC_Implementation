`timescale 1ns / 1ps

module tb_uart_tx;
	parameter DATA_WIDTH = 8                      ;
	reg clk                                       ;
        reg rst_n                                     ;
        reg baud_tick                                 ;
        reg [DATA_WIDTH-1:0] tx_data                  ;
        reg tx_valid                                  ;
        wire tx_ready                                 ;
        wire tx_full                                  ;
        wire tx_empty                                 ;
        wire tx					      ;

	uart_tx #(.DATA_WIDTH(DATA_WIDTH)) dut ( 
        .clk(clk)                                     ,
        .rst_n(rst_n)                                 ,
        .baud_tick(baud_tick)                         ,
        .tx_data(tx_data)                             ,
        .tx_valid(tx_valid)                           ,
        .tx_ready(tx_ready)                           ,
        .tx_full(tx_full)                             ,
        .tx_empty(tx_empty)                           ,
        .tx(tx))				      ;

	initial begin
		clk = 1'b0;
		forever #5 clk = ~clk;
	end

	initial begin
 		rst_n = 1'b0; baud_tick = 1'b1; tx_valid = 1'b1; tx_data = 8'b0000_1111; #10; 	
		rst_n = 1'b1; #500;
		$finish;
	end


endmodule


     
