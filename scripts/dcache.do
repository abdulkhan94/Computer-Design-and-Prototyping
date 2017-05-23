onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dcache_tb/CLK
add wave -noupdate /dcache_tb/nRST
add wave -noupdate -label daddr_inst /dcache_tb/DUT/daddr
add wave -noupdate -group CHOOSE /dcache_tb/DUT/chooseBLK1
add wave -noupdate -group CHOOSE /dcache_tb/DUT/chooseBLK2
add wave -noupdate -group CHOOSE /dcache_tb/DUT/chooseWORD1
add wave -noupdate -group CHOOSE /dcache_tb/DUT/chooseWORD2
add wave -noupdate -group WRITE /dcache_tb/DUT/writeB1W1
add wave -noupdate -group WRITE /dcache_tb/DUT/writeB1W2
add wave -noupdate -group WRITE /dcache_tb/DUT/writeB2W1
add wave -noupdate -group WRITE /dcache_tb/DUT/writeB2W2
add wave -noupdate /dcache_tb/DUT/curr_state
add wave -noupdate /dcache_tb/DUT/nextword
add wave -noupdate /dcache_tb/PROG/testcase
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -expand -group DCIF /dcache_tb/dcif/dhit
add wave -noupdate -expand -group DCIF /dcache_tb/dcif/dmemREN
add wave -noupdate -expand -group DCIF /dcache_tb/dcif/dmemWEN
add wave -noupdate -expand -group DCIF /dcache_tb/dcif/flushed
add wave -noupdate -expand -group DCIF /dcache_tb/dcif/dmemload
add wave -noupdate -expand -group DCIF /dcache_tb/dcif/dmemstore
add wave -noupdate -expand -group DCIF /dcache_tb/dcif/dmemaddr
add wave -noupdate -group CCIF /dcache_tb/ccif/dwait
add wave -noupdate -group CCIF /dcache_tb/ccif/dREN
add wave -noupdate -group CCIF /dcache_tb/ccif/dWEN
add wave -noupdate -group CCIF /dcache_tb/ccif/dload
add wave -noupdate -group CCIF /dcache_tb/ccif/dstore
add wave -noupdate -group CCIF /dcache_tb/ccif/iaddr
add wave -noupdate -group CCIF /dcache_tb/ccif/daddr
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -expand /dcache_tb/DUT/WAY1
add wave -noupdate /dcache_tb/DUT/WAY2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {140 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {127 ns} {210 ns}
