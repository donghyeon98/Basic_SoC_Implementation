`timescale 1ns / 1ps

module baud_rate_gen # (
parameter FPGA_CLK = 10_000_000, 
parameter BAUD_RATE = 115200
)(
	clk,
	rst_n,
	os_tick,
	baud_tick
);

	input clk								;
	input rst_n								;
	output os_tick								;
	output baud_tick							;

	reg os_tick								;  // rx
	reg baud_tick 								;  // tx

	localparam OS_DIV = (FPGA_CLK / (BAUD_RATE * 16)) 			;	 
	reg [($clog2(OS_DIV))-1:0] os_tick_cnt					;
	reg [3:0] baud_tick_cnt							;

	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			os_tick       <= 0					;
			baud_tick     <= 0					;
			os_tick_cnt   <= 0					;
			baud_tick_cnt <= 0					;
		end
		else begin
			os_tick   <= 0						;
			baud_tick <= 0						;
			if(os_tick_cnt == OS_DIV - 1) begin
				os_tick_cnt <= 0				;
				os_tick <= 1'b1					;
				if(baud_tick_cnt == 4'd15) begin
					baud_tick_cnt <= 0			;
					baud_tick <= 1'b1			;
				end
				else baud_tick_cnt <= baud_tick_cnt + 1'b1 	;
			end
			else os_tick_cnt <= os_tick_cnt + 1'b1			;
		end	
	end

endmodule
