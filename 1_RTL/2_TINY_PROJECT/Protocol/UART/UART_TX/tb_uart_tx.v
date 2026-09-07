`timescale 1ns / 1ps

module tb_uart_tx;
	parameter DATA_WIDTH = 8                      ;
	parameter DEPTH      = 16		      ;
	parameter BAUD_DIV   = 20		      ;
	reg clk                                       ;
        reg rst_n                                     ;
        reg baud_tick                                 ;
        reg [DATA_WIDTH-1:0] tx_data                  ;
        reg tx_valid                                  ;
        wire tx_ready                                 ;
        wire tx_full                                  ;
        wire tx_empty                                 ;
        wire tx					      ;
	
	integer errors     = 0			      ;
    	integer baud_cnt			      ;
	integer i				      ;
	integer bit_i				      ;
	reg [DATA_WIDTH-1:0] rx_data		      ;
	reg rx_parity				      ;
	reg rx_stop				      ;


	uart_tx #(.DATA_WIDTH(DATA_WIDTH), .DEPTH(DEPTH)) dut ( 
        .clk(clk)                                     ,
        .rst_n(rst_n)                                 ,
        .baud_tick(baud_tick)                         ,
        .tx_data(tx_data)                             ,
        .tx_valid(tx_valid)                           ,
        .tx_ready(tx_ready)                           ,
        .tx_full(tx_full)                             ,
        .tx_empty(tx_empty)                           ,
        .tx(tx))				      ;

	initial clk = 1'b0			      ;
    	always #5 clk = ~clk	      		      ;
	
    	always @(posedge clk or negedge rst_n) begin
        	if (!rst_n) begin
            		baud_cnt  <= 0;
            		baud_tick <= 1'b0;
        	end 
		else if (baud_cnt == BAUD_DIV-1) begin
            		baud_cnt  <= 0;
            		baud_tick <= 1'b1;
        	end 
		else begin
            		baud_cnt  <= baud_cnt + 1;
            		baud_tick <= 1'b0;
        	end
    	end

	task send_byte;
        	input [DATA_WIDTH-1:0] data;
        	begin
            		@(negedge clk);
            		tx_data = data; tx_valid = 1;
            		@(negedge clk);
            		while (!tx_ready) @(negedge clk);
            		tx_valid = 0;
        	end
    	endtask
    	
	task check_frame;
        	input [DATA_WIDTH-1:0] expected;
        	begin
   			@(negedge tx);                       // start bit
            		@(posedge baud_tick); #1;
            		for (bit_i = 0; bit_i < DATA_WIDTH; bit_i = bit_i + 1) begin
                		rx_data[bit_i] = tx;
                		@(posedge baud_tick); #1;
            		end
            		rx_parity = tx;
            		@(posedge baud_tick); #1;             // move to stop bit
            		rx_stop = tx;

			if (rx_data !== expected) begin
                		errors = errors + 1;
                		$display("[%0t] FAIL DATA exp=%h got=%h", $time, expected, rx_data);
            		end
            		if (rx_parity !== ^expected) begin
                		errors = errors + 1;
                		$display("[%0t] FAIL PARITY exp=%b got=%b", $time, ^expected, rx_parity);
            		end
            		if (rx_stop !== 1'b1) begin
                		errors = errors + 1;
                		$display("[%0t] FAIL STOP bit not 1", $time);
            		end
            		if ((rx_data === expected) && (rx_parity === ^expected) && (rx_stop === 1'b1))
                		$display("[%0t] PASS data=%h", $time, expected);
        		end
    	endtask

	initial begin
        	rst_n = 0; tx_valid = 0; tx_data = 0;
        	repeat (5) @(posedge clk);
        	rst_n = 1;
 
        	for (i = 0; i < 4; i = i + 1) begin
            		send_byte(i * 8'h55);
            		check_frame(i * 8'h55);
        	end
 
        	repeat (BAUD_DIV*12) @(posedge clk);
        	if (errors == 0) $display("ALL TESTS PASSED");
        	else              $display("%0d ERRORS", errors);
        	$finish;
    	end
 
    	initial begin
        	$dumpfile("tb_uart_tx.vcd");
        	$dumpvars(0, tb_uart_tx);
    	end
	
endmodule


     
