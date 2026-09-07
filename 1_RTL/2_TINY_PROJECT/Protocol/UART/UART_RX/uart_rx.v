`timescale 1ns / 1ps 

module uart_rx #(parameter DATA_WIDTH = 8, 
		 parameter DEPTH = 16)
(
	clk					,
	rst_n					,
	os_tick					,
	rx					,
	rx_ready				,
	rx_valid				,
	rx_data					,
	rx_full					,
	rx_empty				,
	frame_err				,
	parity_err				,
	overrun_err	
);

	input clk				;
	input rst_n				;
	input os_tick				;
	input rx				;
	input rx_ready				;
	output rx_valid                         ;
	output [DATA_WIDTH-1:0] rx_data 	;
	output rx_full				;
	output rx_empty				;
	output frame_err			;
	output parity_err			;
	output overrun_err			;
	
	reg frame_err				;
	reg parity_err				;
	reg overrun_err				;
	
	reg fifo_wr_en 				;
	reg [DATA_WIDTH-1:0] fifo_wr_data	;

	assign rx_valid = ~rx_empty		;

	Sync_FIFO #(.DATA_WIDTH(DATA_WIDTH), .DEPTH(DEPTH)) rx_fifo(
	.clk(clk)				,
	.rst_n(rst_n)				,
	.wr_en(fifo_wr_en)			,
	.rd_en(rx_ready && rx_valid)		,
	.wr_data(fifo_wr_data)			,
	.rd_data(rx_data)			,
	.full(rx_full)				,
	.empty(rx_empty))			;

	localparam IDLE   = 3'b000		;
	localparam START  = 3'b001		;
	localparam DATA   = 3'b010		;
	localparam PARITY = 3'b011		;
	localparam STOP   = 3'b100		;

	reg [2:0] state				;
	reg [2:0] next_state			;
	reg [$clog2(DATA_WIDTH)-1:0] bit_cnt	;
	reg [DATA_WIDTH-1:0] rx_data_reg	;
	reg rx_sync0				;
	reg rx_sync1				;
	reg rx_sync2				;
	wire rx_falling_edge			;
	reg [3:0] sampling_cnt			;
	reg vote_7				;
	reg vote_8				;
	wire vote_sample_tick			;
	wire vote_result			;
	reg rx_parity_bit			;
	wire expected_parity			;

	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			rx_sync0 <= 0		;
			rx_sync1 <= 0		;
			rx_sync2 <= 0		;
		end
		else begin
			rx_sync0 <= rx		;
			rx_sync1 <= rx_sync0	;
			rx_sync2 <= rx_sync1	;
		end
	end

	assign rx_falling_edge      = (rx_sync2 && !rx_sync1) 							;
	assign vote_sample_tick	    = os_tick && (sampling_cnt == 4'd9)						;
	assign vote_result          = (vote_7 & vote_8) | (vote_7 & rx_sync2) | (vote_8 & rx_sync2)		;
	assign expected_parity      = ^rx_data_reg								;

	// State register (sequential)
	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) state <= IDLE									;
		else       state <= next_state									;
	end	

	// Next state logic (combinational)
	always@(*) begin
		next_state = state										;
		case(state)
			IDLE    : if(rx_falling_edge) next_state = START					;
			START   : if(vote_sample_tick) next_state = vote_result ? IDLE : DATA			;
			DATA    : if(vote_sample_tick && bit_cnt == DATA_WIDTH-1) next_state = PARITY 		;
			PARITY  : if(vote_sample_tick) next_state = STOP					;
			STOP    : if(vote_sample_tick) next_state = IDLE					;
			default : next_state = IDLE								;
		endcase
	end

	// Output logic / datapath (sequential)
	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			rx_data_reg   <= 0;
			sampling_cnt  <= 0;
			bit_cnt       <= 0;
			fifo_wr_en    <= 0;
			rx_parity_bit <= 0;
			vote_7        <= 0;
			vote_8        <= 0;
			frame_err     <= 0;
			parity_err    <= 0;  
			overrun_err   <= 0;
		end
		else begin
			if(os_tick) sampling_cnt <= sampling_cnt + 1;
			frame_err     <= 0;
                        parity_err    <= 0;
                        overrun_err   <= 0;
			fifo_wr_en    <= 0;
			case(state)
				IDLE    : begin
					   rx_data_reg   <= 0;
                        		   sampling_cnt  <= 0;
					   bit_cnt	 <= 0;
                        	           rx_parity_bit <= 0;
				          end		
				START   : if(os_tick) begin
					  	if(os_cnt == 4'd7) vote_7 <= rx_sync2;
						if(os_cnt == 4'd8) vote_8 <= rx_sync2;
					  end
				DATA    : if(os_tick) begin
					  	if(os_cnt == 4'd7) vote_7 <= rx_sync2;
						if(os_cnt == 4'd8) vote_8 <= rx_sync2;
						if(os_cnt == 4'd9) begin
							rx_data_reg <= {vote_result, rx_data_reg[DATA_WIDTH-1:1]};
							bit_cnt     <= bit_cnt + 1;
						end
					  end
				PARITY  : if(os_tick) begin
					  	if(os_cnt == 4'd7) vote_7        <= rx_sync2;
                                                if(os_cnt == 4'd8) vote_8        <= rx_sync2;
                                                if(os_cnt == 4'd9) rx_parity_bit <= vote_result;
					  end
				STOP    : begin
					  	if (os_tick) begin
							if (sampling_cnt == 4'd7) vote_7 <= rx_sync2		;
							if (sampling_cnt == 4'd8) vote_8 <= rx_sync2		;
						end
						if(vote_sample_tick) begin
							if (vote_result != 1'b1) frame_err <= 1'b1;
							else if (rx_parity_bit != expected_parity) parity_err <= 1'b1;
							else begin
								if (rx_full) overrun_err <= 1'b1;
								else begin
                                					fifo_wr_en   <= 1'b1;
                                					fifo_wr_data <= rx_data_reg;
                            					end
							end
						end
					  end
				default :		;
			endcase
		end
	end	

endmodule
