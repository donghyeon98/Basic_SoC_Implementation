`timescale 1ns / 1ps

module tb_uart_top;
	parameter FPGA_CLK   = 160;
	parameter BAUD_RATE  = 10;
	parameter DATA_WIDTH = 8;
	parameter DEPTH      = 16;

	localparam OS_DIV     = FPGA_CLK / (BAUD_RATE * 16) ;
        localparam BIT_PERIOD = OS_DIV * 16                 ;

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

	integer i				      ;

	uart_top #(.FPGA_CLK(FPGA_CLK)	      	      ,
	           .BAUD_RATE(BAUD_RATE)	      ,
		   .DATA_WIDTH(DATA_WIDTH)	      ,
	           .DEPTH(DEPTH))      dut	      (	
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
		rst_n    = 1'b0                       ;
                tx_data  = 0                          ;
                tx_valid = 1'b0                       ;
                rx_ready = 1'b0                       ;
                repeat (5) @(posedge clk)             ;
                rst_n    = 1'b1                       ;
                repeat (5) @(posedge clk)             ;
/* 		
		//case1
		while (!tx_ready) 
		@(posedge clk)                        ;
                tx_data  <= 8'b0000_1111              ;
                tx_valid <= 1'b1                      ;
                @(posedge clk)                        ;
                tx_valid <= 1'b0                      ;

		repeat (11 * BIT_PERIOD + 2 * BIT_PERIOD) @(posedge clk)        ;
 
                while (!rx_empty) begin
                        rx_ready <= 1'b1                                ;
                        @(posedge clk)                                  ;
                        rx_ready <= 1'b0                                ;
                        repeat (2) @(posedge clk)                       ;
                end
                repeat (2*BIT_PERIOD) @(posedge clk)                    ;
 		
		//case2
		for (i = 0; i < 3; i = i + 1) begin
                        while (!tx_ready) @(posedge clk)                ;
                        case (i)
                                0       : tx_data <= 8'b0011_0011       ;
                                1       : tx_data <= 8'b0000_1111       ;
                                default : tx_data <= 8'b1010_1010       ;
                        endcase
                        tx_valid <= 1'b1                                ;
                        @(posedge clk)                                  ;
                        tx_valid <= 1'b0                                ;
                end
 
                repeat (3 * 11 * BIT_PERIOD + 2 * BIT_PERIOD) @(posedge clk)    ;

		while (!rx_empty) begin
                        rx_ready <= 1'b1                                ;
                        @(posedge clk)                                  ;
                        rx_ready <= 1'b0                                ;
                        repeat (2) @(posedge clk)                       ;
                end
                repeat (2*BIT_PERIOD) @(posedge clk)                    ;

 		//case3
		while (!tx_ready) @(posedge clk)                        ;
                tx_data  <= 8'b0000_0111                                ;
                tx_valid <= 1'b1                                        ;
                @(posedge clk)                                          ;
                tx_valid <= 1'b0                                        ;
 
                repeat (11 * BIT_PERIOD + 2 * BIT_PERIOD) @(posedge clk)        ;

		while (!rx_empty) begin
                        rx_ready <= 1'b1                                ;
                        @(posedge clk)                                  ;
                        rx_ready <= 1'b0                                ;
                        repeat (2) @(posedge clk)                       ;
                end
                repeat (2*BIT_PERIOD) @(posedge clk)                    ;

		while (!tx_ready) @(posedge clk)                        ;
                tx_data  <= 8'b0000_0111                                ;
                tx_valid <= 1'b1                                        ;
                @(posedge clk)                                          ;
                tx_valid <= 1'b0                                        ;
 
                wait (dut.u_tx.state == 3'b011)                         ;
                force dut.u_tx.tx_parity_bit = 1'b0                        ;
                wait (dut.u_tx.state == 3'b100)                         ;
                release dut.u_tx.tx_parity_bit                             ;
 
                repeat (2 * BIT_PERIOD) @(posedge clk)                  ;

		while (!rx_empty) begin
                        rx_ready <= 1'b1                                ;
                        @(posedge clk)                                  ;
                        rx_ready <= 1'b0                                ;
                        repeat (2) @(posedge clk)                       ;
                end
                repeat (2*BIT_PERIOD) @(posedge clk)                    ;
		
		//case4
		while (!tx_ready) @(posedge clk)                        ;
                tx_data  <= 8'b1010_0101                                ;
                tx_valid <= 1'b1                                        ;
                @(posedge clk)                                          ;
                tx_valid <= 1'b0                                        ;
 
                wait (dut.u_tx.state == 3'b100)                         ;
                force dut.u_tx.tx = 1'b0                                ;
                wait (dut.u_tx.state == 3'b000)                         ;
                release dut.u_tx.tx                                     ;
 
                repeat (2 * BIT_PERIOD) @(posedge clk)                  ;

		while (!rx_empty) begin
                        rx_ready <= 1'b1                                ;
                        @(posedge clk)                                  ;
                        rx_ready <= 1'b0                                ;
                        repeat (2) @(posedge clk)                       ;
                end
                repeat (2*BIT_PERIOD) @(posedge clk)                    ;
 */		
		//case5
		for (i = 0; i < DEPTH + 1; i = i + 1) begin
                        @(posedge clk)                                  ;
                        while (!tx_ready) @(posedge clk)                ;
                        tx_data  <= i[DATA_WIDTH-1:0]                   ;
                        tx_valid <= 1'b1                                ;
                        @(posedge clk)                                  ;
                        tx_valid <= 1'b0                                ;
                end
 
                repeat ((DEPTH + 1) * 11 * BIT_PERIOD + 2 * BIT_PERIOD) @(posedge clk)  ;

		while (!rx_empty) begin
                        rx_ready <= 1'b1                                ;
                        @(posedge clk)                                  ;
                        rx_ready <= 1'b0                                ;
                        repeat (2) @(posedge clk)                       ;
                end
                repeat (2*BIT_PERIOD) @(posedge clk)                    ;
 
                $finish                                                 ;
	end

endmodule

