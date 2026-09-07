`timescale 1ns / 1ps 

module uart_top #(
parameter FPGA_CLK = 100_000_000,
parameter BAUD_RATE = 115200,
parameter DATA_WIDTH = 8,
parameter DEPTH = 16)
(
	clk						,
	rst_n						,
	tx_data						,
	tx_valid					,
	rx						,
	rx_ready					,
	rx_valid					,
	rx_data						,
	rx_full						,
	rx_empty					,
	frame_err					,
	parity_err					,
	overrun_err					,
	tx_ready					,
	tx_full						,
	tx_empty					,
	tx						
)							;

	input clk					;
	input rst_n					;
	input [DATA_WIDTH-1:0] tx_data                  ;
        input tx_valid                                  ;
        input rx                                        ;
        input rx_ready                                  ;	
        output rx_valid                                 ;
        output [DATA_WIDTH-1:0] rx_data                 ;
        output rx_full                                  ;
        output rx_empty                                 ;
        output frame_err                                ;
        output parity_err                               ;
        output overrun_err                              ;
        output tx_ready                                 ;
        output tx_full                                  ;
        output tx_empty                                 ;
        output tx					;

	wire os_tick					;
	wire baud_tick					;

	baud_rate_gen #(.FPGA_CLK(FPGA_CLK), .BAUD_RATE(BAUD_RATE)) baud(     // simulation FPGA 640 BAUD 10
	.clk(clk)					,
        .rst_n(rst_n)					,
        .os_tick(os_tick)				,
        .baud_tick(baud_tick))				;

	uart_tx #(.DATA_WIDTH(DATA_WIDTH), .DEPTH(DEPTH)) u_tx(
	.clk(clk)					,
	.rst_n(rst_n)					,
	.baud_tick(baud_tick)				,
	.tx_data(tx_data)				,
	.tx_valid(tx_valid)                             ,
        .tx_ready(tx_ready)                             ,
        .tx_full(tx_full)                               ,
        .tx_empty(tx_empty)                             ,
        .tx(tx))					;

	uart_rx #(.DATA_WIDTH(DATA_WIDTH), .DEPTH(DEPTH)) u_rx(
	.clk(clk)                                	,
        .rst_n(rst_n)                            	,
        .os_tick(os_tick)                        	,
        .rx(rx)                                      	,
        .rx_ready(rx_ready)                             ,
        .rx_valid(rx_valid)                             ,
        .rx_data(rx_data)                               ,
        .rx_full(rx_full)                               ,
        .rx_empty(rx_empty)                             ,
        .frame_err(frame_err)                           ,
        .parity_err(parity_err)                         ,
        .overrun_err(overrun_err))			;

endmodule
