`timescale 1ns / 1ps

module tb_Down_Counter;
        reg clk         	;
        reg rst_n       	;
        reg enable      	;
        wire [3:0] count      	;

        Down_Counter dut(
        .clk(clk),
        .rst_n(rst_n),
        .enable(enable),
        .count(count));

        initial begin
                clk = 1'b0;
                forever #5 clk = ~clk;
        end

        initial begin
                rst_n = 1'b0; enable = 1'b0; #10;
                rst_n = 1'b0; enable = 1'b1; #10;
                rst_n = 1'b1; enable = 1'b0; #10;
                rst_n = 1'b1; enable = 1'b1; #160;
                $finish;
        end

endmodule

