
// interface include
`include "pc_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module pc(
  input CLK, nRST,
  pc_if.progc pcif
);
  parameter PC_INIT = 0;
  
  import cpu_types_pkg::*;
  
  always_ff @ (posedge CLK, negedge nRST) begin
	if(!nRST) begin
		pcif.pc_curr <= PC_INIT;
	end
	else begin
		if(pcif.pc_en) begin
			pcif.pc_curr <= pcif.pc_next;
		end
	end
  end


endmodule
  
