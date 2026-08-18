
//input ports
add mapped point clk clk -type PI PI
add mapped point rst_n rst_n -type PI PI

//output ports
add mapped point sec_bcd1[3] sec_bcd1[3] -type PO PO
add mapped point sec_bcd1[2] sec_bcd1[2] -type PO PO
add mapped point sec_bcd1[1] sec_bcd1[1] -type PO PO
add mapped point sec_bcd1[0] sec_bcd1[0] -type PO PO
add mapped point sec_bcd10[3] sec_bcd10[3] -type PO PO
add mapped point sec_bcd10[2] sec_bcd10[2] -type PO PO
add mapped point sec_bcd10[1] sec_bcd10[1] -type PO PO
add mapped point sec_bcd10[0] sec_bcd10[0] -type PO PO
add mapped point min_bcd1[3] min_bcd1[3] -type PO PO
add mapped point min_bcd1[2] min_bcd1[2] -type PO PO
add mapped point min_bcd1[1] min_bcd1[1] -type PO PO
add mapped point min_bcd1[0] min_bcd1[0] -type PO PO
add mapped point min_bcd10[3] min_bcd10[3] -type PO PO
add mapped point min_bcd10[2] min_bcd10[2] -type PO PO
add mapped point min_bcd10[1] min_bcd10[1] -type PO PO
add mapped point min_bcd10[0] min_bcd10[0] -type PO PO
add mapped point hour_bcd1[3] hour_bcd1[3] -type PO PO
add mapped point hour_bcd1[2] hour_bcd1[2] -type PO PO
add mapped point hour_bcd1[1] hour_bcd1[1] -type PO PO
add mapped point hour_bcd1[0] hour_bcd1[0] -type PO PO
add mapped point hour_bcd10[3] hour_bcd10[3] -type PO PO
add mapped point hour_bcd10[2] hour_bcd10[2] -type PO PO
add mapped point hour_bcd10[1] hour_bcd10[1] -type PO PO
add mapped point hour_bcd10[0] hour_bcd10[0] -type PO PO

//inout ports




//Sequential Pins
add mapped point hour_bcd10[3]/q hour_bcd10_reg[3]/Q -type DFF DFF
add mapped point hour_bcd10[2]/q hour_bcd10_reg[2]/Q -type DFF DFF
add mapped point hour_bcd10[1]/q hour_bcd10_reg[1]/Q -type DFF DFF
add mapped point hour_bcd1[3]/q hour_bcd1_reg[3]/Q -type DFF DFF
add mapped point hour_bcd1[2]/q hour_bcd1_reg[2]/Q -type DFF DFF
add mapped point hour_bcd10[0]/q hour_bcd10_reg[0]/Q -type DFF DFF
add mapped point hour_bcd1[1]/q hour_bcd1_reg[1]/Q -type DFF DFF
add mapped point hour_bcd1[0]/q hour_bcd1_reg[0]/Q -type DFF DFF
add mapped point min_bcd10[3]/q min_bcd10_reg[3]/Q -type DFF DFF
add mapped point min_bcd10[2]/q min_bcd10_reg[2]/Q -type DFF DFF
add mapped point min_bcd1[3]/q min_bcd1_reg[3]/Q -type DFF DFF
add mapped point r_hour_tick/q r_hour_tick_reg/Q -type DFF DFF
add mapped point min_bcd10[0]/q min_bcd10_reg[0]/Q -type DFF DFF
add mapped point min_bcd10[1]/q min_bcd10_reg[1]/Q -type DFF DFF
add mapped point min_bcd1[2]/q min_bcd1_reg[2]/Q -type DFF DFF
add mapped point min_bcd1[1]/q min_bcd1_reg[1]/Q -type DFF DFF
add mapped point min_bcd1[0]/q min_bcd1_reg[0]/Q -type DFF DFF
add mapped point sec_bcd10[3]/q sec_bcd10_reg[3]/Q -type DFF DFF
add mapped point sec_bcd10[2]/q sec_bcd10_reg[2]/Q -type DFF DFF
add mapped point r_min_tick/q r_min_tick_reg/Q -type DFF DFF
add mapped point sec_bcd10[0]/q sec_bcd10_reg[0]/Q -type DFF DFF
add mapped point sec_bcd1[3]/q sec_bcd1_reg[3]/Q -type DFF DFF
add mapped point sec_bcd10[1]/q sec_bcd10_reg[1]/Q -type DFF DFF
add mapped point sec_bcd1[1]/q sec_bcd1_reg[1]/Q -type DFF DFF
add mapped point sec_bcd1[2]/q sec_bcd1_reg[2]/Q -type DFF DFF
add mapped point sec_bcd1[0]/q sec_bcd1_reg[0]/Q -type DFF DFF



//Black Boxes



//Empty Modules as Blackboxes
