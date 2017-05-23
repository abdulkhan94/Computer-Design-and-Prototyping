//Mapped needs this
`include "cache_control_if.vh"
`include "cpu_ram_if.vh"
`include "cpu_types_pkg.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module memory_control_tb;
  parameter PERIOD = 10;
  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  caches_if cif0();
  caches_if cif1();
  cache_control_if #(.CPUS(2)) ccif(cif0, cif1);

  cpu_ram_if crif();
  ram RAM (CLK, nRST, crif);
  test PROG(CLK, nRST, ccif);

  `ifndef MAPPED
    memory_control DUT(CLK, nRST, ccif);
  `else
   memory_control DUT(CLK, nRST, ccif);
		     /* .\ccif.iREN(ccif.iREN),
		      .\ccif.dREN(ccif.dREN),
		      .\ccif.dWEN(ccif.dWEN),
		      .\ccif.dstore(ccif.dstore),
		      .\ccif.iaddr(ccif.iaddr),
		      .\ccif.daddr(ccif.daddr),
		      .\ccif.ramload(ccif.ramload),
		      .\ccif.ramstate(ccif.ramstate),
		      .\ccif.ccwrite(ccif.ccwrite),
		      .\ccif.cctrans(ccif.cctrans),
		      .\ccif.iwait(ccif.iwait),
		      .\ccif.dwait(ccif.dwait),
		      .\ccif.iload(ccif.iload),
		      .\ccif.dload(ccif.dload),
		      .\ccif.ramstore(ccif.ramstore),
		      .\ccif.ramaddr(ccif.ramaddr),
		      .\ccif.ramWEN(ccif.ramWEN),
		      .\ccif.ramREN(ccif.ramREN),
		      .\ccif.ccwait(ccif.ccwait),
		      .\ccif.ccinv(ccif.ccinv),
		      .\ccif.ccsnoopaddr(ccif.ccsnoopaddr)
		      );*/
      
   
  `endif  

	assign crif.ramaddr = ccif.ramaddr;
	assign crif.ramREN = ccif.ramREN;
	assign crif.ramWEN = ccif.ramWEN;
	assign crif.ramstore = ccif.ramstore;

        //assign ccif.ramstate = crif.ramstate;
	//assign ccif.ramload = crif.ramload;
endmodule

program test (input logic CLK, output logic nRST, cache_control_if ccif);

	import cpu_types_pkg::*;
        parameter PERIOD = 10;
	int testcase;

initial
begin
	@(negedge CLK)

	nRST = 0;
	#(PERIOD);	
	nRST = 1;

	//TESTCASE 1 //Service source 0 & snoop source 1
	testcase = 1;
	cif1.cctrans = 0;
	cif0.cctrans = 1;

	cif0.daddr = 32'hDEADBEEF;

	//#(PERIOD*2);
	cif1.ccwrite = 1;
	cif1.dstore = 32'hBAD1BAD1;
	cif0.ccwrite = 0;
	#(PERIOD*2);
	ccif.ramstate = ACCESS;
	
	#(PERIOD*2);

	//TESTCASE 2 // Collision case - should pick source 0
	testcase = 2;
	nRST = 0;
	#(PERIOD*2);
	nRST = 1;
	cif1.cctrans = 1;
	cif0.cctrans = 1;
	cif0.daddr = 32'hBABA;
	cif1.ccwrite = 1;
	cif1.dstore = 32'hDADA;
	cif0.ccwrite = 1;
	#(PERIOD*2);
	ccif.ramstate = ACCESS;
	#(PERIOD*2);

	//TESTCASE 3 // Load from memory
	testcase = 3;
	nRST = 0;
	#(PERIOD*2);
	nRST = 1;
	cif1.cctrans = 0;
	cif0.cctrans = 1;
	#(PERIOD);
	cif1.daddr = 32'hBAABAA;
	cif1.ccwrite = 0;
	#(PERIOD);
	ccif.ramstate = ACCESS;
	cif0.daddr = 32'hDEADDEAD;
	ccif.ramload = 32'hBEEBBEEB;
	cif0.ccwrite = 0;
	#(PERIOD*2);
		
	//TESTCASE 4 //Instruction Fetch
	testcase = 4;
	cif1.cctrans = 0;
	cif0.cctrans = 0;
	nRST = 0;
	#(PERIOD*2);
	nRST = 1;
	#(PERIOD*2);

	cif0.iREN = 1;
	cif1.iREN = 0;
	ccif.ramstate = BUSY;
	#(PERIOD);
	ccif.ramload = 32'hDEADBEEF;
	cif0.iaddr = 32'hBAABBAAB;
	cif0.iREN = 0;
	#(PERIOD);
	ccif.ramstate = ACCESS;
	cif0.iREN = 0;
	#(PERIOD);

/*	cif0.iREN = 0;
	cif0.iaddr = 0;
	cif0.dWEN = 0;
	cif0.dREN = 0;
	cif0.daddr = 0;

	#(PERIOD*3);

	nRST = 1;
	cif0.iREN = 0;
	cif0.iaddr = 0;
	cif0.dWEN = 1;
	cif0.dREN = 0;
	cif0.daddr = 32'hBAD2BAD2;
        cif0.dstore = 32'hBEEFDEAD;
   
	ccif.ramload = crif.ramload;
	#(PERIOD * 2);

	cif0.iREN = 0;
	cif0.iaddr = 0;
	cif0.dWEN = 0;
	cif0.dREN = 1;
	cif0.daddr = 32'hBAD2BAD2;
	ccif.ramload = crif.ramload;
	#(PERIOD * 2);

	cif0.iREN = 0;
	cif0.iaddr = 0;
	cif0.dWEN = 1;
	cif0.dREN = 0;
	cif0.daddr = 1;
	ccif.ramload = crif.ramload;
	#(PERIOD * 2);



	//iREN and dREN asserted at the same time
	cif0.iREN = 1;
	cif0.iaddr = 0;
	cif0.dWEN = 0;
	cif0.dREN = 1;
	cif0.daddr = 1;
	ccif.ramload = crif.ramload;
	#(PERIOD * 2);

	cif0.iREN = 1;
	cif0.iaddr = 32'hBAD2BAD2;
	cif0.dWEN = 0;
	cif0.dREN = 0;
	cif0.daddr = 1;
	ccif.ramload = crif.ramload;
	#(PERIOD * 2);
	

        
   	dump_memory(); */
   

end
/*
  task automatic dump_memory();
    string filename = "memcpu.hex";
    int memfd;

    //cif0.tbCTRL = 1;
    cif0.daddr = 0;
    cif0.dWEN = 0;
    cif0.dREN = 0;

    memfd = $fopen(filename,"w");
    if (memfd)
      $display("Starting memory dump.");
    else
      begin $display("Failed to open %s.",filename); $finish; end

    for (int unsigned i = 0; memfd && i < 16384; i++)
    begin
      int chksum = 0;
      bit [7:0][7:0] values;
      string ihex;

      cif0.daddr = i << 2;
      cif0.dREN = 1;
      repeat (4) @(posedge CLK);
      if (cif0.dload === 0)
        continue;
      values = {8'h04,16'(i),8'h00,cif0.dload};
      foreach (values[j])
        chksum += values[j];
      chksum = 16'h100 - chksum;
      ihex = $sformatf(":04%h00%h%h",16'(i),cif0.dload,8'(chksum));
      $fdisplay(memfd,"%s",ihex.toupper());
    end //for
    if (memfd)
    begin
      //cif0.tbCTRL = 0;
      cif0.dREN = 0;
      $fdisplay(memfd,":00000001FF");
      $fclose(memfd);
      $display("Finished memory dump.");
    end
  endtask
*/
   
endprogram




   






