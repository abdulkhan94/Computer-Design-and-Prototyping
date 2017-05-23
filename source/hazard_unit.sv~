`include "hazard_unit_if.vh"

`include "cpu_types_pkg.vh"
 import cpu_types_pkg::*;

module hazard_unit (input logic CLK, nRST, hazard_unit_if huif
);
 //
  always_comb begin
	if ((huif.exmem_branch && huif.exmem_op == BEQ && huif.zero_flag) || (huif.exmem_branch && huif.exmem_op == BNE && ~(huif.zero_flag)) || (huif.exmem_jump == 2'b01) || (huif.exmem_jump == 2'b10) || (huif.exmem_jump == 2'b11)) begin //branch/jump case 
		//If wrong try ihit
		huif.pcstall = 0;					
		huif.ifid_enable = 1;
		huif.idex_enable = 1;
		huif.exmem_enable = 1;
		huif.memwb_enable = 1; 	
		huif.ifid_nop = 1; 
		huif.idex_nop = 1;
		huif.exmem_nop = 1; //SUS
		huif.memwb_nop = 0; 
	end
	else if (huif.dhit) begin
		huif.pcstall = 1;					
		huif.ifid_enable =0; 
		huif.idex_enable = 1;	
		huif.exmem_enable =1;
		huif.memwb_enable =1; 
		huif.ifid_nop = 1; 
		huif.idex_nop = 0;
		huif.exmem_nop =0;
		huif.memwb_nop =0; 
	end
	else if( (huif.exmem_out_wsel == huif.ifid_rs || huif.exmem_out_wsel == huif.ifid_rt) && (huif.exmem_op == LW || huif.exmem_op == SW)) begin
		huif.pcstall = 1;
		if(huif.dhit && ~huif.ihit) begin
			huif.ifid_enable = 0;
			huif.idex_enable = 0;
			huif.exmem_enable = 1;
			huif.memwb_enable = 1; 
			huif.ifid_nop = 0; 
			huif.idex_nop = 1;
			huif.exmem_nop = 0;
			huif.memwb_nop = 0; //SUS
		end
		else if(huif.dhit && huif.ihit) begin //New stuff
			huif.ifid_enable = 0;
			huif.idex_enable = 0;
			huif.exmem_enable = 0;
			huif.memwb_enable = 1; 
			huif.ifid_nop = 0; 
			huif.idex_nop = 0;
			huif.exmem_nop = 1;
			huif.memwb_nop = 0; //New stuff ends here
		end
		else begin
			huif.ifid_enable = 0;
			huif.idex_enable = 0;
			huif.exmem_enable = 0;
			huif.memwb_enable = 0; 
			huif.ifid_nop = 0; 
			huif.idex_nop = 0;
			huif.exmem_nop = 0;
			huif.memwb_nop = 0; //SUS
		end
	end
	else if(huif.halt) begin
			huif.pcstall = 0; //might need to be 1					
			huif.ifid_enable =0; 
			huif.idex_enable = 0;
			huif.exmem_enable =0;
			huif.memwb_enable =0; 
			huif.ifid_nop = 0; 
			huif.idex_nop = 0;
			huif.exmem_nop =0;
			huif.memwb_nop =0; 
	end
	else begin //default case
		if(huif.ihit && !((huif.REN || huif.WEN) && !huif.dhit)) begin
			huif.pcstall = 0;					
			huif.ifid_enable =1; 
			huif.idex_enable = 1;
			huif.exmem_enable =1;
			huif.memwb_enable =1; 
			huif.ifid_nop = 0; 
			huif.idex_nop = 0;
			huif.exmem_nop =0;
			huif.memwb_nop =0; 
			
		end
		else begin
			huif.pcstall = 1;
			huif.ifid_enable =0; 
			huif.idex_enable = 0;
			huif.exmem_enable =0;
			huif.memwb_enable =0;
			huif.ifid_nop = 0; 
			huif.idex_nop = 0;
			huif.exmem_nop =0;
			huif.memwb_nop =0; 
		end

	end
  end

	//when you get a dhit let store get out - nop in decode or mem stage
endmodule
