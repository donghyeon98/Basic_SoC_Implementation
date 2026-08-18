`timescale 1ns / 1ps

module watch #(parameter fpga_clk = 10_000_000 )(
	clk,
	rst_n,
	sec_bcd1,
	sec_bcd10,
	min_bcd1,
	min_bcd10,
	hour_bcd1,
	hour_bcd10,
);

	input clk;
	input rst_n;
	output [3:0] sec_bcd1;
	output [3:0] sec_bcd10;
	output [3:0] min_bcd1;
	output [3:0] min_bcd10;
	output [3:0] hour_bcd1;
	output [3:0] hour_bcd10;

	reg [3:0] sec_bcd1;
	reg [3:0] sec_bcd10;
	reg [3:0] min_bcd1;
	reg [3:0] min_bcd10;
	reg [3:0] hour_bcd1;
	reg [3:0] hour_bcd10;	
	
	reg [($clog2(fpga_clk))-1:0] cnt;
	
	reg r_sec_tick;
        reg r_min_tick;
        reg r_hour_tick;

	// clock cnt
	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) cnt <= 0;
		else if(cnt-1) begin
			cnt <= 0;
			r_sec_tick <= 1'b1;
		end
		else cnt <= cnt + 1;			
	end
	
	// sec
	always@(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
                        sec_bcd1 <= 0;
			sec_bcd10 <= 0;
			r_min_tick <= 0;
                end	
		else begin
			r_min_tick <=0;
 			if(r_sec_tick) begin
				if(sec_bcd1 == 4'd9) begin
					sec_bcd1 <= 4'd0;
					if(sec_bcd10 == 4'd5) begin	
						sec_bcd10 <=4'd0;
						r_min_tick <= 1'b1;
					end
					else sec_bcd10 <= sec_bcd10 + 1;
				end
				else sec_bcd1 <= sec_bcd1 + 1;
			end
		end
	end

	// min
	always@(posedge clk or negedge rst_n) begin
                if(!rst_n) begin
                        min_bcd1 <= 0;
                        min_bcd10 <= 0;
                        r_hour_tick <= 0;
                end
                else begin
			r_hour_tick <= 0;
                        if(r_min_tick) begin
                                if(min_bcd1 == 4'd9) begin
                                        min_bcd1 <= 4'd0;
                                        if(min_bcd10 == 4'd5) begin
                                                min_bcd10 <=4'd0;
                                                r_hour_tick <= 1'b1;
                                        end
                                        else min_bcd10 <= min_bcd10 + 1;
                                end
                                else min_bcd1 <= min_bcd1 + 1;
                        end
                end
        end
	
	// hour
	always@(posedge clk or negedge rst_n) begin
                if(!rst_n) begin
                        hour_bcd1 <= 0;
                        hour_bcd10 <= 0;
                end
                else if(r_hour_tick) begin
                	if(hour_bcd10 == 4'd2 && hour_bcd1 == 4'd3) begin
                        	hour_bcd10 <= 4'd0;
				hour_bcd1 <= 4'd0;
			end
                        else if(hour_bcd1 == 4'd9) begin
                        	hour_bcd1 <=4'd0;
                                hour_bcd10 <= hour_bcd10 + 1;
			end
                        else hour_bcd1 <= hour_bcd1 + 1;
                end
        end
	
endmodule
