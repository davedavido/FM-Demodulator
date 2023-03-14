onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /merge_data_tb/clk
add wave -noupdate /merge_data_tb/rst
add wave -noupdate /merge_data_tb/DUT1/merge_finished_o
add wave -noupdate -radix unsigned /merge_data_tb/DUT1/data_uart_i
add wave -noupdate /merge_data_tb/DUT1/data_o
add wave -noupdate /merge_data_tb/DUT1/count_r
add wave -noupdate -divider Split
add wave -noupdate -radix decimal /merge_data_tb/DUT2/data_i
add wave -noupdate /merge_data_tb/DUT2/data_uart_o
add wave -noupdate -divider Bitstream
add wave -noupdate /merge_data_tb/DUT0/start_o
add wave -noupdate -radix unsigned /merge_data_tb/DUT0/count
add wave -noupdate /merge_data_tb/DUT0/data_i
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {20 ps} 0}
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
WaveRestoreZoom {5 ps} {105 ps}
