/*
Abdullah Khan
mg258
*/

/*
	Corner case - no dcif.imemREN but dcif.iaddr given

*/

// interface include
`include "datapath_cache_if.vh"
`include "cache_control_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module icache(
  input CLK, nRST,
  datapath_cache_if.icache dcif, //.icache
  caches_if.icache ccif	//.icache
);
  // type import
  import cpu_types_pkg::*;

  //Struct for icache table
  typedef struct packed {
    logic [ITAG_W-1:0] tag;
    logic valid;
    word_t data;
  } ic_tab;

/*//Outputs
    datapath_cache	ihit, imemload
    cache_control	iREN, iaddr
*/

  //Current Instruction stream
  icachef_t inst;

  assign inst = icachef_t'(dcif.imemaddr);


  //Cache table 
  ic_tab [15:0] ic_table;

  //Datapath Cache
  assign dcif.ihit = ((ic_table[inst.idx].tag == inst.tag) && ic_table[inst.idx].valid);
  assign dcif.imemload = ic_table[inst.idx].data;

  //Cache Control
  assign ccif.iaddr = dcif.imemaddr; 
  assign ccif.iREN = dcif.imemREN && !dcif.ihit;

  //logic [5:0] i;

  //Rest of the conditions
  always_ff @ (posedge CLK, negedge nRST) begin
	if(!nRST) begin
		ic_table <= '0;
	end
	else begin
		if(dcif.imemREN && !(dcif.ihit)) begin
			if(!ccif.iwait) begin
				ic_table[inst.idx].valid <= 1;
			 	ic_table[inst.idx].data <= ccif.iload;
				ic_table[inst.idx].tag <= inst.tag; 
			end
		end
	end

  end
endmodule
