// mapped needs this
`include "datapath_cache_if.vh"
`include "cache_control_if.vh"
`include "cpu_ram_if.vh"
`include "cpu_types_pkg.vh"
`include "caches_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module dcache_tb;
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
  dcache DUT(CLK, nRST, dcif, ccif);
`else
  dcache DUT(CLK, nRST, dcif, ccif);
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
	datapath_cache_if.dctb dcif, caches_if.dctb ccif
);
	import cpu_types_pkg::*;
        parameter PERIOD = 10;
	int testcase;

initial
begin
	/* Inputs
        DCIF   halt, dmemREN, dmemWEN,
                datomic, dmemstore, dmemaddr,


	CCIF	dwait, dload,
            	ccwait, ccinv, ccsnoopaddr,	
	*/


	nRST = 0;
	#(PERIOD*2);

	testcase = 1; //Compulsory miss - writes to table
	nRST = 1;
	dcif.dmemREN =1;
	dcif.dmemaddr = 32'hBEEF;
	ccif.dwait = 0;
	ccif.dload = 32'hDEAD;

	#(PERIOD*2);

	testcase = 2; //Compulsory miss - writes to table at another address
	dcif.dmemREN =1;
	dcif.dmemaddr = 32'hBABA;
	ccif.dwait = 0;
	ccif.dload = 32'hDADA;	

	#(PERIOD*2);

	testcase = 3; //reads from table to dmemload - gets hit
	dcif.dmemREN = 1;
	dcif.dmemaddr = 32'hBEEF;	


	#(PERIOD*2);
	ccif.ccwait = 1;
	ccif.ccsnoopaddr = 32'hBABA;
	
	#(PERIOD*2);
	ccif.dwait = 0; //Should be in SNOOPWB1

	#(PERIOD*2);
	ccif.dwait = 0; //Should be in SNOOPWB2

	#(PERIOD*2);
	ccif.ccwait = 0; //Back to IDLE after snooping
	
	#(PERIOD*2);
	nRST = 0;
	#(PERIOD*4);
	nRST = 1;
	testcase = 5;	//Goes to miss states and appropriate cc trans and ccwrite should be asserted
	dcif.dmemREN = 1;
	dcif.dmemaddr = 32'hBAA;
	
	#(PERIOD*2);
	ccif.dwait = 0;

	#(PERIOD*2);
	ccif.dwait = 0; //Goes through miss states and then back to IDLE

	#(PERIOD*2);
	
		
	
end

endprogram

