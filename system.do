onerror {resume}
quietly virtual function -install /system_tb/DUT/CPU/DP/ifif -env /system_tb/DUT/CPU/DP/ifif { &{/system_tb/DUT/CPU/DP/ifif/instr_in, /system_tb/DUT/CPU/DP/ifif/pc_next_in, /system_tb/DUT/CPU/DP/ifif/instr_out, /system_tb/DUT/CPU/DP/ifif/pc_next_out, /system_tb/DUT/CPU/DP/ifif/nop, /system_tb/DUT/CPU/DP/ifif/enable }} IFID
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/DUT/CPUCLK
add wave -noupdate /system_tb/nRST
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/ihit
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/dhit
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/halt
add wave -noupdate /system_tb/DUT/CPU/DP/pcif/pc_curr
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/HU/huif/dhit
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/HU/huif/ihit
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/HU/huif/ifid_rs
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/HU/huif/ifid_rt
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/HU/huif/exmem_op
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/HU/huif/exmem_jump
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/HU/huif/ifid_enable
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/HU/huif/idex_enable
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/HU/huif/exmem_enable
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/HU/huif/memwb_enable
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/HU/huif/ifid_nop
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/HU/huif/idex_nop
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/HU/huif/exmem_nop
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/HU/huif/memwb_nop
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/HU/huif/pcstall
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/HU/huif/idex_out_wsel
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/HU/huif/exmem_out_wsel
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/HU/huif/exmem_branch
add wave -noupdate -group {Hazard Unit} /system_tb/DUT/CPU/DP/HU/huif/zero_flag
add wave -noupdate -expand -group {Forward Unit} /system_tb/DUT/CPU/DP/FU/fuif/idex_rs_out
add wave -noupdate -expand -group {Forward Unit} /system_tb/DUT/CPU/DP/FU/fuif/idex_rt_out
add wave -noupdate -expand -group {Forward Unit} /system_tb/DUT/CPU/DP/FU/fuif/exmem_wsel_out
add wave -noupdate -expand -group {Forward Unit} /system_tb/DUT/CPU/DP/FU/fuif/memwb_wsel_out
add wave -noupdate -expand -group {Forward Unit} /system_tb/DUT/CPU/DP/FU/fuif/exmem_RegWrite_out
add wave -noupdate -expand -group {Forward Unit} /system_tb/DUT/CPU/DP/FU/fuif/memwb_RegWrite_out
add wave -noupdate -expand -group {Forward Unit} /system_tb/DUT/CPU/DP/FU/fuif/forwardA
add wave -noupdate -expand -group {Forward Unit} /system_tb/DUT/CPU/DP/FU/fuif/forwardB
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -label Id /system_tb/DUT/CPU/DP/idif/op_in
add wave -noupdate -label EX /system_tb/DUT/CPU/DP/exif/op_in
add wave -noupdate -label MEM /system_tb/DUT/CPU/DP/meif/op_in
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -group IFID /system_tb/DUT/CPU/DP/ifif/instr_in
add wave -noupdate -group IFID /system_tb/DUT/CPU/DP/ifif/pc_next_in
add wave -noupdate -group IFID -radix binary /system_tb/DUT/CPU/DP/ifif/instr_out
add wave -noupdate -group IFID /system_tb/DUT/CPU/DP/ifif/pc_next_out
add wave -noupdate -group IFID /system_tb/DUT/CPU/DP/ifif/nop
add wave -noupdate -group IFID /system_tb/DUT/CPU/DP/ifif/enable
add wave -noupdate -group IDEX /system_tb/DUT/CPU/DP/idif/extended_value_in
add wave -noupdate -group IDEX /system_tb/DUT/CPU/DP/idif/extended_value_out
add wave -noupdate -group IDEX /system_tb/DUT/CPU/DP/idif/inst_in
add wave -noupdate -group IDEX /system_tb/DUT/CPU/DP/idif/inst_out
add wave -noupdate -group IDEX /system_tb/DUT/CPU/DP/idif/rdat1_in
add wave -noupdate -group IDEX /system_tb/DUT/CPU/DP/idif/rdat1_out
add wave -noupdate -group IDEX /system_tb/DUT/CPU/DP/idif/rdat2_in
add wave -noupdate -group IDEX /system_tb/DUT/CPU/DP/idif/rdat2_out
add wave -noupdate -group IDEX /system_tb/DUT/CPU/DP/idif/pc_next_in
add wave -noupdate -group IDEX /system_tb/DUT/CPU/DP/idif/pc_next_out
add wave -noupdate -group IDEX /system_tb/DUT/CPU/DP/idif/lui_in
add wave -noupdate -group IDEX /system_tb/DUT/CPU/DP/idif/lui_out
add wave -noupdate -group IDEX /system_tb/DUT/CPU/DP/idif/lui_value_in
add wave -noupdate -group IDEX /system_tb/DUT/CPU/DP/idif/lui_value_out
add wave -noupdate -group IDEX /system_tb/DUT/CPU/DP/idif/branch_in
add wave -noupdate -group IDEX /system_tb/DUT/CPU/DP/idif/branch_out
add wave -noupdate -group IDEX /system_tb/DUT/CPU/DP/idif/jump_in
add wave -noupdate -group IDEX /system_tb/DUT/CPU/DP/idif/jump_out
add wave -noupdate -group IDEX /system_tb/DUT/CPU/DP/idif/MemToReg_in
add wave -noupdate -group IDEX /system_tb/DUT/CPU/DP/idif/MemToReg_out
add wave -noupdate -group IDEX /system_tb/DUT/CPU/DP/idif/shamt_value_in
add wave -noupdate -group IDEX /system_tb/DUT/CPU/DP/idif/shamt_value_out
add wave -noupdate -group IDEX /system_tb/DUT/CPU/DP/idif/shamt_in
add wave -noupdate -group IDEX /system_tb/DUT/CPU/DP/idif/shamt_out
add wave -noupdate -group IDEX /system_tb/DUT/CPU/DP/idif/ALUSrc_in
add wave -noupdate -group IDEX /system_tb/DUT/CPU/DP/idif/ALUSrc_out
add wave -noupdate -group IDEX /system_tb/DUT/CPU/DP/idif/RegDst_in
add wave -noupdate -group IDEX /system_tb/DUT/CPU/DP/idif/RegDst_out
add wave -noupdate -group IDEX /system_tb/DUT/CPU/DP/idif/ALUOp_in
add wave -noupdate -group IDEX /system_tb/DUT/CPU/DP/idif/ALUOp_out
add wave -noupdate -group IDEX /system_tb/DUT/CPU/DP/idif/halt_in
add wave -noupdate -group IDEX /system_tb/DUT/CPU/DP/idif/halt_out
add wave -noupdate -group IDEX /system_tb/DUT/CPU/DP/idif/dWEN_in
add wave -noupdate -group IDEX /system_tb/DUT/CPU/DP/idif/dWEN_out
add wave -noupdate -group IDEX /system_tb/DUT/CPU/DP/idif/dREN_in
add wave -noupdate -group IDEX /system_tb/DUT/CPU/DP/idif/dREN_out
add wave -noupdate -group IDEX /system_tb/DUT/CPU/DP/idif/RegWrite_in
add wave -noupdate -group IDEX /system_tb/DUT/CPU/DP/idif/RegWrite_out
add wave -noupdate -group IDEX /system_tb/DUT/CPU/DP/idif/op_in
add wave -noupdate -group IDEX /system_tb/DUT/CPU/DP/idif/op_out
add wave -noupdate -group IDEX /system_tb/DUT/CPU/DP/idif/nop
add wave -noupdate -group IDEX /system_tb/DUT/CPU/DP/idif/enable
add wave -noupdate -group DP_Local /system_tb/DUT/CPU/DP/extended_value
add wave -noupdate -group DP_Local /system_tb/DUT/CPU/DP/shamt_value
add wave -noupdate -group DP_Local /system_tb/DUT/CPU/DP/lui_value
add wave -noupdate -group DP_Local /system_tb/DUT/CPU/DP/pcn
add wave -noupdate -group DP_Local /system_tb/DUT/CPU/DP/pcstall
add wave -noupdate -group DP_Local /system_tb/DUT/CPU/DP/temp_wdat
add wave -noupdate -group DP_Local /system_tb/DUT/CPU/DP/pc_inc
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/exif/rdat1_in
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/exif/rdat1_out
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/exif/rdat2_in
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/exif/rdat2_out
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/exif/daddr_in
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/exif/daddr_out
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/exif/zero_flag_in
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/exif/zero_flag_out
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/exif/branch_in
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/exif/branch_out
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/exif/jump_in
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/exif/jump_out
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/exif/wsel_in
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/exif/wsel_out
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/exif/pc_next_in
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/exif/pc_next_out
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/exif/extended_value_in
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/exif/extended_value_out
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/exif/halt_in
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/exif/halt_out
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/exif/dWEN_in
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/exif/dWEN_out
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/exif/dREN_in
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/exif/dREN_out
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/exif/RegWrite_in
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/exif/RegWrite_out
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/exif/MemToReg_in
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/exif/MemToReg_out
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/exif/op_in
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/exif/op_out
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/exif/RegDest_in
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/exif/RegDest_out
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/exif/inst_in
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/exif/inst_out
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/exif/nop
add wave -noupdate -group EXMEM /system_tb/DUT/CPU/DP/exif/enable
add wave -noupdate -group MEMWB /system_tb/DUT/CPU/DP/meif/daddr_in
add wave -noupdate -group MEMWB /system_tb/DUT/CPU/DP/meif/daddr_out
add wave -noupdate -group MEMWB /system_tb/DUT/CPU/DP/meif/jump_in
add wave -noupdate -group MEMWB /system_tb/DUT/CPU/DP/meif/jump_out
add wave -noupdate -group MEMWB /system_tb/DUT/CPU/DP/meif/wsel_in
add wave -noupdate -group MEMWB /system_tb/DUT/CPU/DP/meif/wsel_out
add wave -noupdate -group MEMWB /system_tb/DUT/CPU/DP/meif/pc_next_in
add wave -noupdate -group MEMWB /system_tb/DUT/CPU/DP/meif/pc_next_out
add wave -noupdate -group MEMWB /system_tb/DUT/CPU/DP/meif/halt_in
add wave -noupdate -group MEMWB /system_tb/DUT/CPU/DP/meif/halt_out
add wave -noupdate -group MEMWB /system_tb/DUT/CPU/DP/meif/RegWrite_in
add wave -noupdate -group MEMWB /system_tb/DUT/CPU/DP/meif/RegWrite_out
add wave -noupdate -group MEMWB /system_tb/DUT/CPU/DP/meif/MemToReg_in
add wave -noupdate -group MEMWB /system_tb/DUT/CPU/DP/meif/MemToReg_out
add wave -noupdate -group MEMWB /system_tb/DUT/CPU/DP/meif/op_in
add wave -noupdate -group MEMWB /system_tb/DUT/CPU/DP/meif/op_out
add wave -noupdate -group MEMWB /system_tb/DUT/CPU/DP/meif/RegDest_in
add wave -noupdate -group MEMWB /system_tb/DUT/CPU/DP/meif/RegDest_out
add wave -noupdate -group MEMWB /system_tb/DUT/CPU/DP/meif/inst_in
add wave -noupdate -group MEMWB /system_tb/DUT/CPU/DP/meif/inst_out
add wave -noupdate -group MEMWB /system_tb/DUT/CPU/DP/meif/dmemload_in
add wave -noupdate -group MEMWB /system_tb/DUT/CPU/DP/meif/dmemload_out
add wave -noupdate -group MEMWB /system_tb/DUT/CPU/DP/meif/nop
add wave -noupdate -group MEMWB /system_tb/DUT/CPU/DP/meif/enable
add wave -noupdate -group CU /system_tb/DUT/CPU/DP/cuif/rfunc
add wave -noupdate -group CU /system_tb/DUT/CPU/DP/cuif/op
add wave -noupdate -group CU /system_tb/DUT/CPU/DP/cuif/ALUOp
add wave -noupdate -group CU /system_tb/DUT/CPU/DP/cuif/RegDst
add wave -noupdate -group CU /system_tb/DUT/CPU/DP/cuif/Branch
add wave -noupdate -group CU /system_tb/DUT/CPU/DP/cuif/iREN
add wave -noupdate -group CU /system_tb/DUT/CPU/DP/cuif/MemToReg
add wave -noupdate -group CU /system_tb/DUT/CPU/DP/cuif/dREN
add wave -noupdate -group CU /system_tb/DUT/CPU/DP/cuif/dWEN
add wave -noupdate -group CU /system_tb/DUT/CPU/DP/cuif/ALUSrc
add wave -noupdate -group CU /system_tb/DUT/CPU/DP/cuif/RegWrite
add wave -noupdate -group CU /system_tb/DUT/CPU/DP/cuif/Jump
add wave -noupdate -group CU /system_tb/DUT/CPU/DP/cuif/extender
add wave -noupdate -group CU /system_tb/DUT/CPU/DP/cuif/overflow_flag
add wave -noupdate -group CU /system_tb/DUT/CPU/DP/cuif/halt
add wave -noupdate -group CU /system_tb/DUT/CPU/DP/cuif/shamt
add wave -noupdate -group CU /system_tb/DUT/CPU/DP/cuif/lui
add wave -noupdate -group CU /system_tb/DUT/CPU/DP/cuif/inst
add wave -noupdate -group CU /system_tb/DUT/CPU/DP/cuif/shamt_value
add wave -noupdate -group RAMIF /system_tb/DUT/RAM/ramif/ramREN
add wave -noupdate -group RAMIF /system_tb/DUT/RAM/ramif/ramWEN
add wave -noupdate -group RAMIF /system_tb/DUT/RAM/ramif/ramaddr
add wave -noupdate -group RAMIF /system_tb/DUT/RAM/ramif/ramstore
add wave -noupdate -group RAMIF /system_tb/DUT/RAM/ramif/ramload
add wave -noupdate -group RAMIF /system_tb/DUT/RAM/ramif/ramstate
add wave -noupdate -group RAMIF /system_tb/DUT/RAM/ramif/memREN
add wave -noupdate -group RAMIF /system_tb/DUT/RAM/ramif/memWEN
add wave -noupdate -group RAMIF /system_tb/DUT/RAM/ramif/memaddr
add wave -noupdate -group RAMIF /system_tb/DUT/RAM/ramif/memstore
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -expand /system_tb/DUT/CPU/DP/RF/register
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1747459 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 191
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
WaveRestoreZoom {0 ps} {2908 ns}
