`ifndef ALU_IF_VH
`define ALU_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface alu_if;
  // import types
  import cpu_types_pkg::*;
    aluop_t aluop;
    word_t portA, portB, outport;
    logic negative_flag, zero_flag, overflow_flag;
  

  // ALU file ports
  modport alu (
    input   portA, portB, aluop,

    output  negative_flag, zero_flag, overflow_flag, outport
  );


   modport tb(
      output  portA, portB, aluop,
	      
      input negative_flag, zero_flag, overflow_flag, outport
    );
   

endinterface

`endif //ALU_IF_VH
