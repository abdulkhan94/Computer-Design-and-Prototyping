// interface include
`include "exmem_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module exmem(
	input logic CLK, nRST,
	exmem_if.exx exif);

  import cpu_types_pkg::*;

always_ff @ (posedge CLK, negedge nRST) begin
  if(!nRST) begin
	exif.rdat1_out <= '0;
	exif.rdat2_out <= '0;
	exif.daddr_out <= '0;
	exif.zero_flag_out <= '0;
	exif.branch_out <= '0;
	exif.jump_out <= '0;
	exif.wsel_out <= '0;
	exif.pc_next_out <= '0;
	exif.extended_value_out <= '0;
	exif.jump_out <= '0;
	exif.halt_out <= '0;
	exif.dWEN_out <= '0;
	exif.dREN_out <= '0;	
	exif.RegWrite_out <= '0;
	exif.MemToReg_out <= '0;
	exif.op_out <= RTYPE;
	exif.RegDest_out <= '0;
	exif.inst_out <= '0;
  end 
  else if(exif.nop) begin
	exif.rdat1_out <= '0;
	exif.rdat2_out <= '0;
	exif.daddr_out <= '0;
	exif.zero_flag_out <= '0;
	exif.branch_out <= '0;
	exif.jump_out <= '0;
	exif.wsel_out <= '0;
	exif.pc_next_out <= '0;
	exif.extended_value_out <= '0;
	exif.jump_out <= '0;
	exif.halt_out <= '0;
	exif.dWEN_out <= '0;
	exif.dREN_out <= '0;	
	exif.RegWrite_out <= '0;
	exif.MemToReg_out <= '0;
	exif.op_out <= RTYPE;
	exif.RegDest_out <= '0;
	exif.inst_out <= '0;
  end
  else begin
    if (exif.enable) begin
	exif.rdat1_out <= exif.rdat1_in;
	exif.rdat2_out <= exif.rdat2_in;
	exif.daddr_out <= exif.daddr_in;
	exif.zero_flag_out <= exif.zero_flag_in;
	exif.branch_out <= exif.branch_in;
	exif.jump_out <= exif.jump_in;
	exif.wsel_out <= exif.wsel_in;
	exif.pc_next_out <= exif.pc_next_in;
	exif.extended_value_out <= exif.extended_value_in;
	exif.jump_out <= exif.jump_in;
	exif.halt_out <= exif.halt_in;
	exif.dWEN_out <= exif.dWEN_in;
	exif.dREN_out <= exif.dREN_in;	
	exif.RegWrite_out <= exif.RegWrite_in;
	exif.MemToReg_out <= exif.MemToReg_in;
	exif.op_out <= exif.op_in;
	exif.RegDest_out <= exif.RegDest_in;
	exif.inst_out <= exif.inst_in;
    end
  end
end

endmodule
