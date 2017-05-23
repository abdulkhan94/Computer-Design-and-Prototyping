// interface include
`include "memwb_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module memwb(
	input logic CLK, nRST,
	memwb_if.mem meif);
  import cpu_types_pkg::*;

always_ff @ (posedge CLK, negedge nRST) begin
  if(!nRST) begin
	meif.daddr_out <= '0;
	meif.jump_out <= '0;
	meif.wsel_out <= '0;
	meif.pc_next_out <= '0;
	meif.halt_out <= '0;
	meif.RegWrite_out <= '0;
	meif.MemToReg_out <= '0;
	meif.op_out <= RTYPE;
	meif.RegDest_out <= '0;
	meif.inst_out <= '0;
	meif.dmemload_out <= '0;
	meif.halt_out <= '0;
	meif.wdat_out <= '0;
  end 
  else if(meif.nop) begin
	meif.daddr_out <= '0;
	meif.jump_out <= '0;
	meif.wsel_out <= '0;
	meif.pc_next_out <= '0;
	meif.halt_out <= '0;
	meif.RegWrite_out <= '0;
	meif.MemToReg_out <= '0;
	meif.op_out <= RTYPE;
	meif.RegDest_out <= '0;
	meif.inst_out <= '0;
	meif.dmemload_out <= '0;
	meif.halt_out <= '0;
	meif.wdat_out <= '0;
  end
  else begin
    if (meif.enable) begin
	meif.daddr_out <= meif.daddr_in;
	meif.jump_out <= meif.jump_in;
	meif.wsel_out <= meif.wsel_in;
	meif.pc_next_out <= meif.pc_next_in;
	meif.halt_out <= meif.halt_in;
	meif.RegWrite_out <= meif.RegWrite_in;
	meif.MemToReg_out <= meif.MemToReg_in;
	meif.op_out <= meif.op_in;
	meif.RegDest_out <= meif.RegDest_in;
	meif.inst_out <= meif.inst_in;
	meif.dmemload_out <= meif.dmemload_in;
	meif.halt_out <= meif.halt_in;
	meif.wdat_out <= meif.wdat_in;
    end
  end
end

endmodule
