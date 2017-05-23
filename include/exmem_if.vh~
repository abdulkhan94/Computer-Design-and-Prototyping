`ifndef EXMEM_IF_VH
`define EXMEM_IF_VH
`include "cpu_types_pkg.vh"

interface exmem_if;
  import cpu_types_pkg::*;

  //Inputs from Instruction & Program Counter
  word_t rdat1_in, rdat1_out;
  word_t rdat2_in, rdat2_out;
  word_t daddr_in, daddr_out; //NOT SURE daddr brooo
  logic zero_flag_in, zero_flag_out;
  logic branch_in, branch_out;
  logic [1:0] jump_in, jump_out;
  regbits_t wsel_in, wsel_out;
  word_t pc_next_in, pc_next_out;
  word_t extended_value_in, extended_value_out; //Need to left shift and add to npc for branch in next stage
  //logic [1:0] jump_in, jump_out;
  //word_t addr_in, addr_out; //This is curr pc maybe not sure yet b t will be req
  logic halt_in, halt_out;
  logic dWEN_in, dWEN_out;
  logic dREN_in, dREN_out;
  logic RegWrite_in, RegWrite_out;
  logic MemToReg_in, MemToReg_out;
  opcode_t op_in, op_out;
  logic RegDest_in, RegDest_out;
  word_t inst_in, inst_out;
  logic nop;
  logic enable;

  //DONT FORGET TO DEAL WITH ADDR SIGNAL WHICH IS CURR PC BROOOO
  modport exx(
    input rdat1_in, rdat2_in, daddr_in, zero_flag_in, branch_in, jump_in, wsel_in, pc_next_in, extended_value_in, halt_in, dWEN_in, dREN_in, RegWrite_in, MemToReg_in, op_in, RegDest_in, inst_in, nop, enable,
    output rdat1_out, rdat2_out, daddr_out, zero_flag_out, branch_out, jump_out, wsel_out, pc_next_out, extended_value_out, halt_out, dWEN_out, dREN_out, RegWrite_out, MemToReg_out, op_out, RegDest_out, inst_out);

endinterface
`endif
