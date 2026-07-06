`timescale 1ns / 1ps

module tb_multiplexed_bus_driver;
	// stimulus signal
	reg [31:0] i_data_a;
	reg [31:0] i_data_b;
	reg i_en_a;
	reg i_en_b;
	// monitor signal
	wire [31:0] o_bus_data;

	// dut instantiation
	multiplexed_bus_driver dut(
	.i_data_a(i_data_a),
	.i_data_b(i_data_b),
	.i_en_a(i_en_a),
	.i_en_b(i_en_b),
	.o_bus_data(o_bus_data));
	
	//dumfile gen
	initial begin
		$dumpfile("./multiplexed_bus_driver.vcd");
		$dumpvars(0, tb_multiplexed_bus_driver);
	end
	
	// scenario
	initial begin
		$monitor("Time=%0t | I_DATA_A=%b | I_DATA_b=%b | I_EN_A=%b | I_EN_B=%b | O_BUS_DATA=%b",
			$time, i_data_a, i_data_b, i_en_a, i_en_b, o_bus_data);
		
		// apply stimulus
		i_en_a = 1'b0; i_en_b = 1'b0; i_data_a = 8'd3; i_data_b = 8'd5; #10;
                i_en_a = 1'b1; i_en_b = 1'b0; i_data_a = 8'd3; i_data_b = 8'd5; #10;
                i_en_a = 1'b0; i_en_b = 1'b1; i_data_a = 8'd3; i_data_b = 8'd5; #10;
                i_en_a = 1'b1; i_en_b = 1'b1; i_data_a = 8'd3; i_data_b = 8'd5; #10;
                $finish;
	end

endmodule 
