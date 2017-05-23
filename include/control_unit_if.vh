`ifndef CONTROL_UNIT_IF_VH
`define CONTROL_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface control_unit_if;
  // import types
  import cpu_types_pkg::*;

  //R-type Instructions
  funct_t rfunc;

  //Other Instructions
  opcode_t op;
  aluop_t ALUOp;
  //word_t instruction;  

  //Output Signals
  logic RegDst, Branch, iREN, MemToReg, dREN, dWEN, ALUSrc,RegWrite;  
  logic [1:0] Jump;

  //Signals Not sure about
  logic extender; 
  logic overflow_flag;
  logic halt;
  logic shamt;
  //logic [15:0] immediate;
  logic lui;
  word_t inst;

  word_t shamt_value;
  // Control Unit file ports
  modport cu(
    input inst, rfunc, op, 
    output RegDst, Jump, Branch, MemToReg, ALUOp, ALUSrc, RegWrite, iREN, dREN, dWEN, halt, extender, shamt, lui, shamt_value
  );

  modport tb(
    input RegDst, Jump, Branch, MemToReg, ALUOp, ALUSrc, RegWrite, iREN, dREN, dWEN, halt, extender, shamt, lui, shamt_value,

    output inst, rfunc, op
);

endinterface

`endif //ALU_IF_VH
