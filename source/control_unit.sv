
// interface include
`include "control_unit_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module control_unit (
  input CLK, nRST,
  control_unit_if.cu cuif
);
  //WORKK WITH IREN
  // type import
  import cpu_types_pkg::*;
  //logic [6:0] op;
  //logic [6:0] rfunc;

  //assign cuif.immediate = cuif.instruction[15:0];
  //assign rfunc = funct_t'(cuif.inst[5:0]);
  //assign op = opcode_t'(cuif.inst[31:26]); 

  assign cuif.shamt_value = {27'b000000000000000000000000000, cuif.inst[10:6]}; //NOT SURE
  //assign cuif.iREN = (~cuif.halt & ~cuif.dREN);
  always_comb begin
	cuif.RegDst = 0;
	cuif.Jump = 0;
	cuif.Branch = 0;
	cuif.MemToReg = 0;
	cuif.ALUOp = ALU_SLL;
	cuif.ALUSrc = 0;
	cuif.RegWrite =0;
	//cuif.iRen=0;
	cuif.dREN=0;
	cuif.dWEN=0;
	cuif.extender=0;
	cuif.halt=0;
	cuif.shamt=0;
	cuif.lui=0;
        cuif.iREN = 1'b1;
	//Confused signals halt
	if(cuif.op == RTYPE) begin
		casez(cuif.rfunc) 
		SLL: begin
			cuif.RegDst = 1;
			cuif.Jump = 2'b00;
			cuif.Branch = 0;
			cuif.MemToReg = 0;
			cuif.ALUOp = ALU_SLL;
			cuif.ALUSrc = 0;
			cuif.RegWrite = 1;
			//cuif.iRen=1;
			cuif.dREN=0;
			cuif.dWEN=0;	
			cuif.extender=0;
			cuif.shamt=1;
			cuif.lui=0;
	        	//cuif.iREN = 1'b1;
		end

		SRL: begin
			cuif.RegDst = 1;
			cuif.Jump = 2'b00;
			cuif.Branch = 0;
			cuif.MemToReg = 0;
			cuif.ALUOp = ALU_SRL;
			cuif.ALUSrc = 0;
			cuif.RegWrite = 1;
			//cuif.iRen=1;
			cuif.dREN=0;
			cuif.dWEN=0;	
			cuif.extender=0;
			cuif.shamt=1;	
			cuif.lui=0;
	        	//cuif.iREN = 1'b1;
		end

		//NOT SURE ABOUT THIS ONE
		JR: begin
			cuif.RegDst = 0; //Dont care
			cuif.Jump = 2'b01;
			cuif.Branch = 0;
			cuif.MemToReg = 0;
			cuif.ALUOp = ALU_AND;
			cuif.ALUSrc = 0;
			cuif.RegWrite = 1;
			//cuif.iRen=0;
			cuif.dREN=0;
			cuif.dWEN=0;	
			cuif.extender=0;
			cuif.lui=0;
	        	//cuif.iREN = 1'b1;
		end

		ADD: begin
			cuif.RegDst = 1;
			cuif.Jump = 2'b00;
			cuif.Branch = 0;
			cuif.MemToReg = 0;
			cuif.ALUOp = ALU_ADD;
			cuif.ALUSrc = 0;
			cuif.RegWrite = 1;
			//cuif.iRen=1;
			cuif.dREN=0;
			cuif.dWEN=0;	
			cuif.extender=0;	
			cuif.lui=0;
	        	//cuif.iREN = 1'b1;
		end

		ADDU: begin
			cuif.RegDst = 1;
			cuif.Jump = 2'b00;
			cuif.Branch = 0;
			cuif.MemToReg = 0;
			cuif.ALUOp = ALU_ADD;
			cuif.ALUSrc = 0;
			cuif.RegWrite = 1;
			//cuif.iRen=1;
			cuif.dREN=0;
			cuif.dWEN=0;	
			cuif.extender=0;	
			cuif.lui=0;
	        	//cuif.iREN = 1'b1;
		end

		SUB: begin
			cuif.RegDst = 1;
			cuif.Jump = 2'b00;
			cuif.Branch = 0;
			cuif.MemToReg = 0;
			cuif.ALUOp = ALU_SUB;
			cuif.ALUSrc = 0;
			cuif.RegWrite = 1;
			//cuif.iRen=1;
			cuif.dREN=0;
			cuif.dWEN=0;	
			cuif.extender=0;	
			cuif.lui=0;
	        	//cuif.iREN = 1'b1;
		end

		SUBU: begin
			cuif.RegDst = 1;
			cuif.Jump = 2'b00;
			cuif.Branch = 0;
			cuif.MemToReg = 0;
			cuif.ALUOp = ALU_SUB;
			cuif.ALUSrc = 0;
			cuif.RegWrite = 1;
			//cuif.iRen=1;
			cuif.dREN=0;
			cuif.dWEN=0;	
			cuif.extender=0;	
			cuif.lui=0;
	        	//cuif.iREN = 1'b1;
		end

		AND: begin
			cuif.RegDst = 1;
			cuif.Jump = 2'b00;
			cuif.Branch = 0;
			cuif.MemToReg = 0;
			cuif.ALUOp = ALU_AND;
			cuif.ALUSrc = 0;
			cuif.RegWrite = 1;
			//cuif.iRen=1;
			cuif.dREN=0;
			cuif.dWEN=0;	
			cuif.extender=0;	
			cuif.lui=0;
	        	//cuif.iREN = 1'b1;
		end

		OR: begin
			cuif.RegDst = 1;
			cuif.Jump = 2'b00;
			cuif.Branch = 0;
			cuif.MemToReg = 0;
			cuif.ALUOp = ALU_OR;
			cuif.ALUSrc = 0;
			cuif.RegWrite = 1;
			//cuif.iRen=1;
			cuif.dREN=0;
			cuif.dWEN=0;	
			cuif.extender=0;	
			cuif.lui=0;
	        	//cuif.iREN = 1'b1;
		end

		XOR: begin
			cuif.RegDst = 1;
			cuif.Jump = 2'b00;
			cuif.Branch = 0;
			cuif.MemToReg = 0;
			cuif.ALUOp = ALU_XOR;
			cuif.ALUSrc = 0;
			cuif.RegWrite = 1;
			//cuif.iRen=1;
			cuif.dREN=0;
			cuif.dWEN=0;	
			cuif.extender=0;	
			cuif.lui=0;
	        	//cuif.iREN = 1'b1;
		end

		NOR: begin
			cuif.RegDst = 1;
			cuif.Jump = 2'b00;
			cuif.Branch = 0;
			cuif.MemToReg = 0;
			cuif.ALUOp = ALU_NOR;
			cuif.ALUSrc = 0;
			cuif.RegWrite = 1;
			//cuif.iRen=1;
			cuif.dREN=0;
			cuif.dWEN=0;	
			cuif.extender=0;	
			cuif.lui=0;
	        	//cuif.iREN = 1'b1;
		end

		SLT: begin
			cuif.RegDst = 1;
			cuif.Jump = 2'b00;
			cuif.Branch = 0;
			cuif.MemToReg = 0;
			cuif.ALUOp = ALU_SLT;
			cuif.ALUSrc = 0;
			cuif.RegWrite = 1;
			//cuif.iRen=1;
			cuif.dREN=0;
			cuif.dWEN=0;	
			cuif.extender=0;	
			cuif.lui=0;
	        	//cuif.iREN = 1'b1;
		end

		SLTU: begin
			cuif.RegDst = 1;
			cuif.Jump = 2'b00;
			cuif.Branch = 0;
			cuif.MemToReg = 0;
			cuif.ALUOp = ALU_SLTU;
			cuif.ALUSrc = 0;
			cuif.RegWrite = 1;
			//cuif.iRen=1;
			cuif.dREN=0;
			cuif.dWEN=0;	
			cuif.extender=0;	
			cuif.lui=0;
	        	//cuif.iREN = 1'b1;
		end

		endcase //casez(cuif.rfunc) 
	end
	else if (cuif.op != RTYPE) begin
		casez(cuif.op)
		//jtype
		J: begin
			cuif.RegDst = 1;
			cuif.Jump = 2'b10;
			cuif.Branch = 0;
			cuif.MemToReg = 0;
			cuif.ALUOp = ALU_AND;
			cuif.ALUSrc = 0;
			cuif.RegWrite = 0; //Should it be 1 or 0
			//cuif.iRen=1;
			cuif.dREN=0;
			cuif.dWEN=0;	
			cuif.extender=0;
			cuif.lui=0;
	        	//cuif.iREN = 1'b1;
		end

		JAL: begin
			cuif.RegDst = 1;
			cuif.Jump = 2'b11;
			cuif.Branch = 0;
			cuif.MemToReg = 1;
			cuif.ALUOp = ALU_AND;
			cuif.ALUSrc = 0;
			cuif.RegWrite = 1;
			//cuif.iRen=1;
			cuif.dREN=0;
			cuif.dWEN=0;	
			cuif.extender=0;
			cuif.lui=0;
	        	//cuif.iREN = 1'b1;
		end

		// itype
		BEQ: begin
			cuif.RegDst = 1;
			cuif.Jump = 2'b00;
			cuif.Branch = 1;
			cuif.MemToReg = 0;
			cuif.ALUOp = ALU_SUB;
			cuif.ALUSrc = 0; //Not sure about ALU_SRC in BEQ and BNE
			cuif.RegWrite = 0;
			//cuif.iRen=1;
			cuif.dREN=0;
			cuif.dWEN=0;	
			cuif.extender=0;
			cuif.lui=0;
	        	//cuif.iREN = 1'b1;
		end

		BNE: begin
			cuif.RegDst = 1;
			cuif.Jump = 2'b00;
			cuif.Branch = 1;
			cuif.MemToReg = 0;
			cuif.ALUOp = ALU_SUB;
			cuif.ALUSrc = 0; //Not sure
			cuif.RegWrite = 0;
			//cuif.iRen=1;
			cuif.dREN=0;
			cuif.dWEN=0;	
			cuif.extender=0;
			cuif.lui=0;
	        	//cuif.iREN = 1'b1;
		end

    		ADDI: begin
			cuif.RegDst = 0;
			cuif.Jump = 2'b00;
			cuif.Branch = 0;
			cuif.MemToReg = 0;
			cuif.ALUOp = ALU_ADD;
			cuif.ALUSrc = 1;
			cuif.RegWrite = 1;
			//cuif.iRen=1;
			cuif.dREN=0;
			cuif.dWEN=0;	
			cuif.extender=1;
			cuif.lui=0;
	        	//cuif.iREN = 1'b1;
		end

		ADDIU: begin
			cuif.RegDst = 0;
			cuif.Jump = 2'b00;
			cuif.Branch = 0;
			cuif.MemToReg = 0;
			cuif.ALUOp = ALU_ADD;
			cuif.ALUSrc = 1;
			cuif.RegWrite = 1;
			//cuif.iRen=1;
			cuif.dREN=0;
			cuif.dWEN=0;	
			cuif.extender=1; //Sign extended
			cuif.lui=0;
	        	//cuif.iREN = 1'b1;
		end
	
		SLTI: begin
			cuif.RegDst = 0;
			cuif.Jump = 2'b00;
			cuif.Branch = 0;
			cuif.MemToReg = 0;
			cuif.ALUOp = ALU_SLT;
			cuif.ALUSrc = 1;
			cuif.RegWrite = 1;
			//cuif.iRen=1;
			cuif.dREN=0;
			cuif.dWEN=0;	
			cuif.extender=0;
			cuif.lui=0;
	        	//cuif.iREN = 1'b1;
		end

		SLTIU: begin
			cuif.RegDst = 0;
			cuif.Jump = 2'b00;
			cuif.Branch = 0;
			cuif.MemToReg = 0;
			cuif.ALUOp = ALU_SLTU;
			cuif.ALUSrc = 1;
			cuif.RegWrite = 1;
			//cuif.iRen=1;
			cuif.dREN=0;
			cuif.dWEN=0;	
			cuif.extender=0;
			cuif.lui=0;
	        	//cuif.iREN = 1'b1;
		end
		
    		ANDI: begin
			cuif.RegDst = 0;
			cuif.Jump = 2'b00;
			cuif.Branch = 0;
			cuif.MemToReg = 0;
			cuif.ALUOp = ALU_AND;
			cuif.ALUSrc = 1;
			cuif.RegWrite = 1;
			//cuif.iRen=1;
			cuif.dREN=0;
			cuif.dWEN=0;	
			cuif.extender=0;  //Should it be 1 or 0?  
			cuif.lui=0;
	        	//cuif.iREN = 1'b1;
		end

		ORI: begin 
			cuif.RegDst = 0;
			cuif.Jump = 2'b00;
			cuif.Branch = 0;
			cuif.MemToReg = 0;
			cuif.ALUOp = ALU_OR;
			cuif.ALUSrc = 1;
			cuif.RegWrite = 1;
			//cuif.iRen=1;
			cuif.dREN=0;
			cuif.dWEN=0;	
			cuif.extender=0;    //Should it be 1 or 0? 
			cuif.lui=0;
	        	//cuif.iREN = 1'b1;
		end

    		XORI: begin
			cuif.RegDst = 0;
			cuif.Jump =2'b00;
			cuif.Branch = 0;
			cuif.MemToReg = 0;
			cuif.ALUOp = ALU_XOR;
			cuif.ALUSrc = 1;
			cuif.RegWrite = 1;
			//cuif.iRen=1;
			cuif.dREN=0;
			cuif.dWEN=0;	
			cuif.extender=0;    //Should it be 1 or 0? 		
			cuif.lui=0;
	        	//cuif.iREN = 1'b1;
		end

	
    		LUI: begin
			cuif.RegDst = 0;
			cuif.Jump = 2'b00;
			cuif.Branch = 0;
			cuif.MemToReg = 0; //NOT SURE ABOUT THIS MemToREG
			cuif.ALUOp = ALU_AND;
			cuif.ALUSrc = 1;
			cuif.RegWrite = 1;
			//cuif.iRen=1;
			cuif.dREN=0;
			cuif.dWEN=0;	
			cuif.extender=0;    
			cuif.lui=1;
	        	//cuif.iREN = 1'b1;
		end
		
    		LW: begin
			cuif.RegDst = 0;
			cuif.Jump = 0;
			cuif.Branch = 0;
			cuif.MemToReg = 1;
			cuif.ALUOp = ALU_ADD;
			cuif.ALUSrc = 1;
			cuif.RegWrite = 1;
			//cuif.iRen=1;
			cuif.dREN=1;
			cuif.dWEN=0;	
			cuif.extender=0; 
			cuif.lui=0;
	        	//cuif.iREN = 1'b1;
		end

    		SW: begin
			cuif.RegDst = 0;
			cuif.Jump = 0;
			cuif.Branch = 0;
			cuif.MemToReg = 1;
			cuif.ALUOp = ALU_ADD;
			cuif.ALUSrc = 1;
			cuif.RegWrite = 0;
			//cuif.iRen=1;
			cuif.dREN=0;
			cuif.dWEN=1;
			cuif.extender=0;
			cuif.lui=0;
	        	//cuif.iREN = 1'b1;
		end

    		HALT: begin
			cuif.halt =1;
	        	cuif.iREN = 1'b0;
			
		end

		endcase //casez(cuif.op)
	end
  end
endmodule
