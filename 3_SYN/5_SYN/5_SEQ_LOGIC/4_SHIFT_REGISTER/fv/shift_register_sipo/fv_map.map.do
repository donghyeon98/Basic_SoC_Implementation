
//input ports
add mapped point clk clk -type PI PI
add mapped point rst_n rst_n -type PI PI
add mapped point i_serial_in i_serial_in -type PI PI
add mapped point load load -type PI PI

//output ports
add mapped point o_parallel_out[7] o_parallel_out[7] -type PO PO
add mapped point o_parallel_out[6] o_parallel_out[6] -type PO PO
add mapped point o_parallel_out[5] o_parallel_out[5] -type PO PO
add mapped point o_parallel_out[4] o_parallel_out[4] -type PO PO
add mapped point o_parallel_out[3] o_parallel_out[3] -type PO PO
add mapped point o_parallel_out[2] o_parallel_out[2] -type PO PO
add mapped point o_parallel_out[1] o_parallel_out[1] -type PO PO
add mapped point o_parallel_out[0] o_parallel_out[0] -type PO PO

//inout ports




//Sequential Pins
add mapped point o_parallel_out[4]/q o_parallel_out_reg[4]/Q -type DFF DFF
add mapped point o_parallel_out[1]/q o_parallel_out_reg[1]/Q -type DFF DFF
add mapped point o_parallel_out[3]/q o_parallel_out_reg[3]/Q -type DFF DFF
add mapped point o_parallel_out[0]/q o_parallel_out_reg[0]/Q -type DFF DFF
add mapped point r_reg_data[3]/q r_reg_data_reg[3]/Q -type DFF DFF
add mapped point r_reg_data[2]/q r_reg_data_reg[2]/Q -type DFF DFF
add mapped point r_reg_data[4]/q r_reg_data_reg[4]/Q -type DFF DFF
add mapped point r_reg_data[5]/q r_reg_data_reg[5]/Q -type DFF DFF
add mapped point o_parallel_out[5]/q o_parallel_out_reg[5]/Q -type DFF DFF
add mapped point o_parallel_out[7]/q o_parallel_out_reg[7]/Q -type DFF DFF
add mapped point r_reg_data[7]/q r_reg_data_reg[7]/Q -type DFF DFF
add mapped point o_parallel_out[2]/q o_parallel_out_reg[2]/Q -type DFF DFF
add mapped point o_parallel_out[6]/q o_parallel_out_reg[6]/Q -type DFF DFF
add mapped point r_reg_data[1]/q r_reg_data_reg[1]/Q -type DFF DFF
add mapped point r_reg_data[6]/q r_reg_data_reg[6]/Q -type DFF DFF
add mapped point r_reg_data[0]/q r_reg_data_reg[0]/Q -type DFF DFF



//Black Boxes



//Empty Modules as Blackboxes
