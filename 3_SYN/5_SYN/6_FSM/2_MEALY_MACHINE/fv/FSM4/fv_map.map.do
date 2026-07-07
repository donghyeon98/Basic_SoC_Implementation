
//input ports
add mapped point clk clk -type PI PI
add mapped point rst_n rst_n -type PI PI
add mapped point din_bit din_bit -type PI PI

//output ports
add mapped point dout_bit dout_bit -type PO PO

//inout ports




//Sequential Pins
add mapped point state[1]/q state_reg[1]/Q -type DFF DFF
add mapped point state[0]/q state_reg[0]/Q -type DFF DFF
add mapped point state[2]/q state_reg[2]/Q -type DFF DFF



//Black Boxes



//Empty Modules as Blackboxes
