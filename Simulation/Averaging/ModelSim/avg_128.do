vlog -work work -stats=none C:/Users/David/Documents/GitHub/FM-Demodulator/Module/Averaging/avg_128_tb.v
vlog -work work -stats=none C:/Users/David/Documents/GitHub/FM-Demodulator/Module/Averaging/avg_128.v

vsim -gui work.avg_128_tb

onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider avg_128
add wave -noupdate /avg_128_tb/DUT/clk
add wave -noupdate /avg_128_tb/DUT/rst
add wave -noupdate /avg_128_tb/DUT/data_i_r
add wave -noupdate -radix decimal /avg_128_tb/DUT/data_o
add wave -noupdate -radix decimal /avg_128_tb/DUT/buff
add wave -noupdate -radix decimal /avg_128_tb/DUT/sum
add wave -noupdate -radix decimal /avg_128_tb/DUT/sum_r
add wave -noupdate -radix decimal /avg_128_tb/DUT/mean
add wave -noupdate -radix decimal /avg_128_tb/DUT/mean_r
add wave -noupdate -radix unsigned /avg_128_tb/DUT/count
add wave -noupdate -radix unsigned /avg_128_tb/DUT/count_r
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {35 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 324
configure wave -valuecolwidth 40
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
WaveRestoreZoom {0 ps} {96 ps}