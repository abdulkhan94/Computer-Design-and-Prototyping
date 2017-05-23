/*
  Eric Villasenor
  evillase@gmail.com

  datapath contains register file, control, hazard,
  muxes, and glue logic for processor
*/

// data path interface
`include "datapath_cache_if.vh"
`include "cpu_types_pkg.vh"
`include "control_unit_if.vh"
`include "pc_if.vh"
`include "alu_if.vh"
`include "register_file_if.vh"
`include "request_unit_if.vh"
`include "exmem_if.vh"
`include "idex_if.vh"
`include "ifid_if.vh"
`include "memwb_if.vh"
`include "hazard_unit_if.vh"
`include "forward_unit_if.vh"

// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"

module datapath (
  input logic CLK, nRST,
  datapath_cache_if.dp dpif
);
   
  // import types
  import cpu_types_pkg::*;

  // pc init
  parameter PC_INIT = 0;

  //Initializations
  control_unit_if cuif();
  register_file_if rfif();
  alu_if aluif();
  pc_if pcif();
  request_unit_if ruif();
  exmem_if exif();
  idex_if idif();
  ifid_if ifif();
  memwb_if meif();
  hazard_unit_if huif();
  forward_unit_if fuif();

  request_unit RU(CLK, nRST, ruif);
  alu ALU(aluif);
  pc #(PC_INIT) PC(CLK, nRST, pcif.progc);
  register_file RF(CLK, nRST, rfif);
  control_unit CU(CLK, nRST, cuif);
  exmem EX(CLK,nRST, exif);
  idex ID(CLK, nRST, idif);
  ifid IF(CLK, nRST, ifif);
  memwb ME(CLK, nRST, meif);
  hazard_unit HU(CLK, nRST, huif);
  forward_unit FU(CLK, nRST, fuif);

  word_t extended_value;
  word_t shamt_value;
  word_t lui_value;
  word_t pcn;
  logic pcstall;
  word_t portB_temp; //Temp signal used to mux, mux
   
  //Account for LUI
  assign lui_value = {ifif.instr_out[15:0], 16'b0000000000000000};

  //Account for shamt 
  assign shamt_value = {27'b000000000000000000000000000, ifif.instr_out[10:6]};

  //Account for extender flag:
  //Zero extension - extender = 0 ; sign extension - extender = 1;
  always_comb begin
	if(cuif.extender == 1'b0) begin
		extended_value = {16'b0000000000000000, ifif.instr_out[15:0]};
	end 
	else begin//else if (cuif.extender == 1'b1) begin
		if(ifif.instr_out[15]) begin		
			extended_value = {16'b1111111111111111, ifif.instr_out[15:0]};
		end 
		else begin
			extended_value = {16'b0000000000000000, ifif.instr_out[15:0]};
		end
	end
  end

 //Control Unit mapping
  assign cuif.rfunc = funct_t'(ifif.instr_out[5:0]);
  assign cuif.op = opcode_t'(ifif.instr_out[31:26]);

  assign cuif.inst = ifif.instr_out;

  //Pipeline mapping
  //IFID Pipe
  assign ifif.pc_next_in = pcif.pc_curr;
  assign ifif.instr_in = dpif.imemload;
  
  //IDEX Pipe
  //Control unit signals that might be bad
  assign idif.extended_value_in = extended_value; //need extender & not sure if this needs to be sent from a block
  assign idif.inst_in = ifif.instr_out; // not sure if this should come from control unit
  assign idif.pc_next_in = ifif.pc_next_out;

  //Others
  assign idif.rdat1_in = rfif.rdat1;  
  assign idif.rdat2_in = rfif.rdat2; 
  assign idif.lui_in = cuif.lui; 
  assign idif.lui_value_in = lui_value;
  assign idif.branch_in = cuif.Branch;
  assign idif.jump_in = cuif.Jump; 
  assign idif.MemToReg_in = cuif.MemToReg; 
  assign idif.shamt_value_in = shamt_value; 
  assign idif.shamt_in = cuif.shamt; 
  assign idif.ALUSrc_in = cuif.ALUSrc; 
  assign idif.RegDst_in = cuif.RegDst;  
  assign idif.ALUOp_in = cuif.ALUOp;
  assign idif.halt_in = cuif.halt; 
  assign idif.dWEN_in = cuif.dWEN; 
  assign idif.dREN_in = cuif.dREN; 
  assign idif.RegWrite_in = cuif.RegWrite; 
  assign idif.op_in = opcode_t'(ifif.instr_out[31:26]); 

  //EXMEM Pipe
  //Daddr Stuff
  always_comb begin
	if(idif.lui_out) begin
		exif.daddr_in = idif.lui_value_out;
	end else begin
		exif.daddr_in = aluif.outport;
	end
  end

  //Others
  assign exif.rdat1_in = idif.rdat1_out;
  assign exif.rdat2_in = portB_temp;//idif.rdat2_out; //Change here and remember forwarding case 
  assign exif.zero_flag_in = aluif.zero_flag;
  assign exif.branch_in = idif.branch_out;
 
 
  always_comb begin
	if((idif.op_out != JAL) && (idif.RegDst_out == 1)) begin
		exif.wsel_in = idif.inst_out[15:11]; //rd
	end
	else if((idif.op_out == JAL) && (idif.RegDst_out == 1)) begin
		exif.wsel_in = 32'd31;
	end
	else begin
		exif.wsel_in = idif.inst_out[20:16]; //rt
	end
  end

  assign exif.pc_next_in = idif.pc_next_out; 
  assign exif.extended_value_in = idif.extended_value_out;
  assign exif.jump_in = idif.jump_out;
  assign exif.halt_in = idif.halt_out; 
  assign exif.dWEN_in = idif.dWEN_out; 
  assign exif.dREN_in = idif.dREN_out; 
  assign exif.RegWrite_in = idif.RegWrite_out; 
  assign exif.MemToReg_in = idif.MemToReg_out; 
  assign exif.op_in = idif.op_out;
  assign exif.RegDest_in = idif.RegDst_out;
  assign exif.inst_in = idif.inst_out;

  //MEMWB Pipe
  //assign meif.daddr_in = exif.daddr_out; not needed 
  assign meif.jump_in = exif.jump_out;
  assign meif.wsel_in = exif.wsel_out;
  assign meif.pc_next_in = exif.pc_next_out;
  assign meif.halt_in = exif.halt_out;
  assign meif.RegWrite_in = exif.RegWrite_out;
  assign meif.MemToReg_in = exif.MemToReg_out;
  assign meif.op_in = exif.op_out;
  assign meif.RegDest_in = exif.RegDest_out;
  assign meif.inst_in = exif.inst_out;
  //assign meif.dmemload_in = dpif.dmemload;
  

  //Hazard unit & Stall stuff
  always_comb begin
	huif.dhit = dpif.dhit;
	huif.ihit = dpif.ihit;
	huif.exmem_branch = exif.branch_out;
	huif.ifid_rs = ifif.instr_out[25:21];
	huif.ifid_rt = ifif.instr_out[20:16]; 
	huif.exmem_op = exif.op_out;  
	huif.exmem_jump = exif.jump_out;
	huif.idex_out_wsel = exif.wsel_in; 
	huif.exmem_out_wsel = meif.wsel_in; 
	huif.zero_flag = exif.zero_flag_out; 
	huif.WEN = exif.dWEN_out;
	huif.REN = exif.dREN_out;
  end 

  //Enable signals
  always_comb begin
	ifif.enable = huif.ifid_enable;
	idif.enable = huif.idex_enable;
	exif.enable = huif.exmem_enable; 
	meif.enable = huif.memwb_enable;
	ifif.nop = huif.ifid_nop; 
	idif.nop = huif.idex_nop; 
	exif.nop = huif.exmem_nop; 
	meif.nop = huif.memwb_nop;	

  end
  //New stuff below
  //Forwarding Unit
  assign fuif.idex_rs_out = idif.inst_out[25:21]; //rs
  assign fuif.idex_rt_out = idif.inst_out[20:16]; //rt
  assign fuif.exmem_wsel_out = exif.wsel_out; 
  assign fuif.memwb_wsel_out = meif.wsel_out;
  assign fuif.exmem_RegWrite_out = exif.RegWrite_out;
  assign fuif.memwb_RegWrite_out = meif.RegWrite_out;
  
  //Not sure if need lw and rtype done signals


  //ALU mapping
  //Will add logic with forwarding MUX here

  //ALU port A  
  always_comb begin
	if(fuif.forwardA==2'b10) begin
		aluif.portA = meif.wdat_in;//exif.inst_out[25:21];
	end
	else if (fuif.forwardA==2'b11) begin
		aluif.portA = meif.wdat_out;
	end
	else begin
		aluif.portA = idif.rdat1_out;
	end
  end
  //assign aluif.portA = idif.rdat1_out;
  
  assign aluif.aluop = idif.ALUOp_out;
  
  //For ALU port B 
  always_comb begin
	if(fuif.forwardB == 2'b10)begin
		portB_temp = meif.wdat_in;//exif.inst_out[20:16];
	end
	else if (fuif.forwardB == 2'b11) begin
		portB_temp = meif.wdat_out;
	end
	else begin
		portB_temp = idif.rdat2_out;
	end

  end

  always_comb begin
	aluif.portB = portB_temp;
  	if(idif.ALUSrc_out) begin
		aluif.portB = idif.extended_value_out;
	end 
	if (idif.shamt_out) begin
       		aluif.portB = idif.shamt_value_out; //NOT SURE ABOUT THIS ONE
	 end
  end
  
 assign huif.halt = exif.halt_out; //only new thing


  //Datapath mapping
 /* always_ff @ (posedge CLK, negedge nRST) begin
        if(!nRST) begin
		dpif.halt <= 1'b0;
	end
	else begin
  		dpif.halt <= exif.halt_out; //Sus
  	end
  end*/

  assign dpif.halt = exif.halt_out;

  assign dpif.imemREN = 1;
  assign dpif.imemaddr = pcif.pc_curr;
  assign dpif.dmemREN = exif.dREN_out;
  assign dpif.dmemWEN = exif.dWEN_out;
  assign dpif.dmemstore = exif.rdat2_out;
  assign dpif.dmemaddr = exif.daddr_out; //can this be between lui and alu outport
  


  //Register file mapping
  //For rfif.WEN
  assign rfif.WEN = meif.RegWrite_out; //& (dpif.dhit | dpif.ihit); // Sus
  //For rfif.wsel
  assign rfif.wsel = meif.wsel_out;

  
  assign rfif.rsel1 = ifif.instr_out[25:21]; //rs which goes from ifid
  assign rfif.rsel2 = ifif.instr_out[20:16]; //rt
  assign rfif.wdat = meif.wdat_out;


  
  //For rfif.wdat  Use jump to seperate
  word_t temp_wdat;

  //Confusion here : I dont think i need MemToReg here honestly 
  always_comb begin
	if((exif.op_out != JAL)) begin //&& (meif.MemToReg_out == 1)) begin
		temp_wdat = dpif.dmemload;
	end
	else begin//if(meif.op_out == JAL) begin
		temp_wdat = exif.pc_next_out+4;//31; //NOT SURE ABOUT THIS ONE
	end
  end


  always_comb begin
	if(exif.MemToReg_out) begin
		meif.wdat_in = temp_wdat;
	end
	else begin
		meif.wdat_in = exif.daddr_out;
	end

  end

   
  //Program Counter mapping 
  assign pcif.pc_en = ~huif.pcstall && ~dpif.halt; //Sus Should be from pcstall signal
  
  assign pcif.pc_next = pcn; 
     //pcif.pc_curr = pcn;
  
   //assign pcn = 32'b0;
   
  word_t pc_inc;
  always_comb begin
        pcn = 32'b0;
        pc_inc = exif.pc_next_out + 4;
	if(exif.jump_out == 2'b00) begin
		if((exif.op_out == BEQ) && (exif.zero_flag_out) && (exif.branch_out == 1)) begin
			pcn = ({{14{exif.inst_out[15]}}, exif.inst_out[15:0], 2'b00}+pc_inc);
		end
		else if ((exif.op_out == BNE) && ~(exif.zero_flag_out) && (exif.branch_out == 1)) begin
			pcn = ({{14{exif.inst_out[15]}}, exif.inst_out[15:0], 2'b00}+pc_inc);
		end
		else begin
			pcn = pcif.pc_curr + 4;
		end
	end
	else if(exif.jump_out == 2'b01) begin
		pcn = exif.rdat1_out; //Jump routine
	end
	else if(exif.jump_out == 2'b11) begin //NOT SURE ABOUT THIS ONE
		pcn = pc_inc;
		pcn = {pcn[31:28], exif.inst_out[25:0], 2'b00}; //Jump and Link
	end
        else begin
		pcn = pc_inc;
	        pcn = {pcn[31:28], exif.inst_out[25:0], 2'b00};
	end
	  
  end
 
 
endmodule
