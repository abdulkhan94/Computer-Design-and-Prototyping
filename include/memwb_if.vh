`ifndef MEMWB_IF_VH
`define MEMWB_IF_VH
`include "cpu_types_pkg.vh"

interface memwb_if;
  import cpu_types_pkg::*;

  //Inputs from Instruction & Program Counter
  word_t daddr_in, daddr_out;
  logic [1:0] jump_in, jump_out;
  regbits_t wsel_in, wsel_out;
  word_t pc_next_in, pc_next_out;
  logic halt_in, halt_out;
  logic RegWrite_in, RegWrite_out;
  logic MemToReg_in, MemToReg_out;
  opcode_t op_in, op_out;
  logic RegDest_in, RegDest_out;
  word_t inst_in, inst_out;
  word_t dmemload_in, dmemload_out;
  logic nop, enable;
  word_t wdat_in, wdat_out;

  //DONT FORGET TO DEAL WITH ADDR SIGNAL WHICH IS CURR PC BROOOO
  modport mem(
    input daddr_in, jump_in, wsel_in, pc_next_in, halt_in, RegWrite_in, MemToReg_in, op_in, RegDest_in, inst_in, dmemload_in, nop, enable, wdat_in,
    output daddr_out, jump_out, wsel_out, pc_next_out, halt_out, RegWrite_out, MemToReg_out, op_out, RegDest_out, inst_out, dmemload_out, wdat_out);

endinterface
`endif
