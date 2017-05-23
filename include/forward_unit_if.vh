`ifndef FORWARD_UNIT_IF_VH
`define FORWARD_UNIT_IF_VH

`include "cpu_types_pkg.vh"

interface forward_unit_if;
  import cpu_types_pkg::*;

  //inputs
  //logic r_done, lw_done; //DO I NEED THESE
  logic [4:0] idex_rs_out, idex_rt_out;

  regbits_t exmem_wsel_out;
  regbits_t memwb_wsel_out;
  logic exmem_RegWrite_out, memwb_RegWrite_out;


  //Outputs
  logic [1:0] forwardA, forwardB;

 modport fu(
	input idex_rs_out, idex_rt_out, exmem_wsel_out, memwb_wsel_out, exmem_RegWrite_out, memwb_RegWrite_out,
	output forwardA, forwardB
  );

endinterface
`endif
