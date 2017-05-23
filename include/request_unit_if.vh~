`ifndef REQUEST_UNIT_IF_VH
`define REQUEST_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface request_unit_if;
  // import types
  import cpu_types_pkg::*;

  //Inputs
  logic dhit, ihit, halt;
  logic dWEN, dREN;

  //Outputs
  logic dmemWEN, dmemREN;
  logic pc_en;
  // request unit ports
  modport ru(
    input   dhit, ihit, halt, dWEN, dREN, 
    output  dmemWEN, dmemREN, pc_en);

  modport tb(
    input dmemWEN, dmemREN, pc_en,
    output dhit, halt, ihit, dWEN, dREN);

endinterface

`endif //REQUEST_UNIT_IF_VH

