`timescale 1ns / 1ps

module mux(
	// port list
	i_tx0			,
	i_rx0			,
	i_pwm1			,
	i_other_signal		,
	i_select		,
	o_data_out
);
	
	// port delcaration
	input i_tx0				;
	input i_rx0				;
	input i_pwm1				;
	input i_other_signal			;
	input [1:0] i_select			;	
	output o_data_out			;
	
	// modeling
	reg o_data_out;	
	always@(*) begin
		case(i_select)
			0 : o_data_out = i_tx0		;
			1 : o_data_out = i_rx0		;
			2 : o_data_out = i_pwm1		;
			3 : o_data_out = i_other_signal	;	
			default: o_data_out = 1'bz	;
		endcase
	end

endmodule
