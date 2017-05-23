// interface include
`include "idex_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module idex(
	input logic CLK, nRST,
	idex_if.idd idex);

  import cpu_types_pkg::*;

always_ff @ (posedge CLK, negedge nRST) begin
  if(!nRST) begin
	idex.extended_value_out <= '0;
	idex.inst_out <= '0;
	idex.rdat1_out <= '0;
	idex.rdat2_out <= '0;
	idex.pc_next_out <= '0;
	idex.lui_out <= '0;
	idex.lui_value_out <= '0;
	idex.branch_out <= '0;
	idex.jump_out <= '0;
	idex.MemToReg_out <= '0;
	idex.shamt_value_out <= '0;
	idex.shamt_out <= '0;
	idex.ALUSrc_out <= '0;
	idex.RegDst_out <= '0;
	idex.ALUOp_out <= ALU_SLL;
	idex.halt_out <= '0;
	idex.dWEN_out <= '0;
	idex.dREN_out <= '0;
	idex.RegWrite_out <= '0;
        idex.op_out <= RTYPE; //NOT SURE WHAT THIS SHOULD BE INITIALIZED TO
     
  end 
  else if(idex.nop) begin
	idex.extended_value_out <= '0;
	idex.inst_out <= '0;
	idex.rdat1_out <= '0;
	idex.rdat2_out <= '0;
	idex.pc_next_out <= '0;
	idex.lui_out <= '0;
	idex.lui_value_out <= '0;
	idex.branch_out <= '0;
	idex.jump_out <= '0;
	idex.MemToReg_out <= '0;
	idex.shamt_value_out <= '0;
	idex.shamt_out <= '0;
	idex.ALUSrc_out <= '0;
	idex.RegDst_out <= '0;
	idex.ALUOp_out <= ALU_SLL;
	idex.halt_out <= '0;
	idex.dWEN_out <= '0;
	idex.dREN_out <= '0;
	idex.RegWrite_out <= '0;
        idex.op_out <= RTYPE;
  end
  else begin
    if (idex.enable) begin
	idex.extended_value_out <= idex.extended_value_in;
	idex.inst_out <= idex.inst_in;
	idex.rdat1_out <= idex.rdat1_in;
	idex.rdat2_out <= idex.rdat2_in;
	idex.pc_next_out <= idex.pc_next_in;
	idex.lui_out <= idex.lui_in;
	idex.lui_value_out <= idex.lui_value_in;
	idex.branch_out <= idex.branch_in;
	idex.jump_out <= idex.jump_in;
	idex.MemToReg_out <= idex.MemToReg_in;
	idex.shamt_value_out <= idex.shamt_value_in;
	idex.shamt_out <= idex.shamt_in;
	idex.ALUSrc_out <= idex.ALUSrc_in;
	idex.RegDst_out <= idex.RegDst_in;
	idex.ALUOp_out <= idex.ALUOp_in;
	idex.halt_out <= idex.halt_in;
	idex.dWEN_out <= idex.dWEN_in;
	idex.dREN_out <= idex.dREN_in;
	idex.RegWrite_out <= idex.RegWrite_in;
        idex.op_out <= idex.op_in;
    end
  end
end

endmodule
