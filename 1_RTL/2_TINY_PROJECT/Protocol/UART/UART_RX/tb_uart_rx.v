`timescale 1ns /1ps 

module tb_uart_rx;

	localparam FPGA_CLK   = 1600  		;
	localparam BAUD_RATE  = 100    		;
	localparam DATA_WIDTH = 8      		;
	localparam DEPTH      = 16     		;
	localparam OS_DIV = FPGA_CLK / (BAUD_RATE * 16) ;
	localparam BIT_PERIOD = OS_DIV * 16		;

	reg clk					;
	reg rst_n				;
	reg rx					;
	reg rx_ready				;
	wire rx_valid				;
	wire [DATA_WIDTH-1:0] rx_data		;
	wire rx_full				;
	wire rx_empty				;
	wire frame_err				;
	wire parity_err				;
	wire overrun_err			;
	wire os_tick                      	;
        wire baud_tick                    	;

	reg [DATA_WIDTH-1:0] data		;
	integer i				;
	integer k				;

	baud_rate_gen #(.FPGA_CLK(FPGA_CLK), 
			.BAUD_RATE(BAUD_RATE)) 
	baud_gen (
	.clk(clk)				,
	.rst_n(rst_n)				,
	.os_tick(os_tick)			,
	.baud_tick(baud_tick))			;

	uart_rx #(.DATA_WIDTH(DATA_WIDTH), 
		  .DEPTH(DEPTH)) 
	u_rx(
	.clk(clk)				,
	.rst_n(rst_n)				,
	.os_tick(os_tick)			,
	.rx(rx)					,
	.rx_ready(rx_ready)			,
	.rx_valid(rx_valid)			,
	.rx_data(rx_data)			,
	.rx_full(rx_full)			,
	.rx_empty(rx_empty)			,
	.frame_err(frame_err)			,
	.parity_err(parity_err)			,
	.overrun_err(overrun_err))		;

	initial begin
		clk = 1'b0			;
		forever #5 clk = ~clk		;
	end

	initial begin
		rst_n     = 1'b0		;
		rx        = 1'b1		;
		rx_ready  = 1'b0		;
		repeat (5) @(posedge clk)	;	
		rst_n     = 1'b1		;
		repeat (5) @(posedge clk)	;
		/*
		// case1 single data
		data = 8'b0000_1111		;
		rx <= 1'b0                                              ;
                repeat (BIT_PERIOD) @(posedge clk)                      ;
                for (k = 0; k < DATA_WIDTH; k = k + 1) begin
                        rx <= data[k]                                   ;
                        repeat (BIT_PERIOD) @(posedge clk)              ;
                end
                rx <= ^data                                             ;
                repeat (BIT_PERIOD) @(posedge clk)                      ;
                rx <= 1'b1                                              ;
                repeat (BIT_PERIOD) @(posedge clk)                      ;

		repeat (BIT_PERIOD) @(posedge clk)                      ;
                while (!rx_empty) begin
                        rx_ready <= 1'b1                                ;
                        @(posedge clk)                                  ;
                        rx_ready <= 1'b0                                ;
                        repeat (2) @(posedge clk)                       ;
                end
                repeat (2*BIT_PERIOD) @(posedge clk)                    ;
		
		// case2 multi data
		for (i = 0; i < 3; i = i + 1) begin
                        case (i)
                                0       : data = 8'b0011_0011           ;
                                1       : data = 8'b0000_1111           ;
                                default : data = 8'b1010_1010           ;
                        endcase
 
                        rx <= 1'b0                                      ;
                        repeat (BIT_PERIOD) @(posedge clk)              ;
                        for (k = 0; k < DATA_WIDTH; k = k + 1) begin
                                rx <= data[k]                           ;
                                repeat (BIT_PERIOD) @(posedge clk)      ;
                        end
                        rx <= ^data                                     ;
                        repeat (BIT_PERIOD) @(posedge clk)              ;
                        rx <= 1'b1                                      ;
                        repeat (BIT_PERIOD) @(posedge clk)              ;
                end
	
		repeat (BIT_PERIOD) @(posedge clk)                      ;
                while (!rx_empty) begin
                        rx_ready <= 1'b1                                ;
                        @(posedge clk)                                  ;
                        rx_ready <= 1'b0                                ;
                        repeat (2) @(posedge clk)                       ;
                end
                repeat (2*BIT_PERIOD) @(posedge clk)                    ;
		
		// case3 parity_err detect
		data = 8'b0000_0111                                     ;
 
                rx <= 1'b0                                              ;
                repeat (BIT_PERIOD) @(posedge clk)                      ;
                for (k = 0; k < DATA_WIDTH; k = k + 1) begin
                        rx <= data[k]                                   ;
                        repeat (BIT_PERIOD) @(posedge clk)              ;
                end
                rx <= ^data                                             ;
                repeat (BIT_PERIOD) @(posedge clk)                      ;
                rx <= 1'b1                                              ;
                repeat (BIT_PERIOD) @(posedge clk)                      ;
 
                repeat (BIT_PERIOD) @(posedge clk)                      ;
                while (!rx_empty) begin
                        rx_ready <= 1'b1                                ;
                        @(posedge clk)                                  ;
                        rx_ready <= 1'b0                                ;
                        repeat (2) @(posedge clk)                       ;
                end
                repeat (2*BIT_PERIOD) @(posedge clk)                    ;                

		data = 8'b0000_0111                                     ;
 
                rx <= 1'b0                                              ;
                repeat (BIT_PERIOD) @(posedge clk)                      ;
                for (k = 0; k < DATA_WIDTH; k = k + 1) begin
                        rx <= data[k]                                   ;
                        repeat (BIT_PERIOD) @(posedge clk)              ;
                end
                rx <= ~(^data)                                          ;
                repeat (BIT_PERIOD) @(posedge clk)                      ;
                rx <= 1'b1                                              ;
                repeat (BIT_PERIOD) @(posedge clk)                      ;
 
                repeat (BIT_PERIOD) @(posedge clk)                      ;
                while (!rx_empty) begin
                        rx_ready <= 1'b1                                ;
                        @(posedge clk)                                  ;
                        rx_ready <= 1'b0                                ;
                        repeat (2) @(posedge clk)                       ;
                end
                repeat (2*BIT_PERIOD) @(posedge clk)                    ;
		
		// case4 frame_err detect
		data = 8'b1010_0101                                     ;
 
                rx <= 1'b0                                              ;
                repeat (BIT_PERIOD) @(posedge clk)                      ;
                for (k = 0; k < DATA_WIDTH; k = k + 1) begin
                        rx <= data[k]                                   ;
                        repeat (BIT_PERIOD) @(posedge clk)              ;
                end
                rx <= ^data                                             ;
                repeat (BIT_PERIOD) @(posedge clk)                      ;
                rx <= 1'b0                                              ;
                repeat (BIT_PERIOD) @(posedge clk)                      ;
                rx <= 1'b1                                              ;
 
                repeat (2*BIT_PERIOD) @(posedge clk)                    ;
                while (!rx_empty) begin
                        rx_ready <= 1'b1                                ;
                        @(posedge clk)                                  ;
                        rx_ready <= 1'b0                                ;
                        repeat (2) @(posedge clk)                       ;
                end
                repeat (2*BIT_PERIOD) @(posedge clk)                    ;
		*/
		// case5 overrun_err detect
		for (i = 0; i < DEPTH + 1; i = i + 1) begin
                        data = i[DATA_WIDTH-1:0]                        ;
 
                        rx <= 1'b0                                      ;
                        repeat (BIT_PERIOD) @(posedge clk)              ;
                        for (k = 0; k < DATA_WIDTH; k = k + 1) begin
                                rx <= data[k]                           ;
                                repeat (BIT_PERIOD) @(posedge clk)      ;
                        end
                        rx <= ^data                                     ;
                        repeat (BIT_PERIOD) @(posedge clk)              ;
                        rx <= 1'b1                                      ;
                        repeat (BIT_PERIOD) @(posedge clk)              ;
                end
 
                repeat (BIT_PERIOD) @(posedge clk)                      ;
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
	
