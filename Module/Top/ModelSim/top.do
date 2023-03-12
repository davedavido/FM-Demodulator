vlog -work work -stats=none C:/Users/David/Documents/GitHub/FM-Demodulator/Module/Top/top.v
vlog -work work -stats=none C:/Users/David/Documents/GitHub/FM-Demodulator/Module/Top/top_tb.v
vlog -work work -stats=none C:/Users/David/Documents/GitHub/FM-Demodulator/Module/Averaging/avg_128.v
vlog -work work -stats=none C:/Users/David/Documents/GitHub/FM-Demodulator/Module/Komplex_Mult/conj_c_mult.v
vlog -work work -stats=none C:/Users/David/Documents/GitHub/FM-Demodulator/Module/FIR_Filter/Verilog/fir_17.v
vlog -work work -stats=none C:/Users/David/Documents/GitHub/FM-Demodulator/Module/Package_Detect/pkg_detect.v

vsim -gui work.top_tb


onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top_tb/DUT/CONJ_C_MULT/clk
add wave -noupdate /top_tb/DUT/CONJ_C_MULT/rst
add wave -noupdate /top_tb/DUT/CONJ_C_MULT/start_i
add wave -noupdate -divider -height 25 I/O
add wave -noupdate /top_tb/data_o
add wave -noupdate /top_tb/data_i
add wave -noupdate -divider conj_c_mult
add wave -noupdate /top_tb/DUT/CONJ_C_MULT/real_i_r
add wave -noupdate /top_tb/DUT/CONJ_C_MULT/imag_i_r
add wave -noupdate /top_tb/DUT/CONJ_C_MULT/demod_o
add wave -noupdate -divider avg_128
add wave -noupdate /top_tb/DUT/AVG_128/data_i_r
add wave -noupdate /top_tb/DUT/AVG_128/data_o
add wave -noupdate /top_tb/DUT/AVG_128/count
add wave -noupdate -divider fir_17
add wave -noupdate /top_tb/DUT/FIR_17/data_i
add wave -noupdate /top_tb/DUT/FIR_17/data_o
add wave -noupdate -divider {PKG Detect}
add wave -noupdate /top_tb/DUT/PKG_DETECT/start_o
add wave -noupdate /top_tb/DUT/PKG_DETECT/valid_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {10 ps} 0}
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
WaveRestoreZoom {0 ps} {126 ps}

run -all
