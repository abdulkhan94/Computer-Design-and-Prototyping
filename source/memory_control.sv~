/*
  Eric Villasenor
  evillase@gmail.com

  this block is the coherence protocol
  and artibtration for ram
*/

// interface include
`include "cache_control_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module memory_control (
  input CLK, nRST,
  cache_control_if.cc ccif
);
  // type import
  import cpu_types_pkg::*;

  // number of cpus for cc
  parameter CPUS = 2;

  /*  
    INPUTS // cache inputs
    	   iREN, dREN, dWEN, dstore, iaddr, daddr,
            // ram inputs
            ramload, ramstate,
            // coherence inputs from cache
            ccwrite, cctrans,

    OUTPUTS // cache outputs
    	    iwait, dwait, iload, dload,
            // ram outputs
            ramstore, ramaddr, ramWEN, ramREN,
            // coherence outputs to cache
            ccwait, ccinv, ccsnoopaddr
  */

  //Unsure about RAMWEN BRO

	typedef enum bit [4:0] {IDLE, SNOOP, INST, WBMEM1, WBMEM2, WBCACHE1, WBCACHE2, LOADMEM1, LOADMEM2, INVALIDATE} state_type;
	state_type curr_state, next_state;

	logic dsource, next_dsource;
	logic isource, next_isource;

	always_ff @ (posedge CLK, negedge nRST) begin
		if (!nRST) begin
			curr_state <= IDLE;
			dsource <= 0;
			isource <= 0;
		end
		else begin
			curr_state <= next_state;
			dsource <= next_dsource;
			isource <= next_isource;
		end
	end

	always_comb begin
		//Initializations
		next_state = curr_state;
		//Cache
    	    	ccif.iwait = 2'b11;
		ccif.dwait = 2'b11;
		ccif.iload = 0;
		ccif.dload = 0;
            	//RAM
            	ccif.ramstore = 0;
		ccif.ramaddr = 0;
		ccif.ramWEN = 0; 
		ccif.ramREN = 0;
            	//Coherence outputs to cache
		ccif.ccwait = 0;

		ccif.ccinv = 0; 
		ccif.ccsnoopaddr[0] = ccif.daddr[1];
      		ccif.ccsnoopaddr[1] = ccif.daddr[0]; 
		next_isource = isource;
		next_dsource = dsource;
		//On a BUSReadX if we invalidate the other core and write data to memory

		casez(curr_state)
			IDLE: begin
				ccif.ccwait = 0; //Needs to be 0 when inside idle unelss it hits the specific if case
				//ccif.iwait = 0;
				//ccif.dwait = 0;
				ccif.ramWEN = 0; 
				ccif.ramREN = 0;

				//Next State Logic
				if(ccif.cctrans[0] && ~ccif.cctrans[1]) begin
					next_state = SNOOP;
					next_dsource = 0;
					ccif.ccwait[1] = 1;
				end
				else if(ccif.cctrans[1] && ~ccif.cctrans[0]) begin
					next_state = SNOOP;
					next_dsource = 1;
					ccif.ccwait[0] = 1;
				end
				else if(ccif.cctrans[0] && ccif.cctrans[1]) begin
					next_state = SNOOP;
					next_dsource = 0;
					ccif.ccwait[1] = 1;
				end
				else if(ccif.dWEN) begin
					next_state = WBMEM1;
				end
				else if(ccif.iREN[0]) begin
					//next_isource = 0;
					next_state = INST;
				end
				else if(ccif.iREN[1]) begin
					//next_isource = 1;
					next_state = INST;
				end
			end
			
			INST: begin
	   			if(ccif.ramstate == ACCESS) begin
	      				next_state = IDLE;
					next_isource = ~isource;
	   			end

				//Outputs
				if(ccif.ramstate == ACCESS) begin
	      				ccif.iwait[isource] = 0;
	   			end
				else begin
					ccif.iwait[isource] = 1;
				end	   			
				ccif.iload[isource] = ccif.ramload;
	   			ccif.ramREN = 1; //ccif.iREN[isource];
	   			ccif.ramaddr = ccif.iaddr[isource];

			end

			SNOOP: begin
				ccif.ccwait[~dsource] = 1;
				ccif.ccsnoopaddr[~dsource] = ccif.daddr[dsource]; //Should it be set ~dsource? 	
				//Next State Logic
				if(ccif.ccwrite[~dsource] && !ccif.cctrans[~dsource]) begin
					next_state = WBCACHE1;
				end
				else if(ccif.cctrans[~dsource])begin
					next_state = LOADMEM1;
				end
			

				/*if(ccif.cctrans[0] && ~ccif.cctrans[1]) begin
					ccif.ccwait[1] = 1;
				end
				else if(ccif.cctrans[1] && ~ccif.cctrans[0]) begin

					ccif.ccwait[0] = 1;
				end
				else begin

					ccif.ccwait[1] = 1;
				end */
			end

			WBCACHE1: begin	
				ccif.ccwait[~dsource] = 1;
				//Next State Logic
				if(ccif.ramstate == ACCESS) begin
					next_state = WBCACHE2;
				end
				ccif.dwait[dsource] = 1;
				ccif.dwait[~dsource] = 1;
				//Outputs to write to memory
				if(ccif.ramstate == ACCESS) begin
					ccif.dwait[dsource] = 0;
					ccif.dwait[~dsource] = 0;
				end

				ccif.ramWEN = 1; //ccif.dWEN[~dsource]; NOT SURE
				
				ccif.ramaddr = ccif.daddr[~dsource];
				ccif.ramstore = ccif.dstore[~dsource];
				ccif.dload[dsource] = ccif.dstore[~dsource];	

				/*if(ccif.cctrans[0] && ~ccif.cctrans[1]) begin
					ccif.ccwait[1] = 1;
				end
				else if(ccif.cctrans[1] && ~ccif.cctrans[0]) begin

					ccif.ccwait[0] = 1;
				end
				else begin

					ccif.ccwait[1] = 1;
				end*/
			end

			WBCACHE2: begin
				ccif.ccwait[~dsource] = 1;
				//Next State Logic
				/*if(ccif.ccwrite[dsource]) begin //OLD Logic
					next_state = INVALIDATE;
				end
				else begin
					next_state = IDLE;
				end*/
				if(ccif.ramstate == ACCESS) begin
					next_state = INVALIDATE;
				end

		
				ccif.dwait[dsource] = 1;
				ccif.dwait[~dsource] = 1;
				//Outputs to write to memory
				if(ccif.ramstate == ACCESS) begin
					ccif.dwait[dsource] = 0;
					ccif.dwait[~dsource] = 0;
				end

				ccif.ramWEN = 1; //ccif.dWEN[~dsource]; NOT SURE
				
				ccif.ramaddr = ccif.daddr[~dsource];
				ccif.ramstore = ccif.dstore[~dsource];
				ccif.dload[dsource] = ccif.dstore[~dsource];

				/*if(ccif.cctrans[0] && ~ccif.cctrans[1]) begin
					ccif.ccwait[1] = 1;
				end
				else if(ccif.cctrans[1] && ~ccif.cctrans[0]) begin

					ccif.ccwait[0] = 1;
				end
				else begin

					ccif.ccwait[1] = 1;
				end*/
			end

			INVALIDATE: begin
				ccif.ccwait[~dsource] = 0; //Should it be 1 or should i have another state setting to zero
				next_state = IDLE;
				if(ccif.ccwrite[dsource]) begin
					ccif.ccinv[~dsource] = 1;
				end
				else begin
					ccif.ccinv[~dsource] = 0;
				end

				/*if(ccif.cctrans[0] && ~ccif.cctrans[1]) begin
					ccif.ccwait[1] = 1;
				end
				else if(ccif.cctrans[1] && ~ccif.cctrans[0]) begin

					ccif.ccwait[0] = 1;
				end
				else begin

					ccif.ccwait[1] = 1;
				end*/
			end

			LOADMEM1: begin
				ccif.ccwait[~dsource] = 1;
				if(ccif.ramstate == ACCESS) begin
					next_state = LOADMEM2;
				end
				ccif.dwait[dsource] = 1;
				ccif.dwait[~dsource] = 1;
				//Output
				if(ccif.ramstate == ACCESS) begin
					ccif.dwait[dsource] = 0;
					ccif.dwait[~dsource] = 0;
				end
				ccif.ramREN = 1;
				
				ccif.ramaddr = ccif.daddr[dsource];
				ccif.dload[dsource] = ccif.ramload;

				/*if(ccif.cctrans[0] && ~ccif.cctrans[1]) begin
					ccif.ccwait[1] = 1;
				end
				else if(ccif.cctrans[1] && ~ccif.cctrans[0]) begin

					ccif.ccwait[0] = 1;
				end
				else begin

					ccif.ccwait[1] = 1;
				end*/

			end

			LOADMEM2: begin
				ccif.ccwait[~dsource] = 1;
				ccif.dwait[dsource] = 1;	
				ccif.dwait[~dsource] = 1;			
				if(ccif.ramstate == ACCESS) begin
					ccif.dwait[dsource] = 0;
					ccif.dwait[~dsource] = 0;
					//if(ccif.ccwrite[dsource] == 1) begin
						next_state = INVALIDATE;
					//end
					/*else begin
						next_state = IDLE;
					end*/
				end
				ccif.ramREN = 1;
				
				ccif.ramaddr = ccif.daddr[dsource];
				ccif.dload[dsource] = ccif.ramload;

				/*if(ccif.cctrans[0] && ~ccif.cctrans[1]) begin
					ccif.ccwait[1] = 1;
				end
				else if(ccif.cctrans[1] && ~ccif.cctrans[0]) begin

					ccif.ccwait[0] = 1;
				end
				else begin

					ccif.ccwait[1] = 1;
				end*/
			end

			WBMEM1: begin
				//Next State Logic
				if(ccif.ramstate == ACCESS) begin
					next_state = WBMEM2;
				end
				ccif.dwait[dsource] = 1;
				ccif.dwait[~dsource] = 1;
				//Outputs to write to memory
				if(ccif.ramstate == ACCESS) begin
					ccif.dwait[dsource] = 0;
					ccif.dwait[~dsource] = 0;
				end

				ccif.ramWEN = 1; //ccif.dWEN[~dsource]; NOT SURE

				ccif.ramaddr = ccif.daddr[dsource];
				ccif.ramstore = ccif.dstore[dsource];

				/*if(ccif.cctrans[0] && ~ccif.cctrans[1]) begin
					ccif.ccwait[1] = 1;
				end
				else if(ccif.cctrans[1] && ~ccif.cctrans[0]) begin

					ccif.ccwait[0] = 1;
				end
				else begin

					ccif.ccwait[1] = 1;
				end*/
			end

			WBMEM2: begin
				//Next State Logic
				if(ccif.ramstate == ACCESS) begin
					next_state = IDLE;
				end

				ccif.dwait[dsource] = 1;
				ccif.dwait[~dsource] = 1;
				//Outputs to write to memory
				if(ccif.ramstate == ACCESS) begin
					ccif.dwait[dsource] = 0;
					ccif.dwait[~dsource] = 0;
				end

				ccif.ramWEN = 1; //ccif.dWEN[~dsource]; NOT SURE
				
				ccif.ramaddr = ccif.daddr[dsource];
				ccif.ramstore = ccif.dstore[dsource];

				/*if(ccif.cctrans[0] && ~ccif.cctrans[1]) begin
					ccif.ccwait[1] = 1;
				end
				else if(ccif.cctrans[1] && ~ccif.cctrans[0]) begin

					ccif.ccwait[0] = 1;
				end
				else begin

					ccif.ccwait[1] = 1;
				end*/
			end

			
		endcase
	end

  /* OLD MEMORY CONTROLLER
  assign ccif.iload = ccif.ramload; //Make changes for instructions
  assign ccif.dload = ccif.ramload;
  assign ccif.iwait = (ccif.ramstate == ACCESS ? ((ccif.iREN & !(ccif.dWEN || ccif.dREN)) ? 0 : 1) : 1);
  assign ccif.dwait = (ccif.ramstate == ACCESS ? ((ccif.dREN || ccif.dWEN)? 0:1):1);
 
  always_comb begin
	ccif.ramaddr = ccif.iaddr;
	ccif.ramREN = 0;
	ccif.ramWEN =0;
        ccif.ramstore = 0;
     
     if(ccif.dREN) begin
	ccif.ramaddr = ccif.daddr;
	ccif.ramREN =1;
	ccif.ramWEN =0;
	//ccif.ramstore = 

     end

     else if(ccif.dWEN) begin
	ccif.ramstore = ccif.dstore;
	ccif.ramaddr = ccif.daddr;
	ccif.ramWEN = 1;
	ccif.ramREN = 0;
	//ccif.dload = ccif.ramload;

     end


     else if(ccif.iREN) begin
     //ccif.ramstore = 
	ccif.ramaddr = ccif.iaddr;
	ccif.ramWEN = 0;
	ccif.ramREN = 1;
//	ccif.iload = ccif.ramload;

     end 
  end */  //OLD MEMORY CONTROLLER

endmodule
