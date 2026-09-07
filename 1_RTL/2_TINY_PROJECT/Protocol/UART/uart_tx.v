`timescale 1ns / 1ps

module uart_tx #(
parameter DATA_WIDTH = 8				,
parameter DEPTH = 16)
(
	clk						,	
	rst_n						,
	baud_tick					,
	tx_data						,
	tx_valid					,
	tx_ready					,
	tx_full						,
	tx_empty					,
	tx
)							;

	input clk					;
	input rst_n					;
	input baud_tick 				;
	input [DATA_WIDTH-1:0] tx_data  		;
	input tx_valid					;
	output tx_ready					;
	output tx_full					;
	output tx_empty					;
	output tx					;

	reg tx						;
	assign tx_ready = ~tx_full                      ;
	
	reg fifo_rd_en					;
	wire [DATA_WIDTH-1:0] fifo_rd_data		;

	Sync_FIFO #(.DATA_WIDTH(DATA_WIDTH), .DEPTH(DEPTH)) tx_fifo(
	.clk(clk)					,
	.rst_n(rst_n)					,
	.wr_en(tx_valid && tx_ready)			,
	.rd_en(fifo_rd_en)				,
	.wr_data(tx_data)				,
	.rd_data(fifo_rd_data)				,
	.full(tx_full)					,
	.empty(tx_empty))				;

	localparam IDLE   = 3'b000			;  
	localparam START  = 3'b001			;
	localparam DATA   = 3'b010			;
	localparam PARITY = 3'b011			;
	localparam STOP   = 3'b100			;

	reg [2:0]                    state		;
	reg [2:0]                    next_state		;
	reg [$clog2(DATA_WIDTH)-1:0] bit_cnt		;
	reg [DATA_WIDTH-1:0]         tx_data_reg	;
	reg                          tx_parity_bit	;

	// State register (sequential)
	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) state <= IDLE		;
		else       state <= next_state		;

	end

	// Next state logic (combinational)
	always@(*) begin
		next_state = state			;
		fifo_rd_en = 1'b0			;	
		case(state) 
			IDLE    : if(!tx_empty && baud_tick) begin 
			          	fifo_rd_en = 1'b1							; 
					next_state = START							; 
				  end 	
			START   : if(baud_tick)                          	      next_state = DATA		;
			DATA    : if(baud_tick && bit_cnt == DATA_WIDTH-1)            next_state = PARITY	;				      
			PARITY  : if(baud_tick)                          	      next_state = STOP	        ;
			STOP    : if(baud_tick) begin
                                  	if(!tx_empty) begin
						fifo_rd_en = 1'b1						;
						next_state = START						;
					end
					else    next_state = IDLE						;
				  end
			default : 					              next_state = IDLE		;
		endcase 
	end

	// Output logic / datapath (sequential)
	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			tx               <= 1'b1							;
			tx_data_reg      <= 0								;
			bit_cnt          <= 0								;
			tx_parity_bit    <= 0								;
		end
		else begin
			case(state)
				IDLE    : begin 
						tx          <= 1'b1					;	 
						bit_cnt     <= 0					;  	
						tx_data_reg <= 0					;
						tx_parity_bit  <= 0					;
					  end
                        	START   : begin
						tx            <= 1'b0                       		;
						tx_data_reg   <= fifo_rd_data				;
						tx_parity_bit    <= ^fifo_rd_data			;
					  end
                        	DATA    : begin
						tx <= tx_data_reg[bit_cnt]				;
						if(baud_tick) bit_cnt <= bit_cnt +1			;
					  end                       
                        	PARITY  : tx <= tx_parity_bit                     	  		;
                        	STOP    : begin
					  	tx      <= 1'b1                       			;
						bit_cnt <= 0						;
					  end
				default : tx <= 1'b1							;
			endcase
		end
	end

endmodule
