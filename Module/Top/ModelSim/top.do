vlog -work work -stats=none C:/Users/David/Documents/GitHub/FM-Demodulator/Module/Top/top.v
vlog -work work -stats=none C:/Users/David/Documents/GitHub/FM-Demodulator/Module/Top/top_tb.v
vlog -work work -stats=none C:/Users/David/Documents/GitHub/FM-Demodulator/Module/Averaging/avg_128.v
vlog -work work -stats=none C:/Users/David/Documents/GitHub/FM-Demodulator/Module/Komplex_Mult/conj_c_mult.v
vlog -work work -stats=none C:/Users/David/Documents/GitHub/FM-Demodulator/Module/FIR_Filter/Verilog/fir_17.v
vlog -work work -stats=none C:/Users/David/Documents/GitHub/FM-Demodulator/Module/Package_Detect/pkg_detect.v
vlog -work work -stats=none C:/Users/David/Documents/GitHub/FM-Demodulator/Module/Merge_Data/merge_data.v
vlog -work work -stats=none C:/Users/David/Documents/GitHub/FM-Demodulator/Module/Split_Data/split_data.v

vsim -gui work.top_tb

onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top_tb/DUT/CONJ_C_MULT/clk
add wave -noupdate /top_tb/DUT/CONJ_C_MULT/rst
add wave -noupdate /top_tb/DUT/CONJ_C_MULT/start_i
add wave -noupdate -divider -height 25 I/O
add wave -noupdate /top_tb/data_o
add wave -noupdate /top_tb/data_i
add wave -noupdate -divider Merge_Data
add wave -noupdate /top_tb/data_i
add wave -noupdate /top_tb/DUT/MERGE_DATA/data_uart_i
add wave -noupdate /top_tb/DUT/MERGE_DATA/merge_finished_o
add wave -noupdate /top_tb/DUT/MERGE_DATA/data_o
add wave -noupdate -divider conj_c_mult
add wave -noupdate /top_tb/DUT/CONJ_C_MULT/real_i_r
add wave -noupdate /top_tb/DUT/CONJ_C_MULT/imag_i_r
add wave -noupdate /top_tb/DUT/CONJ_C_MULT/demod_o
add wave -noupdate -divider avg_128
add wave -noupdate -divider fir_17
add wave -noupdate -divider {PKG Detect}
add wave -noupdate /top_tb/DUT/AVG_128/data_i_r
add wave -noupdate /top_tb/DUT/AVG_128/data_i
add wave -noupdate /top_tb/DUT/AVG_128/sum
add wave -noupdate /top_tb/DUT/AVG_128/sum_r
add wave -noupdate -divider Split_data
add wave -noupdate /top_tb/DUT/SPLIT_DATA/data_i
add wave -noupdate /top_tb/DUT/SPLIT_DATA/data_uart_o
add wave -noupdate /top_tb/DUT/SPLIT_DATA/count_r
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {35 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 250
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
WaveRestoreZoom {0 ps} {120 ps}


run -all
