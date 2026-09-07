`timescale 1ns / 1ps

module tb_uart_top;
	parameter FPGA_CLK = 10_000_000;
	parameter BAUD_RATE = 115200;
	parameter DATA_WIDTH = 8;
	parameter DEPTH = 16;

        reg clk                                       ;
        reg rst_n                                     ;
        reg [DATA_WIDTH-1:0] tx_data                  ;
        reg tx_valid                                  ;
        reg rx_ready                                  ;
        wire rx_valid                                 ;
        wire [DATA_WIDTH-1:0] rx_data                 ;
        wire rx_full                                  ;
        wire rx_empty                                 ;
        wire frame_err                                ;
        wire parity_err                               ;
        wire overrun_err                              ;
        wire tx_ready                                 ;
        wire tx_full                                  ;
        wire tx_empty                                 ;
        wire tx_line                                  ;


	uart_top #(.FPGA_CLK   = 10_000_000	      ,
	           .BAUD_RATE  = 115200		      ,
		   .DATA_WIDTH = 8		      ,
	           .DEPTH      = 16) dut	      (	
         .clk(clk)                                    ,
         .rst_n(rst_n)                                ,
         .tx_data(tx_data)                            ,
         .tx_valid(tx_valid)                          ,
         .rx(tx_line)                                 ,
         .rx_ready(rx_ready)                          ,
         .rx_valid(rx_valid)                          ,
         .rx_data(rx_data)                            ,
         .rx_full(rx_full)                            ,
         .rx_empty(rx_empty)                          ,
         .frame_err(frame_err)                        ,
         .parity_err(parity_err)                      ,
         .overrun_err(overrun_err)                    ,
         .tx_ready(tx_ready)                          ,
         .tx_full(tx_full)                            ,
         .tx_empty(tx_empty)                          ,
         .tx(tx_line))				      ;

	initial begin
		clk = 0				      ;
		forever #5 clk = ~clk		      ;		
	end

	initial begin

	end

endmodule


  






















endmodule
