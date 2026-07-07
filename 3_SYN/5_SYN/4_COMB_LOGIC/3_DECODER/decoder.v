`timescale 1ns / 1ps

module decoder( 
	// port list
	i_bcd,
	o_seg
);
	// port declaration
	input 	[3:0] i_bcd	;
	output 	[6:0] o_seg	;
	
	// modeling
	reg 	[6:0] o_seg	;
	always@(*) begin
		case(i_bcd)
			4'b0000 : o_seg = 7'b111_1110;
			4'b0001 : o_seg = 7'b011_0000;
			4'b0010 : o_seg = 7'b110_1101;
			4'b0011 : o_seg = 7'b111_1001;
			4'b0100 : o_seg = 7'b011_0011;
			4'b0101 : o_seg = 7'b101_1011;
                        4'b0110 : o_seg = 7'b101_1111;
                        4'b0111 : o_seg = 7'b111_0000;
                        4'b1000 : o_seg = 7'b111_1111;
                        4'b1001 : o_seg = 7'b111_1011;
			default : o_seg = 7'b000_0000;
		endcase
	end
	
endmodule
