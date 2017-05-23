// interface include
`include "request_unit_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module request_unit(
  input CLK, nRST,
  request_unit_if.ru ruif
);
  // type import
  import cpu_types_pkg::*;
   
  assign ruif.pc_en = ruif.ihit; //Not sure about this
    
  always_ff @ (posedge CLK, negedge nRST) begin
	if(!nRST) begin
		ruif.dmemREN <= 1'b0;
		ruif.dmemWEN <= 1'b0;
	end
	else begin
		if(ruif.dhit) begin
			ruif.dmemREN <= 1'b0;
			ruif.dmemWEN <= 1'b0;
		end
		/*else if(ruif.halt) begin
			ruif.dmemREN <= 1'b0;
			ruif.dmemWEN <= 1'b0;
		end*/
		else if(ruif.ihit) begin
			ruif.dmemREN <= ruif.dREN;
			ruif.dmemWEN <= ruif.dWEN;
		end
	end // else: !if(!nRST)
  end // always_ff @ (posedge CLK, negedge nRST)

endmodule // request_unit

     

