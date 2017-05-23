// mapped needs this
`include "datapath_cache_if.vh"
`include "cache_control_if.vh"
`include "cpu_ram_if.vh"
`include "cpu_types_pkg.vh"
`include "caches_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module icache_tb;
  parameter PERIOD = 10;
  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  caches_if ccif();
  datapath_cache_if dcif();

  // test program
  test PROG (CLK, nRST, dcif, ccif);
  // DUT
`ifndef MAPPED
  icache DUT(CLK, nRST, dcif, ccif);
`else
  icache DUT(CLK, nRST, dcif, ccif);
/*	.\CLK (CLK),
	.\nRST (nRST),
	.\dcif.imemREN(dcif.imemREN),
	.\dcif.imemaddr(dcif.imemaddr),
	.\dcif.ihit(dcif.ihit),
	.\dcif.imemload(dcif.imemload),
	.\ccif.iwait(ccif.iwait),
	.\ccif.iload(ccif.iload),
	.\ccif.iREN(ccif.iREN),
	.\ccif.iaddr(ccif.iaddr)
*/
`endif

endmodule

program test(
	input logic CLK, output logic nRST,
	datapath_cache_if.ictb dcif, caches_if.ictb ccif
);
	import cpu_types_pkg::*;
        parameter PERIOD = 10;
	int testcase;

initial
begin
	/* Inputs
	dcif.imemREN
	dcif.imemaddr
	ccif.iwait
	ccif.iload
	*/

	nRST = 0;
	#(PERIOD * 2);

	nRST = 0;
	#(PERIOD*2);

	nRST = 1;
	dcif.imemaddr = 32'hBEEF; //To show it waits for iREN

	#(PERIOD * 2);
	testcase = 1; //Write to cache table
	dcif.imemREN = 1;
	ccif.iwait = 0;
	ccif.iload = 32'hDEAD;
	#(PERIOD * 2);
	
	testcase = 2;
	dcif.imemaddr = 32'hBABA;
	dcif.imemREN = 1;
	ccif.iload = 32'hDADA;
	ccif.iwait = 0;

	#(PERIOD * 2);		

	testcase = 3; //To see if it can read from a location previously stored to
	dcif.imemaddr = 32'hBEEF;
	dcif.imemREN = 1;
	#(PERIOD * 2);	



end

endprogram

