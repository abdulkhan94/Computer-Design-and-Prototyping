`ifndef PC_IF_VH
`define PC_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface pc_if;
  // import types
  import cpu_types_pkg::*;
  word_t pc_curr, pc_next;
  /*
  logic [1:0] jump_inst; // 01 = jump routine ; 10 = jump ; 11 = jump and link
  logic [25:0] instruction; 
  logic zero_flag; //zero flag from ALU
*/
 logic pc_en;
 modport progc(
	input pc_next, pc_en,
	output pc_curr 
  );

endinterface

`endif //PC_IF_VH
