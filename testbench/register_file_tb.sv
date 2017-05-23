/*
  Eric Villasenor
  evillase@gmail.com

  register file test bench
*/

// mapped needs this
`include "register_file_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module register_file_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // test vars
  int v1 = 1;
  int v2 = 4721;
  int v3 = 25119;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  register_file_if rfif ();
  // test program
  test PROG (CLK, nRST, rfif);
  // DUT
`ifndef MAPPED
  register_file DUT(CLK, nRST, rfif);
`else
  register_file DUT(
    .\rfif.rdat2 (rfif.rdat2),
    .\rfif.rdat1 (rfif.rdat1),
    .\rfif.wdat (rfif.wdat),
    .\rfif.rsel2 (rfif.rsel2),
    .\rfif.rsel1 (rfif.rsel1),
    .\rfif.wsel (rfif.wsel),
    .\rfif.WEN (rfif.WEN),
    .\nRST (nRST),
    .\CLK (CLK)
  );
`endif

endmodule

program test(
    input logic CLK,
    output logic nRST,
    register_file_if.tb rf_tb
    );
    parameter PERIOD = 10;
    int testcase;
   
   
    initial begin
        rf_tb.WEN = 1;
        rf_tb.rsel1 = 0;
        rf_tb.rsel2 = 0;
        rf_tb.wdat = 12;
        rf_tb.wsel = 0;
        nRST = 1;

        #(PERIOD)
       //Test 1 - write 2 to register 0

	testcase=1;
        rf_tb.WEN = 1;
        rf_tb.rsel2 = 2;
        rf_tb.wdat = 2;
        rf_tb.wsel = 2;
        rf_tb.rsel1 = 0;
        nRST = 1;

        #(PERIOD)

	testcase=2; //Write 2 to reg 2

        rf_tb.rsel1 = 0;
        rf_tb.rsel2 = 2;
        rf_tb.wdat = 12;       
        rf_tb.WEN = 1;
        rf_tb.wsel = 2;
        nRST = 0;

        #(PERIOD)
	testcase=3; // Write 2 to reg 2 while nRst =1
        rf_tb.WEN = 0;
        rf_tb.rsel1 = 0;
        rf_tb.rsel2 = 0;
        rf_tb.wdat = 0;
        rf_tb.wsel = 0;
        nRST = 1;


       #(PERIOD)
       testcase=4;
       rf_tb.WEN=1;
       rf_tb.wsel=32'd25;
       rf_tb.wdat=32'd2;
       
   
       #(PERIOD)
       testcase=5;
       rf_tb.rsel1=32'd25;

    end
endprogram
