`timescale 1ns / 1ps

module tb_uart_tx;
	localparam FPGA_CLK   = 1600   ;
	localparam BAUD_RATE  = 100    ;
	localparam DATA_WIDTH = 8      ;
	localparam DEPTH      = 16     ;
	localparam OS_DIV     = FPGA_CLK / (BAUD_RATE * 16) ;
	localparam BIT_PERIOD = OS_DIV * 16                 ;

	reg clk;
	reg rst_n;
	wire os_tick;
	wire baud_tick;
	reg [DATA_WIDTH-1:0] tx_data;
	reg tx_valid;
	wire tx_ready;
	wire tx_full;
	wire tx_empty;
	wire tx;

	integer i;

	baud_rate_gen #(
                .FPGA_CLK  (FPGA_CLK),
                .BAUD_RATE (BAUD_RATE)
        ) u_baud_gen (
                .clk       (clk),
                .rst_n     (rst_n),
                .os_tick   (os_tick),
                .baud_tick (baud_tick));

	uart_tx #(
                .DATA_WIDTH (DATA_WIDTH),
                .DEPTH      (DEPTH)
        ) u_dut (
                .clk       (clk),
                .rst_n     (rst_n),
                .baud_tick (baud_tick),
                .tx_data   (tx_data),
                .tx_valid  (tx_valid),
                .tx_ready  (tx_ready),
                .tx_full   (tx_full),
                .tx_empty  (tx_empty),
                .tx        (tx));	
		
	initial begin
                clk = 1'b0;
                forever #5 clk = ~clk;
        end

	initial begin
		rst_n    = 0;
                tx_data  = 0;
                tx_valid = 1'b0;
		repeat (5) @(posedge clk);
                rst_n = 1'b1;
                repeat (5) @(posedge clk);

		// case1 single data		
		/*while (!tx_ready) @(posedge clk);
                tx_data  <= 8'b0000_1111;
                tx_valid <= 1'b1;
                @(posedge clk);
                tx_valid <= 1'b0;

		repeat (11 * BIT_PERIOD + 2 * BIT_PERIOD) @(posedge clk);
		
		// case2 multi data
		for (i = 0; i < 3; i = i + 1) begin
                        while (!tx_ready) @(posedge clk);
                        case (i)
                                0       : tx_data <= 8'b0011_0011;
                                1       : tx_data <= 8'b0000_1111;
                                default : tx_data <= 8'b1010_1010;
                        endcase
			tx_valid <= 1'b1;
                        @(posedge clk);
                        tx_valid <= 1'b0;
                end
		
		repeat (3 * 11 * BIT_PERIOD + 2 * BIT_PERIOD) @(posedge clk);
		*/
		// case3 parity detect
		while (!tx_ready) @(posedge clk);
                tx_data  <= 8'b0000_0111;
                tx_valid <= 1'b1;
                @(posedge clk);
                tx_valid <= 1'b0;

		repeat (11 * BIT_PERIOD + 2 * BIT_PERIOD) @(posedge clk);
 		
                $finish;

	end
	
/*	initial begin
                #(BIT_PERIOD * 10 * 11 * 30);
                $finish;
        end
*/
endmodule
