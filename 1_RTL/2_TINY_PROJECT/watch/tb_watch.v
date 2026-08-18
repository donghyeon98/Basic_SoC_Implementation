`timescale 1ns / 1ps 

module tb_watch;
	reg clk;
	reg rst_n;
	wire [3:0] sec_bcd1;
	wire [3:0] sec_bcd10;
	wire [3:0] min_bcd1;
	wire [3:0] min_bcd10;
	wire [3:0] hour_bcd1;
	wire [3:0] hour_bcd10;

	watch #(.fpga_clk(10)) dut(
	.clk(clk),
	.rst_n(rst_n),
	.sec_bcd1(sec_bcd1),
        .sec_bcd10(sec_bcd10),
        .min_bcd1(min_bcd1),
        .min_bcd10(min_bcd10),
        .hour_bcd1(hour_bcd1),
        .hour_bcd10(hour_bcd10));
	
	initial begin
		clk = 1'b0;
		forever #5 clk = ~clk;
	end
	
	initial begin
		rst_n = 1'b0; #10;
		rst_n = 1'b1;
		
		force dut.hour_bcd10  = 2;
		force dut.hour_bcd1   = 3;
		force dut.min_bcd10   = 5;
		force dut.min_bcd1    = 9;
		force dut.sec_bcd10   = 5;
		force dut.sec_bcd1    = 0;
		
		#20;
		
		release dut.hour_bcd10;
                release dut.hour_bcd1;
                release dut.min_bcd10;
                release dut.min_bcd1;
                release dut.sec_bcd10;
                release dut.sec_bcd1;

	 	#3000;

		$finish;
	end


endmodule
