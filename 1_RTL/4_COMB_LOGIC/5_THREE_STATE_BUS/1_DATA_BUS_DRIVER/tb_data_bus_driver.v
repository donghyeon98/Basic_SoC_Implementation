`timescale 1ns / 1ps

module tb_data_bus_driver;
	
	// stimulus signal
	reg [7:0] i_data_a;
	reg [7:0] i_data_b;
	reg i_en_a;
	reg i_en_b;
	// monitor signal
	wire [7:0] o_bus_data;

	// dut instantiation
	data_bus_driver dut(
	.i_data_a(i_data_a),
	.i_data_b(i_data_b),
	.i_en_a(i_en_a),
	.i_en_b(i_en_b),
	.o_bus_data(o_bus_data));
	
	// dumpfile gen
	initial begin
		$dumpfile("./data_bus_driver.vcd");
		$dumpvars(0, tb_data_bus_driver);
	end

	// test  scenario
	initial begin
		// system task for monitoring
		$monitor("TIME=%0t |en_A=%b | data_A=%b | en_B=%b | data_B=%b | bus_data=%b", $time, i_en_a, i_data_a, i_en_b, i_data_b, o_bus_data);
		// apply stimuls
		i_en_a = 1'b0; i_en_b = 1'b0; i_data_a = 8'd3; i_data_b = 8'd5; #10;
		i_en_a = 1'b1; i_en_b = 1'b0; i_data_a = 8'd3; i_data_b = 8'd5; #10;
		i_en_a = 1'b0; i_en_b = 1'b1; i_data_a = 8'd3; i_data_b = 8'd5; #10;
		i_en_a = 1'b1; i_en_b = 1'b1; i_data_a = 8'd3; i_data_b = 8'd5; #10;
		$finish;
	end

endmodule
