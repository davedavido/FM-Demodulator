vlog -work work -stats=none C:/Users/David/Documents/GitHub/FM-Demodulator/Module/Merge_Data/merge_data.v
vlog -work work -stats=none C:/Users/David/Documents/GitHub/FM-Demodulator/Module/Merge_Data/merge_data_tb.v



vsim -gui work.merge_data_tb

onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /merge_data_tb/DUT/clk
add wave -noupdate /merge_data_tb/DUT/rst
add wave -noupdate /merge_data_tb/DUT/data_uart_i
add wave -noupdate /merge_data_tb/DUT/merge_finished_o
add wave -noupdate /merge_data_tb/DUT/data_o
add wave -noupdate /merge_data_tb/DUT/count_r
add wave -noupdate /merge_data_tb/DUT/buff
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {38 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 355
configure wave -valuecolwidth 359
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
WaveRestoreZoom {0 ps} {795 ps}

run -all