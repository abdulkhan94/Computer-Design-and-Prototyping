onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dcache_tb/CLK
add wave -noupdate /dcache_tb/nRST
add wave -noupdate -expand -group DCIF /dcache_tb/dcif/dhit
add wave -noupdate -expand -group DCIF /dcache_tb/dcif/datomic
add wave -noupdate -expand -group DCIF /dcache_tb/dcif/dmemREN
add wave -noupdate -expand -group DCIF /dcache_tb/dcif/dmemWEN
add wave -noupdate -expand -group DCIF /dcache_tb/dcif/flushed
add wave -noupdate -expand -group DCIF /dcache_tb/dcif/dmemload
add wave -noupdate -expand -group DCIF /dcache_tb/dcif/dmemstore
add wave -noupdate -expand -group DCIF /dcache_tb/dcif/dmemaddr
add wave -noupdate -expand -group CCIF /dcache_tb/ccif/dwait
add wave -noupdate -expand -group CCIF /dcache_tb/ccif/iREN
add wave -noupdate -expand -group CCIF /dcache_tb/ccif/dREN
add wave -noupdate -expand -group CCIF /dcache_tb/ccif/dWEN
add wave -noupdate -expand -group CCIF /dcache_tb/ccif/dload
add wave -noupdate -expand -group CCIF /dcache_tb/ccif/dstore
add wave -noupdate -expand -group CCIF /dcache_tb/ccif/iaddr
add wave -noupdate -expand -group CCIF /dcache_tb/ccif/daddr
add wave -noupdate /dcache_tb/DUT/WAY1
add wave -noupdate /dcache_tb/DUT/WAY2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {22 ns} 0}
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
WaveRestoreZoom {20 ns} {84 ns}
