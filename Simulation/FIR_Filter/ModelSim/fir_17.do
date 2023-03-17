vlog -work work -stats=none C:/Users/David/Documents/GitHub/FM-Demodulator/Module/FIR_Filter/Verilog/fir_17.v
vlog -work work -stats=none C:/Users/David/Documents/GitHub/FM-Demodulator/Module/FIR_Filter/Verilog/fir_17_tb.v

vsim -gui work.fir_17_tb



onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /fir_17_tb/DUT/clk
add wave -noupdate /fir_17_tb/DUT/rst
add wave -noupdate /fir_17_tb/DUT/start_i
add wave -noupdate -divider FIR
add wave -noupdate /fir_17_tb/DUT/data_i
add wave -noupdate /fir_17_tb/DUT/data_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {108112 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {108090 ps} {109090 ps}

run -all