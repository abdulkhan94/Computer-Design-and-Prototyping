onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/DUT/CPUCLK
add wave -noupdate -label PC0 /system_tb/DUT/CPU/DP0/pcif/pc_curr
add wave -noupdate -label PC1 /system_tb/DUT/CPU/DP1/pcif/pc_curr
add wave -noupdate /system_tb/nRST
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/halt
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/ihit
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/imemREN
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/imemload
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/imemaddr
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/dhit
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/datomic
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/dmemREN
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/dmemWEN
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/flushed
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/dmemload
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/dmemstore
add wave -noupdate -group dcif0 /system_tb/DUT/CPU/dcif0/dmemaddr
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/halt
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/ihit
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/imemREN
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/imemload
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/imemaddr
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/dhit
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/datomic
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/dmemREN
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/dmemWEN
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/flushed
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/dmemload
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/dmemstore
add wave -noupdate -group dcif1 /system_tb/DUT/CPU/dcif1/dmemaddr
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/ramREN
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/ramWEN
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/ramaddr
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/ramstore
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/ramload
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/ramstate
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/memREN
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/memWEN
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/memaddr
add wave -noupdate -group RAM /system_tb/DUT/RAM/ramif/memstore
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -expand -group CORE0-DCACHE /system_tb/DUT/CPU/CM0/DCACHE/CLK
add wave -noupdate -expand -group CORE0-DCACHE /system_tb/DUT/CPU/CM0/DCACHE/nRST
add wave -noupdate -expand -group CORE0-DCACHE /system_tb/DUT/CPU/CM0/DCACHE/curr_state
add wave -noupdate -expand -group CORE0-DCACHE /system_tb/DUT/CPU/CM0/DCACHE/next_state
add wave -noupdate -expand -group CORE0-DCACHE /system_tb/DUT/CPU/CM0/DCACHE/daddr
add wave -noupdate -expand -group CORE0-DCACHE -group others /system_tb/DUT/CPU/CM0/DCACHE/WAY1
add wave -noupdate -expand -group CORE0-DCACHE -group others /system_tb/DUT/CPU/CM0/DCACHE/WAY2
add wave -noupdate -expand -group CORE0-DCACHE -group others /system_tb/DUT/CPU/CM0/DCACHE/flush_index
add wave -noupdate -expand -group CORE0-DCACHE -group others /system_tb/DUT/CPU/CM0/DCACHE/nxt_flush_index
add wave -noupdate -expand -group CORE0-DCACHE -group others /system_tb/DUT/CPU/CM0/DCACHE/found_dirty_flag
add wave -noupdate -expand -group CORE0-DCACHE -group others /system_tb/DUT/CPU/CM0/DCACHE/choose_flushBLK
add wave -noupdate -expand -group CORE0-DCACHE -group others /system_tb/DUT/CPU/CM0/DCACHE/nxt_choose_flushBLK
add wave -noupdate -expand -group CORE0-DCACHE -group others /system_tb/DUT/CPU/CM0/DCACHE/count
add wave -noupdate -expand -group CORE0-DCACHE -group others /system_tb/DUT/CPU/CM0/DCACHE/next_count
add wave -noupdate -expand -group CORE0-DCACHE -group others /system_tb/DUT/CPU/CM0/DCACHE/miss
add wave -noupdate -expand -group CORE0-DCACHE -group others /system_tb/DUT/CPU/CM0/DCACHE/next_miss
add wave -noupdate -expand -group CORE0-DCACHE -group others /system_tb/DUT/CPU/CM0/DCACHE/chooseBLK1
add wave -noupdate -expand -group CORE0-DCACHE -group others /system_tb/DUT/CPU/CM0/DCACHE/chooseBLK2
add wave -noupdate -expand -group CORE0-DCACHE -group others /system_tb/DUT/CPU/CM0/DCACHE/chooseWORD1
add wave -noupdate -expand -group CORE0-DCACHE -group others /system_tb/DUT/CPU/CM0/DCACHE/chooseWORD2
add wave -noupdate -expand -group CORE0-DCACHE -group others /system_tb/DUT/CPU/CM0/DCACHE/snoopBLK1
add wave -noupdate -expand -group CORE0-DCACHE -group others /system_tb/DUT/CPU/CM0/DCACHE/snoopBLK2
add wave -noupdate -expand -group CORE0-DCACHE -group others /system_tb/DUT/CPU/CM0/DCACHE/nxt_valid1
add wave -noupdate -expand -group CORE0-DCACHE -group others /system_tb/DUT/CPU/CM0/DCACHE/nxt_valid2
add wave -noupdate -expand -group CORE0-DCACHE -group others /system_tb/DUT/CPU/CM0/DCACHE/nxt_dirty1
add wave -noupdate -expand -group CORE0-DCACHE -group others /system_tb/DUT/CPU/CM0/DCACHE/nxt_dirty2
add wave -noupdate -expand -group CORE0-DCACHE -group others /system_tb/DUT/CPU/CM0/DCACHE/nxt_LRU1
add wave -noupdate -expand -group CORE0-DCACHE -group others /system_tb/DUT/CPU/CM0/DCACHE/nxt_LRU2
add wave -noupdate -expand -group CORE0-DCACHE -group others /system_tb/DUT/CPU/CM0/DCACHE/nxt_tag1
add wave -noupdate -expand -group CORE0-DCACHE -group others /system_tb/DUT/CPU/CM0/DCACHE/nxt_tag2
add wave -noupdate -expand -group CORE0-DCACHE -group others /system_tb/DUT/CPU/CM0/DCACHE/nextword
add wave -noupdate -expand -group CORE0-DCACHE -group others /system_tb/DUT/CPU/CM0/DCACHE/hit_flag
add wave -noupdate -expand -group CORE0-DCACHE -group others /system_tb/DUT/CPU/CM0/DCACHE/nxt_hit_flag
add wave -noupdate -expand -group CORE0-DCACHE -group others /system_tb/DUT/CPU/CM0/DCACHE/BLK1flag
add wave -noupdate -expand -group CORE0-DCACHE -group others /system_tb/DUT/CPU/CM0/DCACHE/BLK2flag
add wave -noupdate -expand -group CORE0-DCACHE -group others /system_tb/DUT/CPU/CM0/DCACHE/nxt_BLK1flag
add wave -noupdate -expand -group CORE0-DCACHE -group others /system_tb/DUT/CPU/CM0/DCACHE/nxt_BLK2flag
add wave -noupdate -expand -group CORE0-DCACHE -group others /system_tb/DUT/CPU/CM0/DCACHE/writeB1W1
add wave -noupdate -expand -group CORE0-DCACHE -group others /system_tb/DUT/CPU/CM0/DCACHE/writeB1W2
add wave -noupdate -expand -group CORE0-DCACHE -group others /system_tb/DUT/CPU/CM0/DCACHE/writeB2W1
add wave -noupdate -expand -group CORE0-DCACHE -group others /system_tb/DUT/CPU/CM0/DCACHE/writeB2W2
add wave -noupdate -expand -group CORE0-DCACHE -group others /system_tb/DUT/CPU/CM0/DCACHE/hit
add wave -noupdate -expand -group CORE0-DCACHE -group others /system_tb/DUT/CPU/CM0/DCACHE/abdul_flush
add wave -noupdate -expand -group CORE0-DCACHE -group others /system_tb/DUT/CPU/CM0/DCACHE/snoop_hit
add wave -noupdate -expand -group CORE0-DCACHE -group others /system_tb/DUT/CPU/CM0/DCACHE/snoop_flag
add wave -noupdate -expand -group CORE0-DCACHE -group others /system_tb/DUT/CPU/CM0/DCACHE/saddr
add wave -noupdate -expand -group CORE0-DCACHE -group others /system_tb/DUT/CPU/CM0/DCACHE/j
add wave -noupdate -expand -group CORE0-DCACHE -group others /system_tb/DUT/CPU/CM0/DCACHE/i
add wave -noupdate -expand -group CORE1-DCACHE /system_tb/DUT/CPU/CM1/DCACHE/CLK
add wave -noupdate -expand -group CORE1-DCACHE /system_tb/DUT/CPU/CM1/DCACHE/nRST
add wave -noupdate -expand -group CORE1-DCACHE /system_tb/DUT/CPU/CM1/DCACHE/curr_state
add wave -noupdate -expand -group CORE1-DCACHE /system_tb/DUT/CPU/CM1/DCACHE/next_state
add wave -noupdate -expand -group CORE1-DCACHE /system_tb/DUT/CPU/CM1/DCACHE/daddr
add wave -noupdate -expand -group CORE1-DCACHE -group others /system_tb/DUT/CPU/CM1/DCACHE/WAY1
add wave -noupdate -expand -group CORE1-DCACHE -group others /system_tb/DUT/CPU/CM1/DCACHE/WAY2
add wave -noupdate -expand -group CORE1-DCACHE -group others /system_tb/DUT/CPU/CM1/DCACHE/flush_index
add wave -noupdate -expand -group CORE1-DCACHE -group others /system_tb/DUT/CPU/CM1/DCACHE/nxt_flush_index
add wave -noupdate -expand -group CORE1-DCACHE -group others /system_tb/DUT/CPU/CM1/DCACHE/found_dirty_flag
add wave -noupdate -expand -group CORE1-DCACHE -group others /system_tb/DUT/CPU/CM1/DCACHE/choose_flushBLK
add wave -noupdate -expand -group CORE1-DCACHE -group others /system_tb/DUT/CPU/CM1/DCACHE/nxt_choose_flushBLK
add wave -noupdate -expand -group CORE1-DCACHE -group others /system_tb/DUT/CPU/CM1/DCACHE/count
add wave -noupdate -expand -group CORE1-DCACHE -group others /system_tb/DUT/CPU/CM1/DCACHE/next_count
add wave -noupdate -expand -group CORE1-DCACHE -group others /system_tb/DUT/CPU/CM1/DCACHE/miss
add wave -noupdate -expand -group CORE1-DCACHE -group others /system_tb/DUT/CPU/CM1/DCACHE/next_miss
add wave -noupdate -expand -group CORE1-DCACHE -group others /system_tb/DUT/CPU/CM1/DCACHE/chooseBLK1
add wave -noupdate -expand -group CORE1-DCACHE -group others /system_tb/DUT/CPU/CM1/DCACHE/chooseBLK2
add wave -noupdate -expand -group CORE1-DCACHE -group others /system_tb/DUT/CPU/CM1/DCACHE/chooseWORD1
add wave -noupdate -expand -group CORE1-DCACHE -group others /system_tb/DUT/CPU/CM1/DCACHE/chooseWORD2
add wave -noupdate -expand -group CORE1-DCACHE -group others /system_tb/DUT/CPU/CM1/DCACHE/snoopBLK1
add wave -noupdate -expand -group CORE1-DCACHE -group others /system_tb/DUT/CPU/CM1/DCACHE/snoopBLK2
add wave -noupdate -expand -group CORE1-DCACHE -group others /system_tb/DUT/CPU/CM1/DCACHE/nxt_valid1
add wave -noupdate -expand -group CORE1-DCACHE -group others /system_tb/DUT/CPU/CM1/DCACHE/nxt_valid2
add wave -noupdate -expand -group CORE1-DCACHE -group others /system_tb/DUT/CPU/CM1/DCACHE/nxt_dirty1
add wave -noupdate -expand -group CORE1-DCACHE -group others /system_tb/DUT/CPU/CM1/DCACHE/nxt_dirty2
add wave -noupdate -expand -group CORE1-DCACHE -group others /system_tb/DUT/CPU/CM1/DCACHE/nxt_LRU1
add wave -noupdate -expand -group CORE1-DCACHE -group others /system_tb/DUT/CPU/CM1/DCACHE/nxt_LRU2
add wave -noupdate -expand -group CORE1-DCACHE -group others /system_tb/DUT/CPU/CM1/DCACHE/nxt_tag1
add wave -noupdate -expand -group CORE1-DCACHE -group others /system_tb/DUT/CPU/CM1/DCACHE/nxt_tag2
add wave -noupdate -expand -group CORE1-DCACHE -group others /system_tb/DUT/CPU/CM1/DCACHE/nextword
add wave -noupdate -expand -group CORE1-DCACHE -group others /system_tb/DUT/CPU/CM1/DCACHE/hit_flag
add wave -noupdate -expand -group CORE1-DCACHE -group others /system_tb/DUT/CPU/CM1/DCACHE/nxt_hit_flag
add wave -noupdate -expand -group CORE1-DCACHE -group others /system_tb/DUT/CPU/CM1/DCACHE/BLK1flag
add wave -noupdate -expand -group CORE1-DCACHE -group others /system_tb/DUT/CPU/CM1/DCACHE/BLK2flag
add wave -noupdate -expand -group CORE1-DCACHE -group others /system_tb/DUT/CPU/CM1/DCACHE/nxt_BLK1flag
add wave -noupdate -expand -group CORE1-DCACHE -group others /system_tb/DUT/CPU/CM1/DCACHE/nxt_BLK2flag
add wave -noupdate -expand -group CORE1-DCACHE -group others /system_tb/DUT/CPU/CM1/DCACHE/writeB1W1
add wave -noupdate -expand -group CORE1-DCACHE -group others /system_tb/DUT/CPU/CM1/DCACHE/writeB1W2
add wave -noupdate -expand -group CORE1-DCACHE -group others /system_tb/DUT/CPU/CM1/DCACHE/writeB2W1
add wave -noupdate -expand -group CORE1-DCACHE -group others /system_tb/DUT/CPU/CM1/DCACHE/writeB2W2
add wave -noupdate -expand -group CORE1-DCACHE -group others /system_tb/DUT/CPU/CM1/DCACHE/hit
add wave -noupdate -expand -group CORE1-DCACHE -group others /system_tb/DUT/CPU/CM1/DCACHE/abdul_flush
add wave -noupdate -expand -group CORE1-DCACHE -group others /system_tb/DUT/CPU/CM1/DCACHE/snoop_hit
add wave -noupdate -expand -group CORE1-DCACHE -group others /system_tb/DUT/CPU/CM1/DCACHE/snoop_flag
add wave -noupdate -expand -group CORE1-DCACHE -group others /system_tb/DUT/CPU/CM1/DCACHE/saddr
add wave -noupdate -expand -group CORE1-DCACHE -group others /system_tb/DUT/CPU/CM1/DCACHE/j
add wave -noupdate -expand -group CORE1-DCACHE -group others /system_tb/DUT/CPU/CM1/DCACHE/i
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -expand -group cif0 /system_tb/DUT/CPU/ccif/cif0/iwait
add wave -noupdate -expand -group cif0 /system_tb/DUT/CPU/ccif/cif0/dwait
add wave -noupdate -expand -group cif0 /system_tb/DUT/CPU/ccif/cif0/iREN
add wave -noupdate -expand -group cif0 /system_tb/DUT/CPU/ccif/cif0/dREN
add wave -noupdate -expand -group cif0 /system_tb/DUT/CPU/ccif/cif0/dWEN
add wave -noupdate -expand -group cif0 /system_tb/DUT/CPU/ccif/cif0/iload
add wave -noupdate -expand -group cif0 /system_tb/DUT/CPU/ccif/cif0/dload
add wave -noupdate -expand -group cif0 /system_tb/DUT/CPU/ccif/cif0/dstore
add wave -noupdate -expand -group cif0 /system_tb/DUT/CPU/ccif/cif0/iaddr
add wave -noupdate -expand -group cif0 /system_tb/DUT/CPU/ccif/cif0/daddr
add wave -noupdate -expand -group cif0 /system_tb/DUT/CPU/ccif/cif0/ccwait
add wave -noupdate -expand -group cif0 /system_tb/DUT/CPU/ccif/cif0/ccinv
add wave -noupdate -expand -group cif0 /system_tb/DUT/CPU/ccif/cif0/ccwrite
add wave -noupdate -expand -group cif0 /system_tb/DUT/CPU/ccif/cif0/cctrans
add wave -noupdate -expand -group cif0 /system_tb/DUT/CPU/ccif/cif0/ccsnoopaddr
add wave -noupdate -expand -group cif1 /system_tb/DUT/CPU/ccif/cif1/iwait
add wave -noupdate -expand -group cif1 /system_tb/DUT/CPU/ccif/cif1/dwait
add wave -noupdate -expand -group cif1 /system_tb/DUT/CPU/ccif/cif1/iREN
add wave -noupdate -expand -group cif1 /system_tb/DUT/CPU/ccif/cif1/dREN
add wave -noupdate -expand -group cif1 /system_tb/DUT/CPU/ccif/cif1/dWEN
add wave -noupdate -expand -group cif1 /system_tb/DUT/CPU/ccif/cif1/iload
add wave -noupdate -expand -group cif1 /system_tb/DUT/CPU/ccif/cif1/dload
add wave -noupdate -expand -group cif1 /system_tb/DUT/CPU/ccif/cif1/dstore
add wave -noupdate -expand -group cif1 /system_tb/DUT/CPU/ccif/cif1/iaddr
add wave -noupdate -expand -group cif1 /system_tb/DUT/CPU/ccif/cif1/daddr
add wave -noupdate -expand -group cif1 /system_tb/DUT/CPU/ccif/cif1/ccwait
add wave -noupdate -expand -group cif1 /system_tb/DUT/CPU/ccif/cif1/ccinv
add wave -noupdate -expand -group cif1 /system_tb/DUT/CPU/ccif/cif1/ccwrite
add wave -noupdate -expand -group cif1 /system_tb/DUT/CPU/ccif/cif1/cctrans
add wave -noupdate -expand -group cif1 /system_tb/DUT/CPU/ccif/cif1/ccsnoopaddr
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate /system_tb/DUT/CPU/CC/curr_state
add wave -noupdate /system_tb/DUT/CPU/CC/next_state
add wave -noupdate -group Others /system_tb/DUT/CPU/CC/dsource
add wave -noupdate -group Others /system_tb/DUT/CPU/CC/next_dsource
add wave -noupdate -group Others /system_tb/DUT/CPU/CC/isource
add wave -noupdate -group Others /system_tb/DUT/CPU/CC/next_isource
add wave -noupdate -label Register0 /system_tb/DUT/CPU/DP0/RF/register
add wave -noupdate -label Register1 /system_tb/DUT/CPU/DP1/RF/register
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 3} {19305 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 110
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
WaveRestoreZoom {0 ps} {103317 ps}
