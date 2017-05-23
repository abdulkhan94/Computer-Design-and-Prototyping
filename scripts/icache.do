onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /icache_tb/CLK
add wave -noupdate /icache_tb/nRST
add wave -noupdate -expand -group DCIF /icache_tb/dcif/imemREN
add wave -noupdate -expand -group DCIF /icache_tb/dcif/imemaddr
add wave -noupdate -expand -group DCIF /icache_tb/dcif/ihit
add wave -noupdate -expand -group DCIF /icache_tb/dcif/imemload
add wave -noupdate -group CCIF /icache_tb/ccif/iwait
add wave -noupdate -group CCIF /icache_tb/ccif/iload
add wave -noupdate -group CCIF /icache_tb/ccif/iREN
add wave -noupdate -group CCIF /icache_tb/ccif/iaddr
add wave -noupdate /icache_tb/DUT/inst
add wave -noupdate /icache_tb/DUT/ic_table
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {44 ns} 0}
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
WaveRestoreZoom {0 ns} {152 ns}
