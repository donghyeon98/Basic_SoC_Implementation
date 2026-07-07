
//input ports
add mapped point clk_in clk_in -type PI PI
add mapped point rst_n rst_n -type PI PI

//output ports
add mapped point o_clk_out o_clk_out -type PO PO

//inout ports




//Sequential Pins
add mapped point r_count[3]/q r_count_reg[3]/Q -type DFF DFF
add mapped point o_clk_out/q o_clk_out_reg/Q -type DFF DFF
add mapped point r_count[2]/q r_count_reg[2]/Q -type DFF DFF
add mapped point r_count[1]/q r_count_reg[1]/Q -type DFF DFF
add mapped point r_count[0]/q r_count_reg[0]/Q -type DFF DFF



//Black Boxes



//Empty Modules as Blackboxes
