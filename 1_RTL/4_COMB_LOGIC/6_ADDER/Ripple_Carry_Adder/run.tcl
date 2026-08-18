## set Simulation
touch cds.lib hdl.var
mkdir work.lib
echo "define work.lib ./work.lib" >> ./cds.lib
echo "define WORK work_lib" >> ./hdl.var

# Compile HDL sources
xmvlog -MESS -linedebug ./*
# Elaborate compiled sources
xmlab -MESS -access rwc tb_Ripple_Carry_Adder

# run simulation in CLI mode
xmsim -MESS tb_Ripple_Carry_Adder -gui

