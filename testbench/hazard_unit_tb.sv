// mapped needs this
`include "hazard_unit_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module hazard_unit_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  hazard_unit_if huif ();
  // test program
  test PROG (huif);
  // DUT
`ifndef MAPPED
  hazard_unit_if DUT();
`endif

endmodule

program test(
	hazard_unit_if.tb huif_tb
);

initial
begin
	`include "cpu_types_pkg.vh"
	logic testcase;
	import cpu_types_pkg::*;
        parameter PERIOD = 10;

   
	//Test Cases begin here
	#(PERIOD);
	testcase = 1; //Shouldn't stall anything
	huif_tb.ihit = 0;
	huif_tb.dhit = 0;
  	huif_tb.ifid_rs = 5'b00000;
  	huif.idex_out_wsel = 5'b00000;
 
  	#(PERIOD);
	testcase = 2; //Should stall - RAW Hazard Mem Stage
  	huif_tb.ihit = 1;
  	huif_tb.dhit = 0;
  	huif_tb.ifid_rt = 5'b00001;
  	huif_tb.exmem_out_wsel = 5'b00001;
  
	#(PERIOD);
	testcase = 3; //dHit case
  	huif_tb.ihit = 0;
  	huif_tb.dhit = 1;
  	huif_tb.ifid_rt = 5'b00000;
  	huif_tb.exmem_out_wsel = 5'b00000;

  	#(PERIOD);
	testcase = 4; //Should stall - RAW Hazard EX Stage
  	huif_tb.ihit = 1;
  	huif_tb.dhit = 0;
  	huif_tb.ifid_rt = 5'b00100;
  	huif_tb.idex_out_wsel = 5'b00100;

  	#(PERIOD);
	testcase = 5; //No hazard
  	huif_tb.ihit = 1;
  	huif_tb.dhit = 0;
  	huif_tb.ifid_rt = 5'b00100;
  	huif_tb.idex_out_wsel = 5'b00100;

 	#(PERIOD);

	$finish;

end

endprogram
