`include "register_file_if.vh"
`include "cpu_types_pkg.vh"
`include "alu_if.vh"

import cpu_types_pkg::*;

module alu(

	alu_if.alu aluopc);
   

	always_comb begin
	   case(aluopc.aluop)
	     ALU_SLL: begin
		aluopc.outport = aluopc.portA << aluopc.portB;
		aluopc.overflow_flag = 0;
	     end

	     ALU_SRL: begin
		aluopc.outport = aluopc.portA >> aluopc.portB;
		aluopc.overflow_flag = 0;
	     end

	     ALU_ADD: begin
		aluopc.outport = aluopc.portA + aluopc.portB;
		
		if( (~aluopc.portA[31] & ~aluopc.portB[31] & aluopc.outport[31]) | (aluopc.portA[31] & aluopc.portB[31] & ~aluopc.outport[31])) begin
			aluopc.overflow_flag = 1;
		end else begin
			aluopc.overflow_flag = 0;
		end
	     end

	     ALU_SUB: begin
		aluopc.outport = aluopc.portA - aluopc.portB;

		if( (aluopc.portA[31] & ~aluopc.portB[31] & ~aluopc.outport[31]) | (~aluopc.portA[31] & aluopc.portB[31] & aluopc.outport[31])) begin
			aluopc.overflow_flag=1;
		end else begin
			aluopc.overflow_flag=0;
		end		

	     end

	     ALU_AND: begin
        
		aluopc.outport = aluopc.portA & aluopc.portB;

		aluopc.overflow_flag = 0;
	     end

	     ALU_OR: begin
	       	aluopc.outport = aluopc.portA | aluopc.portB;

		aluopc.overflow_flag = 0;
	     end

	     ALU_XOR: begin
	       	aluopc.outport = aluopc.portA ^ aluopc.portB;

		aluopc.overflow_flag = 0;

	     end

	     ALU_NOR: begin
		aluopc.outport = ~(aluopc.portA | aluopc.portB);

		aluopc.overflow_flag = 0;
	     end

	     ALU_SLT: begin
		if($signed(aluopc.portA) < $signed(aluopc.portB)) begin
			aluopc.outport = 1;
		end		
		else begin 
			aluopc.outport = 0;
		end
		aluopc.overflow_flag = 0;
	     end

	     ALU_SLTU: begin
		if(aluopc.portA < aluopc.portB) begin
			aluopc.outport = 1;
		end		
		else begin 
			aluopc.outport = 0;
		end
		aluopc.overflow_flag = 0;
	     end
	     
	   endcase // casez (aluop)

	end // always_comb begin
   
	assign aluopc.zero_flag = (aluopc.outport == 0) ? 1:0;
	assign aluopc.negative_flag = (aluopc.outport[31] == 1) ? 1:0;

endmodule 
	
