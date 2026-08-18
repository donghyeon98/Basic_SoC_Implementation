## set Simulation
touch cds.lib hdl.var
mkdir work.lib
echo "define work.lib ./work.lib" >> ./cds.lib
echo "define WORK work_lib" >> ./hdl.var

# Compile HDL sources
xmvlog -MESS -linedebug ./*
# Elaborate compiled sources
xmlab -MESS -access rwc tb_Hamming_Code_Encoder

# run simulation in CLI mode
xmsim -MESS tb_Hamming_Code_Encoder -gui

