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
add wave -noupdate /top_tb/DUT/AVG_128/data_i_r
add wave -noupdate -radix unsigned /top_tb/DUT/AVG_128/count_r
add wave -noupdate /top_tb/DUT/AVG_128/buff
add wave -noupdate /top_tb/DUT/AVG_128/sum_r
add wave -noupdate -radix binary /top_tb/DUT/AVG_128/sum
add wave -noupdate /top_tb/DUT/AVG_128/data_o
add wave -noupdate -divider fir_17
add wave -noupdate /top_tb/DUT/FIR_17/data_i
add wave -noupdate -radix decimal -childformat {{{/top_tb/DUT/FIR_17/buff[0]} -radix decimal} {{/top_tb/DUT/FIR_17/buff[1]} -radix decimal} {{/top_tb/DUT/FIR_17/buff[2]} -radix decimal} {{/top_tb/DUT/FIR_17/buff[3]} -radix decimal} {{/top_tb/DUT/FIR_17/buff[4]} -radix decimal} {{/top_tb/DUT/FIR_17/buff[5]} -radix decimal} {{/top_tb/DUT/FIR_17/buff[6]} -radix decimal} {{/top_tb/DUT/FIR_17/buff[7]} -radix decimal} {{/top_tb/DUT/FIR_17/buff[8]} -radix decimal} {{/top_tb/DUT/FIR_17/buff[9]} -radix decimal} {{/top_tb/DUT/FIR_17/buff[10]} -radix decimal} {{/top_tb/DUT/FIR_17/buff[11]} -radix decimal} {{/top_tb/DUT/FIR_17/buff[12]} -radix decimal} {{/top_tb/DUT/FIR_17/buff[13]} -radix decimal} {{/top_tb/DUT/FIR_17/buff[14]} -radix decimal} {{/top_tb/DUT/FIR_17/buff[15]} -radix decimal} {{/top_tb/DUT/FIR_17/buff[16]} -radix decimal}} -subitemconfig {{/top_tb/DUT/FIR_17/buff[0]} {-height 15 -radix decimal} {/top_tb/DUT/FIR_17/buff[1]} {-height 15 -radix decimal} {/top_tb/DUT/FIR_17/buff[2]} {-height 15 -radix decimal} {/top_tb/DUT/FIR_17/buff[3]} {-height 15 -radix decimal} {/top_tb/DUT/FIR_17/buff[4]} {-height 15 -radix decimal} {/top_tb/DUT/FIR_17/buff[5]} {-height 15 -radix decimal} {/top_tb/DUT/FIR_17/buff[6]} {-height 15 -radix decimal} {/top_tb/DUT/FIR_17/buff[7]} {-height 15 -radix decimal} {/top_tb/DUT/FIR_17/buff[8]} {-height 15 -radix decimal} {/top_tb/DUT/FIR_17/buff[9]} {-height 15 -radix decimal} {/top_tb/DUT/FIR_17/buff[10]} {-height 15 -radix decimal} {/top_tb/DUT/FIR_17/buff[11]} {-height 15 -radix decimal} {/top_tb/DUT/FIR_17/buff[12]} {-height 15 -radix decimal} {/top_tb/DUT/FIR_17/buff[13]} {-height 15 -radix decimal} {/top_tb/DUT/FIR_17/buff[14]} {-height 15 -radix decimal} {/top_tb/DUT/FIR_17/buff[15]} {-height 15 -radix decimal} {/top_tb/DUT/FIR_17/buff[16]} {-height 15 -radix decimal}} /top_tb/DUT/FIR_17/buff
add wave -noupdate -radix decimal -childformat {{{/top_tb/DUT/FIR_17/acc_r[0]} -radix decimal} {{/top_tb/DUT/FIR_17/acc_r[1]} -radix decimal} {{/top_tb/DUT/FIR_17/acc_r[2]} -radix decimal} {{/top_tb/DUT/FIR_17/acc_r[3]} -radix decimal} {{/top_tb/DUT/FIR_17/acc_r[4]} -radix decimal} {{/top_tb/DUT/FIR_17/acc_r[5]} -radix decimal} {{/top_tb/DUT/FIR_17/acc_r[6]} -radix decimal} {{/top_tb/DUT/FIR_17/acc_r[7]} -radix decimal} {{/top_tb/DUT/FIR_17/acc_r[8]} -radix decimal} {{/top_tb/DUT/FIR_17/acc_r[9]} -radix decimal} {{/top_tb/DUT/FIR_17/acc_r[10]} -radix decimal} {{/top_tb/DUT/FIR_17/acc_r[11]} -radix decimal} {{/top_tb/DUT/FIR_17/acc_r[12]} -radix decimal} {{/top_tb/DUT/FIR_17/acc_r[13]} -radix decimal} {{/top_tb/DUT/FIR_17/acc_r[14]} -radix decimal} {{/top_tb/DUT/FIR_17/acc_r[15]} -radix decimal} {{/top_tb/DUT/FIR_17/acc_r[16]} -radix decimal}} -subitemconfig {{/top_tb/DUT/FIR_17/acc_r[0]} {-height 15 -radix decimal} {/top_tb/DUT/FIR_17/acc_r[1]} {-height 15 -radix decimal} {/top_tb/DUT/FIR_17/acc_r[2]} {-height 15 -radix decimal} {/top_tb/DUT/FIR_17/acc_r[3]} {-height 15 -radix decimal} {/top_tb/DUT/FIR_17/acc_r[4]} {-height 15 -radix decimal} {/top_tb/DUT/FIR_17/acc_r[5]} {-height 15 -radix decimal} {/top_tb/DUT/FIR_17/acc_r[6]} {-height 15 -radix decimal} {/top_tb/DUT/FIR_17/acc_r[7]} {-height 15 -radix decimal} {/top_tb/DUT/FIR_17/acc_r[8]} {-height 15 -radix decimal} {/top_tb/DUT/FIR_17/acc_r[9]} {-height 15 -radix decimal} {/top_tb/DUT/FIR_17/acc_r[10]} {-height 15 -radix decimal} {/top_tb/DUT/FIR_17/acc_r[11]} {-height 15 -radix decimal} {/top_tb/DUT/FIR_17/acc_r[12]} {-height 15 -radix decimal} {/top_tb/DUT/FIR_17/acc_r[13]} {-height 15 -radix decimal} {/top_tb/DUT/FIR_17/acc_r[14]} {-height 15 -radix decimal} {/top_tb/DUT/FIR_17/acc_r[15]} {-height 15 -radix decimal} {/top_tb/DUT/FIR_17/acc_r[16]} {-height 15 -radix decimal}} /top_tb/DUT/FIR_17/acc_r
add wave -noupdate -divider {PKG Detect}
add wave -noupdate -divider Split_data
add wave -noupdate /top_tb/DUT/FIR_17/data_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1045 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 250
configure wave -valuecolwidth 343
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
WaveRestoreZoom {987 ps} {1053 ps}

run -all
