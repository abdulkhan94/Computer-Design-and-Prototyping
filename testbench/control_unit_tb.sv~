// mapped needs this
`include "control_unit_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module control_unit_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  control_unit_if cuif ();
  // test program
  test PROG (CLK, nRST, cuif);
  // DUT
`ifndef MAPPED
  control_unit DUT(CLK, nRST, cuif);
`else
  request_unit DUT(
    .\cuif.rfunc (cuif.rfunc),
    .\cuif.op (cuif.op),
    .\cuif.instruction (cuif.instruction),
    .\cuif.RegDst (cuif.RegDst),
    .\cuif.Jump (cuif.Jump),
    .\cuif.Branch (cuif.Branch),
    .\cuif.MemToReg (cuif.MemToReg),
    .\cuif.ALUOp (cuifcuif.ALUOp),
    .\cuif.ALUSrc (cuif.ALUSrc),
    .\cuif.RegWrite (cuif.RegWrite),
    .\cuif.iREN (cuif.iREN),
    .\cuif.dREN (cuif.dREN),
    .\cuif.dWEN (cuif.dWEN),
    .\cuif.halt (cuif.halt),
    .\cuif.extender (cuif.extender),
    .\cuif.shamt (cuif.shamt),
    .\cuif.immediate (cuif.immediate)
  );
`endif

endmodule

program test(
	input logic CLK, nRST,
	control_unit_if.tb cuif_tb
);

initial
begin
	`include "cpu_types_pkg.vh"
	logic testcase;
	import cpu_types_pkg::*;
        parameter PERIOD = 10;
	
	@(posedge CLK);
	




end

endprogram


