
//input ports
add mapped point clk clk -type PI PI
add mapped point rst_n rst_n -type PI PI
add mapped point go go -type PI PI
add mapped point ws ws -type PI PI

//output ports
add mapped point rd rd -type PO PO
add mapped point ds ds -type PO PO

//inout ports




//Sequential Pins
add mapped point rd/q rd_reg/Q -type DFF DFF
add mapped point state[0]/q state_reg[0]/Q -type DFF DFF
add mapped point ds/q ds_reg/Q -type DFF DFF
add mapped point state[1]/q state_reg[1]/Q -type DFF DFF



//Black Boxes



//Empty Modules as Blackboxes
