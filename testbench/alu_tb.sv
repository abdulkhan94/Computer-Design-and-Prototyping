// mapped needs this
`include "alu_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module alu_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  alu_if aluif ();
  // test program
  test PROG (aluif);
  // DUT
`ifndef MAPPED
  alu DUT(aluif);
`else
  alu DUT(
    .\aluopc.portA (aluif.portA),
    .\aluopc.portB (aluif.portB),
    .\aluopc.aluop (aluif.aluop),
    .\aluopc.negative_flag (aluif.negative_flag),
    .\aluopc.zero_flag (aluif.zero_flag),
    .\aluopc.overflow_flag (aluif.overflow_flag),
    .\aluopc.outport (aluif.outport)
  );
`endif

endmodule

program test(
	alu_if.tb aluif_tb
);

initial
begin
	`include "cpu_types_pkg.vh"
	logic testcase;
	import cpu_types_pkg::*;
        parameter PERIOD = 10;

   
	//Test Cases begin here
	testcase =1;
	aluif_tb.aluop= ALU_ADD;
	aluif_tb.portA= 4;
	aluif_tb.portB= 4;
	
	#(PERIOD)

	testcase =2;
	aluif_tb.aluop= ALU_SUB;
	aluif_tb.portA= 9;
	aluif_tb.portB= 4;	

	#(PERIOD)

	testcase =3;
	aluif_tb.aluop= ALU_AND;
	aluif_tb.portA= 1;
	aluif_tb.portB= 1;	

	#(PERIOD)
	testcase =4;
	aluif_tb.aluop= ALU_OR;
	aluif_tb.portA= 9;
	aluif_tb.portB= 0;	

	#(PERIOD)
	testcase = 5;
	aluif_tb.aluop= ALU_XOR;
	aluif_tb.portA= 9;
	aluif_tb.portB= 0;	

	#(PERIOD)
	testcase = 6;
	aluif_tb.aluop= ALU_NOR;
	aluif_tb.portA= 0;
	aluif_tb.portB= 0;

	#(PERIOD)
	testcase =7;
	aluif_tb.aluop= ALU_SLT;
	aluif_tb.portA= 1;
	aluif_tb.portB= 0;


   
	#(PERIOD)
	testcase=8;
	aluif_tb.aluop= ALU_SRL;
	aluif_tb.portA= 2;
	aluif_tb.portB= 3;

	#(PERIOD)
	testcase =9;
	aluif_tb.aluop= ALU_ADD;
	aluif_tb.portA= 1111111111;
	aluif_tb.portB= 111111111;		

	#(PERIOD)
	testcase =10;
	aluif_tb.aluop= ALU_SLTU;
	aluif_tb.portA= 32'hffffffff;
	aluif_tb.portB= 0;

   	#(PERIOD)
	$finish;


end

endprogram

