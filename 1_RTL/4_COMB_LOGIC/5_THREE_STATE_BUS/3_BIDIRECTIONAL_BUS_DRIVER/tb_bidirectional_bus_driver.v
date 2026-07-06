`timescale 1ns / 1ps

module tb_bidirectional_bus_driver;

	// stimulus signal
	reg [31:0] i_data_to_bus;
	reg i_send;
	reg i_rcv;
	// monitor signal
	wire [31:0] io_bus_data;
	wire [31:0] o_data_from_bus;

	// dut instantiation
	bidirectional_bus_driver dut(
	.i_data_to_bus(i_data_to_bus),
	.i_send(i_send),
	.i_rcv(i_rcv),
	.io_bus_data(io_bus_data),
	.o_data_from_bus(o_data_from_bus));
	
	// internal register
	reg [31:0] r_bus_drive_data;
	assign io_bus_data = (i_rcv) ? r_bus_drive_data : 32'dz;
	
	// dumpfile gen
	initial begin
		$dumpfile("./bidirectional_bus_driver.vcd");
		$dumpvars(0,tb_bidirectional_bus_driver);
	end

	// apply stimulus
	initial begin
		$monitor("Time=%t | I_DATA_TO_BUS=%b | I_SEND=%b | I_RCV=%b | IO_BUS_DATA=%b | O_DATA_FROM_BUS=%b",
			$time, i_data_to_bus, i_send, i_rcv, io_bus_data, o_data_from_bus);

		i_data_to_bus = 32'd0; i_send = 1'b0; i_rcv = 1'b0; r_bus_drive_data = 32'd0; #10;
		i_data_to_bus = 32'd10; i_send = 1'b1; i_rcv = 1'b0; #10;
	        i_send = 1'b0; i_rcv = 1'b1; r_bus_drive_data = 32'd34; #10;
	        i_send = 1'b0; i_rcv = 1'b0; #10;
		$finish;
	end

endmodule
