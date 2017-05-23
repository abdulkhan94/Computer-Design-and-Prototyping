`ifndef IDEX_IF_VH
`define IDEX_IF_VH
`include "cpu_types_pkg.vh"

interface idex_if;
  import cpu_types_pkg::*;

  //Inputs
  word_t extended_value_in, extended_value_out;
  word_t inst_in, inst_out;
  word_t rdat1_in, rdat1_out;
  word_t rdat2_in, rdat2_out;
  word_t pc_next_in, pc_next_out;
  logic lui_in, lui_out;
  word_t lui_value_in, lui_value_out;
  logic branch_in, branch_out;
  logic [1:0] jump_in, jump_out;
  logic MemToReg_in, MemToReg_out;
  word_t shamt_value_in, shamt_value_out; 
  logic shamt_in, shamt_out; //Control Signal for ALU Port B
  logic ALUSrc_in, ALUSrc_out; //Control Signal for ALU Port B
  //logic addr_in, addr_out;
  logic RegDst_in, RegDst_out;
  aluop_t ALUOp_in, ALUOp_out;
  logic halt_in, halt_out;
  logic dWEN_in, dWEN_out;
  logic dREN_in, dREN_out;
  logic RegWrite_in, RegWrite_out;
  opcode_t op_in, op_out;
  logic nop, enable;
  //MIGHT NEED TO ADD CURRENT PC which is addr in this case

  modport idd (
    input extended_value_in, inst_in, rdat1_in, rdat2_in, pc_next_in, lui_in, lui_value_in, branch_in, jump_in, MemToReg_in, shamt_value_in, shamt_in, ALUSrc_in, RegDst_in, ALUOp_in, halt_in, dWEN_in, dREN_in, RegWrite_in, op_in, nop, enable,   
    output extended_value_out, inst_out, rdat1_out, rdat2_out, pc_next_out, lui_out, lui_value_out, branch_out, jump_out, MemToReg_out, shamt_value_out, shamt_out, ALUSrc_out, RegDst_out, ALUOp_out, halt_out, dWEN_out, dREN_out, RegWrite_out, op_out);

endinterface
`endif
