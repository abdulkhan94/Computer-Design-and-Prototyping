`ifndef HAZARD_UNIT_IF_VH
`define HAZARD_UNIT_IF_VH

`include "cpu_types_pkg.vh"

interface hazard_unit_if;
  import cpu_types_pkg::*;

  //inputs
  logic dhit, ihit;

  //Register signals for pipes
  logic [4:0] ifid_rs, ifid_rt;

  //Opcodes for pipes
  opcode_t exmem_op;
  //funct_t ifid_func, idex_func, exmem_func, memwb_func;
  logic [1:0] exmem_jump;
  //Outputs
  logic ifid_enable, idex_enable, exmem_enable, memwb_enable; //Enable signals
  logic ifid_nop, idex_nop, exmem_nop, memwb_nop; //No operation signals
  logic pcstall;

  //Outputs used by Forwarding unit will need for Lab 7
  //logic r_done;
  //logic lw_done;

  logic WEN, REN;

  regbits_t idex_out_wsel;
  regbits_t exmem_out_wsel;

  //Unsure signals
  logic exmem_branch; //Will use this with zero flag to rec branch 
  logic zero_flag;
  logic halt;


 modport hu(
	input dhit, ihit, exmem_branch, ifid_rs, ifid_rt, exmem_op, exmem_jump, idex_out_wsel, exmem_out_wsel, zero_flag, halt, REN, WEN,  
	output ifid_enable, idex_enable, exmem_enable, memwb_enable, ifid_nop, idex_nop, exmem_nop, memwb_nop, pcstall);
 modport tb(
	input ifid_enable, idex_enable, exmem_enable, memwb_enable, ifid_nop, idex_nop, exmem_nop, memwb_nop, pcstall,
	output dhit, ihit, exmem_branch, ifid_rs, ifid_rt, exmem_op, exmem_jump, idex_out_wsel, exmem_out_wsel, zero_flag, halt, REN, WEN);

endinterface
`endif
