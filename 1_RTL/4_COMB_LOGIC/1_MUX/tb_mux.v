`timescale 1ns / 1ps

module tb_mux;
	parameter N = 4;
	reg i_tx0;
	reg i_rx0;
	reg i_pwm1;
	reg i_other_signal;
	reg [$clog2(N)-1:0] i_select;
	wire o_data_out;
	
	mux #(.N(4)) dut(
	.i_tx0(i_tx0),
	.i_rx0(i_rx0),
	.i_pwm1(i_pwm1),
	.i_other_signal(i_other_signal),
	.i_select(i_select),
	.o_data_out(o_data_out));
	
	initial begin
		i_select = 2'd0; i_tx0 = 1'b0; i_rx0 = 1'b0; i_pwm1 = 1'b0; i_other_signal = 1'b0; #10;
                i_select = 2'd0; i_tx0 = 1'b1; i_rx0 = 1'b0; i_pwm1 = 1'b0; i_other_signal = 1'b0; #10;
                i_select = 2'd0; i_tx0 = 1'b0; i_rx0 = 1'b1; i_pwm1 = 1'b0; i_other_signal = 1'b0; #10;
                i_select = 2'd0; i_tx0 = 1'b0; i_rx0 = 1'b0; i_pwm1 = 1'b1; i_other_signal = 1'b0; #10;
                i_select = 2'd0; i_tx0 = 1'b0; i_rx0 = 1'b0; i_pwm1 = 1'b0; i_other_signal = 1'b1; #10;

		i_select = 2'd1; i_tx0 = 1'b0; i_rx0 = 1'b0; i_pwm1 = 1'b0; i_other_signal = 1'b0; #10;
                i_select = 2'd1; i_tx0 = 1'b1; i_rx0 = 1'b0; i_pwm1 = 1'b0; i_other_signal = 1'b0; #10;
                i_select = 2'd1; i_tx0 = 1'b0; i_rx0 = 1'b1; i_pwm1 = 1'b0; i_other_signal = 1'b0; #10;
                i_select = 2'd1; i_tx0 = 1'b0; i_rx0 = 1'b0; i_pwm1 = 1'b1; i_other_signal = 1'b0; #10;
                i_select = 2'd1; i_tx0 = 1'b0; i_rx0 = 1'b0; i_pwm1 = 1'b0; i_other_signal = 1'b1; #10;
		
		i_select = 2'd2; i_tx0 = 1'b0; i_rx0 = 1'b0; i_pwm1 = 1'b0; i_other_signal = 1'b0; #10;
                i_select = 2'd2; i_tx0 = 1'b1; i_rx0 = 1'b0; i_pwm1 = 1'b0; i_other_signal = 1'b0; #10;
                i_select = 2'd2; i_tx0 = 1'b0; i_rx0 = 1'b1; i_pwm1 = 1'b0; i_other_signal = 1'b0; #10;
                i_select = 2'd2; i_tx0 = 1'b0; i_rx0 = 1'b0; i_pwm1 = 1'b1; i_other_signal = 1'b0; #10;
                i_select = 2'd2; i_tx0 = 1'b0; i_rx0 = 1'b0; i_pwm1 = 1'b0; i_other_signal = 1'b1; #10;
		
		i_select = 2'd3; i_tx0 = 1'b0; i_rx0 = 1'b0; i_pwm1 = 1'b0; i_other_signal = 1'b0; #10;
                i_select = 2'd3; i_tx0 = 1'b1; i_rx0 = 1'b0; i_pwm1 = 1'b0; i_other_signal = 1'b0; #10;
                i_select = 2'd3; i_tx0 = 1'b0; i_rx0 = 1'b1; i_pwm1 = 1'b0; i_other_signal = 1'b0; #10;
                i_select = 2'd3; i_tx0 = 1'b0; i_rx0 = 1'b0; i_pwm1 = 1'b1; i_other_signal = 1'b0; #10;
                i_select = 2'd3; i_tx0 = 1'b0; i_rx0 = 1'b0; i_pwm1 = 1'b0; i_other_signal = 1'b1; #10;

		$finish;
	end

endmodule
