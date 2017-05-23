// mapped needs this
`include "request_unit_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module request_unit_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  request_unit_if ruif ();
  // test program
  test PROG (CLK, nRST, ruif);
  // DUT
`ifndef MAPPED
  request_unit DUT(CLK, nRST, ruif);
`else
  request_unit DUT(
    .\ruif.dhit (ruif.dhit),
    .\ruif.ihit (ruif.ihit),
    .\ruif.halt (ruif.halt),
    .\ruif.dWEN (ruif.dWEN),
    .\ruif.dREN (ruif.dREN),
    .\ruif.dmemWEN (ruif.dmemWEN),
    .\ruif.dmemREN (ruif.dmemREN),
    .\ruif.pc_en (ruif.pc_en)
  );
`endif

endmodule

program test(
	input logic CLK, nRST,
	request_unit_if.tb ruif_tb
);

initial
begin
	`include "cpu_types_pkg.vh"
	logic testcase;
	import cpu_types_pkg::*;
        parameter PERIOD = 10;

	ruif.dhit=0;
	ruif.ihit=0;
	ruif.halt=0;
	ruif.dWEN = 0;
	ruif.dREN=0;
	

	#(PERIOD * 2);
	ruif.dREN=1;
	ruif.dWEN=1;
	ruif.ihit =1;

	#(PERIOD * 2);
	ruif.ihit=0;
	ruif.dhit =1;

	#(PERIOD*2);
	


end

endprogram

