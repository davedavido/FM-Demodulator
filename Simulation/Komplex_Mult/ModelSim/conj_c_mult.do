vlog -work work -stats=none C:/Users/David/Documents/GitHub/FM-Demodulator/Module/Komplex_Mult/conj_c_mult.v
vlog -work work -stats=none C:/Users/David/Documents/GitHub/FM-Demodulator/Module/Komplex_Mult/conj_c_mult_tb.v

vsim -gui work.conj_c_mult_tb

onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /conj_c_mult_tb/DUT/demod_o
add wave -noupdate /conj_c_mult_tb/DUT/clk
add wave -noupdate /conj_c_mult_tb/DUT/rst
add wave -noupdate /conj_c_mult_tb/DUT/start_i
add wave -noupdate -divider {Komplexe Zahl}
add wave -noupdate /conj_c_mult_tb/DUT/real_i_r
add wave -noupdate /conj_c_mult_tb/DUT/imag_i_r
add wave -noupdate -divider Konstanten
add wave -noupdate /conj_c_mult_tb/DUT/k1_r
add wave -noupdate /conj_c_mult_tb/DUT/k3_r
add wave -noupdate /conj_c_mult_tb/DUT/cd_r
add wave -noupdate /conj_c_mult_tb/DUT/ba_r
add wave -noupdate /conj_c_mult_tb/DUT/last_in_real_r
add wave -noupdate /conj_c_mult_tb/DUT/last_in_imag_r
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {13 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 285
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
