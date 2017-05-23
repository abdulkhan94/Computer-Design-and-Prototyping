`include "forward_unit_if.vh"

`include "cpu_types_pkg.vh"
 import cpu_types_pkg::*;

module forward_unit (input logic CLK, nRST, forward_unit_if.fu fuif);
/*ForwardA : 

10 = exmem forward
11 = memwb forward
00 = no forward

*/

//Should there be something involved with detecting rtype as well since we will only forward those instructions?

always_comb begin 

	if ((fuif.exmem_wsel_out == fuif.idex_rs_out) && (fuif.exmem_wsel_out != 0) && fuif.exmem_RegWrite_out) begin //raw hazard case ex stage
		fuif.forwardA = 2'b10;
	end
	else if ((fuif.memwb_wsel_out == fuif.idex_rs_out) && (fuif.memwb_wsel_out != 0) && fuif.memwb_RegWrite_out) begin //raw hazard case mem stage
		fuif.forwardA = 2'b11;
	end
	else begin
		fuif.forwardA = 2'b00;
	end

	if ((fuif.exmem_wsel_out == fuif.idex_rt_out) && (fuif.exmem_wsel_out != 0) && fuif.exmem_RegWrite_out) begin //raw hazard case ex stage
		fuif.forwardB = 2'b10;
	end
	else if ((fuif.memwb_wsel_out == fuif.idex_rt_out) && (fuif.memwb_wsel_out != 0) && fuif.memwb_RegWrite_out) begin //raw hazard case mem stage
		fuif.forwardB = 2'b11;
	end
	else begin
		fuif.forwardB = 2'b00;
	end

end
endmodule
