`include "register_file_if.vh"
`include "cpu_types_pkg.vh"

import cpu_types_pkg::*;


module register_file(input logic CLK, nRst, register_file_if.rf rfif);

   word_t register [31:0];

   always_ff @ (negedge CLK, negedge nRst) begin
      if(!nRst) begin
	 register <= '{default:'0};
      end
      else if (rfif.WEN) begin
	 register[rfif.wsel]<= rfif.wdat;
      end
   end


   always_comb begin
      if(rfif.rsel1) begin
	 rfif.rdat1=register[rfif.rsel1];
      end
      else begin
	 rfif.rdat1=0;
      end

      if(rfif.rsel2) begin
	 rfif.rdat2=register[rfif.rsel2];
      end
      else begin
	 rfif.rdat2=0;
	 
      end

   end // always_comb

endmodule
