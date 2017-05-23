// interface module
`include "datapath_cache_if.vh"
`include "cache_control_if.vh"

// memory types
`include "cpu_types_pkg.vh"

//Update hit logic
//Where is ccwrite being set to 0
//Check if invalidate logic is correct

module dcache (
	input logic CLK, nRST,
	datapath_cache_if.dcache dcif, //.dcache
	caches_if.dcache ccif //.dcache
);
/*
	    DATAPATH
	    output  dhit, dmemload, flushed
	    
	    CACHE CONTROL
	    output dREN, dWEN, daddr, dstore,
            ccwrite, cctrans
*/
	import cpu_types_pkg::*;
	typedef enum bit [5:0] {IDLE, SNOOP, SNOOP_WB1, SNOOP_WB2, INVALIDATE, MISS1, MISS2, WRITE_BACK1, WRITE_BACK2, FIND_DIRTY, FLUSH_WORD1, FLUSH_WORD2, HITCOUNT, HALT, TRASH0, TRASH1, WRITE_MISS1, WRITE_MISS2, TRASH_INVALID} state_type;
	state_type curr_state, next_state;

  	//Struct for icache table
  	typedef struct packed {
    		logic [ITAG_W-1:0] tag;
    		logic valid;
		logic dirty;
		logic LRU;
    		word_t word1;
    		word_t word2;
  	} dc_tab;

  	dc_tab [7:0] WAY1;
  	dc_tab [7:0] WAY2;

	//Not sure
	logic[2:0] flush_index;
	logic[2:0] nxt_flush_index;
	logic found_dirty_flag;
	logic choose_flushBLK;
	logic nxt_choose_flushBLK;
	word_t count, next_count;
	word_t miss, next_miss;
	//logic [3:0] final_count_out, final_count; 	

	//logic nxt_found_dirty_flag;

	logic chooseBLK1,chooseBLK2, chooseWORD1, chooseWORD2, snoopBLK1, snoopBLK2; 

	dcachef_t daddr;
	assign daddr = dcachef_t'(dcif.dmemaddr);
	//assign dcif.dhit = (((WAY1[daddr.idx].tag == daddr.tag && WAY1[daddr.idx].valid == 1) || (WAY2[daddr.idx].tag == daddr.tag && WAY2[daddr.idx].valid == 1)) && (dcif.dmemREN || dcif.dmemWEN)) ? 1: 0; //add something to stop dhit at wrong time
	assign dcif.flushed = (curr_state == HALT);

	assign chooseBLK1 = ((WAY1[daddr.idx].tag == daddr.tag) && WAY1[daddr.idx].valid);
	assign chooseBLK2 = ((WAY2[daddr.idx].tag == daddr.tag) && WAY1[daddr.idx].valid);
	assign chooseWORD1 = (daddr.blkoff == 0);
	assign chooseWORD2 = (daddr.blkoff == 1);

	logic nxt_valid1, nxt_valid2, nxt_dirty1, nxt_dirty2, nxt_LRU1, nxt_LRU2;
	logic [25:0] nxt_tag1, nxt_tag2;
	word_t nextword;
	logic hit_flag, nxt_hit_flag;

   	logic BLK1flag, BLK2flag, nxt_BLK1flag, nxt_BLK2flag; //which block was written or overwritten during MISS

	logic writeB1W1, writeB1W2, writeB2W1, writeB2W2;
	logic hit;
	logic abdul_flush;

	logic snoop_hit;
	logic snoop_flag;

	dcachef_t saddr;
	assign saddr = dcachef_t'(ccif.ccsnoopaddr);

	assign snoopBLK1 = (WAY1[saddr.idx].tag == saddr.tag && WAY1[saddr.idx].valid);
	assign snoopBLK2 = (WAY2[saddr.idx].tag == saddr.tag && WAY2[saddr.idx].valid);

	//Snoop Hit to transition states
	assign snoop_hit = ((WAY1[saddr.idx].tag == saddr.tag && WAY1[saddr.idx].valid == 1) || (WAY2[saddr.idx].tag == saddr.tag && WAY2[saddr.idx].valid == 1)) ? 1: 0;

/*	always_comb begin
		if((WAY1[daddr.idx].valid && !WAY1[daddr.idx].dirty && dcif.dmemWEN) || (WAY2[daddr.idx].valid && !WAY2[daddr.idx].dirty && dcif.dmemWEN)) begin //Shared state
			ccif.cctrans = 1;
		end
		else if((!WAY1[daddr.idx].valid && !WAY1[daddr.idx].dirty && dcif.dmemWEN) || (!WAY2[daddr.idx].valid && !WAY2[daddr.idx].dirty && dcif.dmemWEN)) begin //Invalid
			ccif.cctrans = 1;
		end     
		else if((!WAY1[daddr.idx].valid && !WAY1[daddr.idx].dirty && dcif.dmemREN) || (!WAY2[daddr.idx].valid && !WAY2[daddr.idx].dirty && dcif.dmemREN)) begin //Invalid     
			ccif.cctrans = 1;
		end
		else begin
			ccif.cctrans = 0;
		end
	end
*/
	//Count Logic
	always_comb begin
		if(dcif.dhit) begin
			next_count = count + 1;
		end
		else begin
			next_count = count;
		end
	end


	assign hit = dcif.dhit;
	// next state logic
	always_comb begin
		next_state = curr_state;
		casez (curr_state)
			IDLE: begin //check read and write enables for memory access.
				if(dcif.halt) begin 
					next_state = FIND_DIRTY;
				end
				else if(ccif.ccwait) begin
					next_state = SNOOP;
				end
				else if (!(dcif.dmemREN || dcif.dmemWEN)) begin
					next_state = IDLE;
				end
				else if(hit) begin
					next_state = IDLE;
				end
				else begin
					if(chooseBLK1) begin
						next_state = WRITE_MISS1;
					end
					else if (chooseBLK2) begin
						next_state = WRITE_MISS1;
					end
					else if(WAY1[daddr.idx].LRU == 1) begin
						if(WAY1[daddr.idx].dirty == 1) begin
							next_state = WRITE_BACK1;
						end
						else begin
							next_state = MISS1;
						end
					end
					else begin
						if (WAY2[daddr.idx].dirty == 1) begin
							next_state = WRITE_BACK1;
						end
						else begin
							next_state = MISS1;
						end
					end	
				end
			end

			SNOOP: begin
				if(snoop_hit) begin //SUS
					if((WAY1[saddr.idx].valid && WAY1[saddr.idx].dirty) || (WAY2[saddr.idx].valid && WAY2[saddr.idx].dirty)) begin
						next_state = SNOOP_WB1;
					end
					else if((WAY1[saddr.idx].valid && !WAY1[saddr.idx].dirty) || (WAY2[saddr.idx].valid && !WAY2[saddr.idx].dirty)) begin 
						next_state = INVALIDATE; //Trash0 & trash1
					end
					else begin
						next_state = SNOOP;
					end
				end
				else if(!ccif.ccwait) begin
					next_state = IDLE;
				end
				//Should go to IDLE on !snoop hit
				else begin
					next_state = TRASH0;
				end
			end

			TRASH0: begin
				if(!ccif.dwait) begin
					next_state = TRASH1;
				end
			end

			TRASH1: begin //Variable latency
				if(!ccif.dwait) begin
					next_state = INVALIDATE;
				end
			end

			SNOOP_WB1: begin
				if (ccif.dwait == 0) begin
					next_state = SNOOP_WB2;
				end
				else begin
					next_state = SNOOP_WB1;
				end

			end
			
			SNOOP_WB2: begin
				if (ccif.dwait == 0) begin
					next_state = INVALIDATE;
				end
				else begin
					next_state = SNOOP_WB2;
				end
			end
	
			INVALIDATE: begin
				if (ccif.ccwait == 0) begin
					next_state = IDLE;
				end
				else begin
					next_state = INVALIDATE;
				end
			end

			WRITE_BACK1: begin
				if(ccif.ccwait) begin //poop
					next_state = SNOOP;
				end
				else if (ccif.dwait == 0) begin
					next_state = WRITE_BACK2;
				end
				else begin
					next_state = WRITE_BACK1;
				end
			end

			WRITE_BACK2: begin
				if (!ccif.dwait) begin 
					next_state = MISS1;
				end
				else begin
					next_state = WRITE_BACK2;
				end
			end

			WRITE_MISS1: begin
				if(ccif.ccwait) begin //poop
					next_state = SNOOP;
				end
				if (ccif.dwait == 0) begin
					next_state = WRITE_MISS2;
				end
				else begin
					next_state = WRITE_MISS1;
				end
			end

			WRITE_MISS2: begin
				if (ccif.dwait == 0) begin
					next_state = TRASH_INVALID;
				end
				else begin
					next_state = WRITE_MISS2;
				end
			end

			MISS1: begin
				if(ccif.ccwait) begin //poop
					next_state = SNOOP;
				end
				else if (ccif.dwait == 0) begin
					next_state = MISS2;
				end
				else begin
					next_state = MISS1;
				end
			end

			MISS2: begin
				if (ccif.dwait == 0) begin
					next_state = TRASH_INVALID;
				end
				else begin
					next_state = MISS2;
				end
			end

			FIND_DIRTY: begin
				if(!found_dirty_flag) begin

					next_state = HALT;
				end
				else if (found_dirty_flag) begin 
					next_state = FLUSH_WORD1;
				end
				else begin
					next_state = FIND_DIRTY;
				end
			end
			
			FLUSH_WORD1: begin
				if(ccif.ccwait) begin
					next_state = SNOOP;
				end
				else if (ccif.dwait == 0) begin
					next_state = FLUSH_WORD2;
				end
				else begin
					next_state = FLUSH_WORD1; 
				end
			end

			FLUSH_WORD2: begin
				if (ccif.dwait == 0) begin
					next_state = FIND_DIRTY;
				end
				else begin
					next_state = FLUSH_WORD2;
				end
			end
		
			HITCOUNT: begin
				if(ccif.dwait == 0) begin
					next_state = FIND_DIRTY;
				end
				else begin
					next_state = HITCOUNT;
				end
			end

			TRASH_INVALID: begin
				next_state = IDLE;
			end

			HALT: begin
				next_state = HALT;
			end

			//default: next_state = IDLE;
		endcase
	end

	logic [3:0] j;
	//connect system.halt to datapath.flush

	//output logic
	always_comb begin
		nxt_tag1 = WAY1[daddr.idx].tag;
		nxt_tag2 =  WAY2[daddr.idx].tag;
		nxt_LRU1 = WAY1[daddr.idx].LRU;
		nxt_LRU2 = WAY2[daddr.idx].LRU;
		nxt_dirty1 = WAY1[daddr.idx].dirty;
		nxt_dirty2 = WAY2[daddr.idx].dirty;
		nxt_valid1 = WAY1[daddr.idx].valid;
		nxt_valid2 = WAY2[daddr.idx].valid;
		//Initializations
		nxt_flush_index = flush_index;
		found_dirty_flag = 1; //not sure
		nxt_choose_flushBLK = choose_flushBLK;
		// initialize enables for words
		writeB1W1 = 0;
		writeB1W2 = 0;
		writeB2W1 = 0;
		writeB2W2 = 0;
		abdul_flush = 0;

		nxt_BLK1flag = BLK1flag;
		nxt_BLK2flag = BLK2flag;
		nxt_hit_flag = hit_flag;

		dcif.dmemload = 0;
		ccif.dstore = 0;
		ccif.dREN = 0;
		ccif.dWEN = 0;				
		ccif.daddr = 0;
		dcif.dhit = 0;
		nextword = 0;
		j =0;
		//next_count = count;
		next_miss = miss;

		ccif.ccwrite = 0;
		ccif.cctrans = 0;
		
		snoop_flag = 0;

		//CCTrans Logic
				
		/*if((WAY1[daddr.idx].valid && !WAY1[daddr.idx].dirty && dcif.dmemWEN) || (WAY2[daddr.idx].valid && !WAY2[daddr.idx].dirty && dcif.dmemWEN)) begin //Shared state
			ccif.cctrans = 1;
		end
		else if((!WAY1[daddr.idx].valid && !WAY1[daddr.idx].dirty && dcif.dmemWEN) || (!WAY2[daddr.idx].valid && !WAY2[daddr.idx].dirty && dcif.dmemWEN)) begin //Invalid
			ccif.cctrans = 1;
		end     
		else if((!WAY1[daddr.idx].valid && !WAY1[daddr.idx].dirty && dcif.dmemREN) || (!WAY2[daddr.idx].valid && !WAY2[daddr.idx].dirty && dcif.dmemREN)) begin //Invalid     
			ccif.cctrans = 1;
		end
		else begin
			ccif.cctrans = 0;
		end*/

		casez (curr_state)
			IDLE: begin
				dcif.dmemload = 0;
				ccif.dstore = 0;
				ccif.dREN = 0;
				ccif.dWEN = 0;				
				ccif.daddr = 0;
				dcif.dhit = 0;
				nxt_hit_flag = 1;
				//ccif.ccwrite = 0; //Default to 0				
				ccif.cctrans = 0;
				if (dcif.dmemREN == 1'b1) begin
					
					dcif.dhit = (((WAY1[daddr.idx].tag == daddr.tag && WAY1[daddr.idx].valid == 1) || (WAY2[daddr.idx].tag == daddr.tag && WAY2[daddr.idx].valid == 1)) && !ccif.ccwait) ? 1: 0; //NEED CCWAIT PROBABLY
					
					if(chooseBLK1) begin
						if(chooseWORD1) begin
							dcif.dmemload = WAY1[daddr.idx].word1;
						end
						else begin
							dcif.dmemload = WAY1[daddr.idx].word2;
						end
					end
					else begin
						if(chooseWORD1) begin
							dcif.dmemload = WAY2[daddr.idx].word1;
						end
						else begin
							dcif.dmemload = WAY2[daddr.idx].word2;
						end
					end
					
				end
				else if (dcif.dmemWEN == 1'b1) begin //THERE SHOULD BE ELSE CASE TO AVOID COMBINATIONAL FEEDBACK LOOP ALTHOUGH IT'S INITIALIZED SO MIGHT BE FINE  
					//ccif.cctrans = 1;
				
					dcif.dhit = (((WAY1[daddr.idx].tag == daddr.tag) && (WAY1[daddr.idx].dirty) && WAY1[daddr.idx].valid) || ((WAY2[daddr.idx].tag == daddr.tag) && (WAY2[daddr.idx].dirty) && WAY2[daddr.idx].valid) && !ccif.ccwait) ? 1: 0;
					
					if((WAY1[daddr.idx].valid && WAY1[daddr.idx].dirty && chooseBLK1) || (WAY2[daddr.idx].valid && WAY2[daddr.idx].dirty && chooseBLK2)) begin
						nextword = dcif.dmemstore;
						writeB1W1 = (chooseBLK1 && chooseWORD1);
						writeB1W2 = (chooseBLK1 && chooseWORD2);
						writeB2W1 = (chooseBLK2 && chooseWORD1);
						writeB2W2 = (chooseBLK2 && chooseWORD2);
						if (chooseBLK1 && (WAY1[daddr.idx].tag == daddr.tag)) begin
							nxt_dirty1 = 1; //ONLY UPON A STORE
						end
						else if(chooseBLK2 && (WAY2[daddr.idx].tag == daddr.tag))begin
							nxt_dirty2 = 1;
						end  //Moved to miss 2
					end
					
				end
			end

			SNOOP: begin

				nxt_dirty1 = WAY1[saddr.idx].dirty;
				nxt_dirty2 = WAY2[saddr.idx].dirty;
				nxt_valid1 = WAY1[saddr.idx].valid;
				nxt_valid2 = WAY2[saddr.idx].valid;

				snoop_flag = 1;

				if(snoop_hit) begin //SUS
					if(snoopBLK1) begin
						if(WAY1[saddr.idx].valid && WAY1[saddr.idx].dirty) begin
							ccif.ccwrite = 1;
							ccif.cctrans = 0; //So on coherence controller we go to writeback stage
						end
						else if(WAY1[saddr.idx].valid && !WAY1[saddr.idx].dirty) begin //Shared and BUSRdx
							ccif.ccwrite = 0;
							ccif.cctrans = 1;
							//nxt_valid1 = 0; //Unsure if it should be done here
						end
						else if(!WAY1[saddr.idx].valid) begin
							ccif.ccwrite = 0;
							ccif.cctrans = 1;
						end
						else begin
							ccif.ccwrite = 0;
							ccif.cctrans = 0;
						end
					end
					else begin
						if(WAY2[saddr.idx].valid && WAY2[saddr.idx].dirty) begin
							ccif.ccwrite = 1;
							ccif.cctrans = 0; //So on coherence controller we go to writeback stage
						end
						else if(WAY2[saddr.idx].valid && !WAY2[saddr.idx].dirty) begin //Shared and BUSRdx
							ccif.ccwrite = 0;
							ccif.cctrans = 1;
							//nxt_valid2 = 0;
						end
						else if(!WAY2[saddr.idx].valid) begin
							ccif.ccwrite = 0;
							ccif.cctrans = 1;
						end
						else begin
							ccif.ccwrite = 0;
							ccif.cctrans = 0;
						end
					end
				end
				else begin
					ccif.cctrans = 1; //CC trans set to 1 to go forward in coherence controller state machine 
					ccif.ccwrite = 0;
				end
				
			end

			SNOOP_WB1: begin
				snoop_flag = 1;
				ccif.dWEN = 1;
				ccif.ccwrite = 1;

				nxt_dirty1 = WAY1[saddr.idx].dirty;
				nxt_dirty2 = WAY2[saddr.idx].dirty;
				nxt_valid1 = WAY1[saddr.idx].valid;
				nxt_valid2 = WAY2[saddr.idx].valid;

				if(snoopBLK1) begin
					ccif.dstore = WAY1[saddr.idx].word1;
					ccif.daddr = {WAY1[saddr.idx].tag, saddr.idx, 3'b000}; 
				end
				else begin
					ccif.dstore = WAY2[saddr.idx].word1;
					ccif.daddr = {WAY2[saddr.idx].tag, saddr.idx, 3'b000};
				end	
			end

			SNOOP_WB2: begin //word 2
				snoop_flag = 1;
				ccif.dWEN = 1;
				ccif.ccwrite = 1;
				nxt_dirty1 = WAY1[saddr.idx].dirty;
				nxt_dirty2 = WAY2[saddr.idx].dirty;
				nxt_valid1 = WAY1[saddr.idx].valid;
				nxt_valid2 = WAY2[saddr.idx].valid;

				if(snoopBLK1) begin
					ccif.dstore = WAY1[saddr.idx].word2;
					ccif.daddr = {WAY1[saddr.idx].tag, saddr.idx, 3'b000} + 4; // offset by 1 address location for writing the second word
					nxt_dirty1 = 0;
				end
				else begin	
					ccif.dstore = WAY2[saddr.idx].word2;
					ccif.daddr = {WAY2[saddr.idx].tag, saddr.idx, 3'b000} + 4;
					nxt_dirty2 = 0;
				end
			end

			TRASH0: begin
				
				snoop_flag = 1;
			end

			TRASH1: begin //Variable latency
				snoop_flag = 1;
			end

			INVALIDATE: begin
				snoop_flag = 1;
				if(ccif.ccinv) begin
					if(snoopBLK1) begin
						nxt_valid1 = 0;
					end
					else begin
						nxt_valid2 = 0;
					end
				end			
			end
			
			WRITE_BACK1: begin //unset dirty bit
				ccif.dWEN = 1;
				//ccif.ccwrite = 1;
				if(WAY1[daddr.idx].LRU == 1) begin
					ccif.dstore = WAY1[daddr.idx].word1;
					ccif.daddr = {WAY1[daddr.idx].tag, daddr.idx, 3'b000}; 
				end
				else begin
					ccif.dstore = WAY2[daddr.idx].word1;
					ccif.daddr = {WAY2[daddr.idx].tag, daddr.idx, 3'b000};
				end
			end
			
			WRITE_BACK2: begin //word 2
				ccif.dWEN = 1;
				//ccif.ccwrite = 1;
				if(WAY1[daddr.idx].LRU == 1) begin
					ccif.dstore = WAY1[daddr.idx].word2;
					ccif.daddr = {WAY1[daddr.idx].tag, daddr.idx, 3'b000} + 4; // offset by 1 address location for writing the second word
					nxt_dirty1 = 0;
				end
				else begin	
					ccif.dstore = WAY2[daddr.idx].word2;
					ccif.daddr = {WAY2[daddr.idx].tag, daddr.idx, 3'b000} + 4;
					nxt_dirty2 = 0;
				end
			end

			MISS1: begin
				ccif.dREN = 1;
				
				ccif.daddr = dcif.dmemaddr;//{dcif.dmemaddr[31:3], 3'b000};
				nextword = ccif.dload;
				ccif.cctrans = 1;

				if(dcif.dmemWEN) begin
					ccif.ccwrite = 1;
				end
				//next_miss = miss + 1;

			      	// straight to miss read -> in this case, take the least recently used block to replace
			      		if(WAY1[daddr.idx].LRU == 1) begin
						if(!ccif.dwait) begin
					 		nxt_tag1 = daddr.tag;
							//if(chooseWORD1) begin
							writeB1W1 = 1;
							//end
							/*else begin
								writeB1W2 = 1;
							end*/
						 	nxt_LRU1 = 0;
						 	nxt_LRU2 = 1;
						 	nxt_valid1 = 1;
						 	nxt_BLK1flag = 1;
						end
				    	end
				    	else begin
						if(!ccif.dwait) begin
							nxt_tag2 = daddr.tag;
							writeB2W1 = 1;
					 		nxt_LRU1 = 1;
					 		nxt_LRU2 = 0;
					 		nxt_valid2 = 1;
					 		nxt_BLK2flag = 1;
						end
				    	end 		
			end

			MISS2: begin //word2
				ccif.dREN = 1;
				ccif.cctrans = 1;

				if(dcif.dmemWEN) begin
					ccif.ccwrite = 1;
				end

				
				ccif.daddr = {dcif.dmemaddr[31:3],~dcif.dmemaddr[2], 2'b00};
				

		
				nextword = ccif.dload;
				if (ccif.dwait == 0) begin
					next_miss = miss + 1;
				end
				if(BLK1flag == 1) begin
					if(!ccif.dwait) begin
						writeB1W2 = 1;
						nxt_BLK1flag = 0;
					end
				end 
				else begin
					if(!ccif.dwait) begin
						writeB2W2 = 1;
						nxt_BLK2flag = 0;
					end
				end
			end

			WRITE_MISS1: begin
				ccif.dREN = 1;
				//if(daddr.blkoff) begin				
				//	ccif.daddr = dcif.dmemaddr-4;
				//end else begin
				ccif.daddr = dcif.dmemaddr;
				//end

				//nextword = ccif.dload; //NEW
				ccif.cctrans = 1;

				if(dcif.dmemWEN) begin
					ccif.ccwrite = 1;
				end
				//next_miss = miss + 1;

			      	// straight to miss read -> in this case, take the least recently used block to replace
			      		/*if(chooseBLK1) begin
						
						if(!ccif.dwait) begin
					 		nxt_tag1 = daddr.tag;
							
							//writeB1W1 = 1; //NEW
							
							
						 	nxt_LRU1 = 0;
						 	nxt_LRU2 = 1;
						 	nxt_valid1 = 1;
						 	nxt_BLK1flag = 1;
						end
				    	end
				    	else begin
						
						if(!ccif.dwait) begin
							nxt_tag2 = daddr.tag;

							//writeB2W1 = 1;
						
					 		nxt_LRU1 = 1;
					 		nxt_LRU2 = 0;
					 		nxt_valid2 = 1;
					 		nxt_BLK2flag = 1;
						end
				    	end 	*/	
			end

			WRITE_MISS2: begin //word2
				ccif.dREN = 1;
				ccif.cctrans = 1;


				ccif.daddr = {dcif.dmemaddr[31:3],~dcif.dmemaddr[2], 2'b00};

				if(dcif.dmemWEN) begin
					ccif.ccwrite = 1;
				end
				
				nextword = dcif.dmemstore;
				if (ccif.dwait == 0) begin
					next_miss = miss + 1;
				end
				if(chooseBLK1) begin
					nxt_dirty1 = 1;
					if(!ccif.dwait) begin
						if(daddr.blkoff) begin
							writeB1W2 = 1;
							nxt_BLK1flag = 0;
						end
						else begin
							writeB1W1 = 1;
							nxt_BLK1flag = 0;
						end
					end
				end 
				else begin
					nxt_dirty2 = 1;	
					if(!ccif.dwait) begin
						if(daddr.blkoff) begin
							writeB2W2 = 1;
							nxt_BLK2flag = 0;
						end
						else begin
							writeB1W1 = 1;
							nxt_BLK2flag = 0;
						end
					end
				end
			end

			TRASH_INVALID: begin
				ccif.daddr = {dcif.dmemaddr[31:3],~dcif.dmemaddr[2], 2'b00};
				ccif.cctrans = 1;
				if(dcif.dmemWEN) begin
					ccif.ccwrite = 1;
				end
			end

			FIND_DIRTY: begin
				found_dirty_flag = 0; //THIS IS FLUSHED
				for(j = 0; j < 8; j++) begin
					if(WAY1[j].dirty) begin
						nxt_flush_index = j;
						nxt_choose_flushBLK = 0; //Block1 is 0 & Block2 is 1
						found_dirty_flag = 1;
					end
				end

				for(j = 0; j < 8; j++) begin
					if(WAY2[j].dirty) begin
						nxt_flush_index = j;
						nxt_choose_flushBLK = 1;
						found_dirty_flag = 1;
					end
				end
	
			end

			FLUSH_WORD1: begin
				ccif.ccwrite = 1;
				ccif.dWEN = 1;
				if(choose_flushBLK == 0) begin
					ccif.dstore = WAY1[flush_index].word1;
					ccif.daddr = {WAY1[flush_index].tag, flush_index, 3'b000}; 
				end
				else begin
					ccif.dstore = WAY2[flush_index].word1;
					ccif.daddr = {WAY2[flush_index].tag, flush_index, 3'b000};
				end
			end

			FLUSH_WORD2: begin //word 2
				ccif.ccwrite = 1;
				ccif.dWEN = 1;
				abdul_flush = 1;
				if(choose_flushBLK == 0) begin
					ccif.dstore = WAY1[flush_index].word2;
					ccif.daddr = {WAY1[flush_index].tag, flush_index, 3'b000} + 4; // offset by 1 address location for writing the second word
					nxt_dirty1 = 0;
					
				end
				else begin	
					ccif.dstore = WAY2[flush_index].word2;
					ccif.daddr = {WAY2[flush_index].tag, flush_index, 3'b000} + 4;
					nxt_dirty2 = 0;
				end
			end

			HITCOUNT: begin
				//if(hit_flag) begin
					ccif.dWEN = 1;
					ccif.dstore = count - miss;
					ccif.daddr = 32'h3100;	
					nxt_hit_flag = 0;		
				//end
			end

			HALT: begin
				dcif.dmemload = 0;
				ccif.dstore = 0;
				ccif.dREN = 0;
				ccif.dWEN = 0;				
				ccif.daddr = 0;
				ccif.cctrans = ccif.ccwait;
			end

		endcase
	end

	logic [3:0] i;
	always_ff @ (posedge CLK, negedge nRST) begin
		if (!nRST) begin
			curr_state <= IDLE;
			/*for(i = 0; i < 8; i++) begin
				WAY1[i].valid <= '{default:'0};
				WAY2[i].valid <= '{default:'0};
				WAY1[i].dirty <= '{default:'0};
				WAY2[i].dirty <= '{default:'0};
				WAY1[i].word1 <= '{default:'0};
				WAY1[i].word2 <= '{default:'0};
				WAY2[i].word1 <= '{default:'0};
				WAY2[i].word2 <= '{default:'0};
				WAY1[i].tag <= '{default:'0};
				WAY2[i].tag <= '{default:'0};
				WAY1[i].LRU <= 1;
				WAY2[i].LRU <= 0;
			end*/
			WAY1 <= '0;
			WAY2 <= '0;
			WAY1[0].LRU <= 1;
			WAY1[1].LRU <= 1;
			WAY1[2].LRU <= 1;
			WAY1[3].LRU <= 1;
			WAY1[4].LRU <= 1;
			WAY1[5].LRU <= 1;
			WAY1[6].LRU <= 1;
			WAY1[7].LRU <= 1;
			//WAY1[0].LRU <= 1;
			BLK1flag <= 0;
			BLK2flag <= 0;
			flush_index <= 0;
			choose_flushBLK <= 0;
			count <= '0;
			miss <= '0;
			//found_dirty_flag <= 1;
			hit_flag <= 1; 
		end
		else begin
			curr_state <= next_state;
			if(!snoop_flag) begin
				WAY1[daddr.idx].valid <= nxt_valid1; 
				WAY2[daddr.idx].valid <= nxt_valid2;
			end
			else begin
				WAY1[saddr.idx].valid <= nxt_valid1;
				WAY2[saddr.idx].valid <= nxt_valid2;
			end
			
			WAY1[daddr.idx].LRU <= nxt_LRU1; // one has to be used less recently than the other
			WAY2[daddr.idx].LRU <= nxt_LRU2;
            		WAY1[daddr.idx].tag <= nxt_tag1;
		    	WAY2[daddr.idx].tag <= nxt_tag2;

	
			if(snoop_flag) begin
				WAY1[saddr.idx].dirty <= nxt_dirty1;
				WAY2[saddr.idx].dirty <= nxt_dirty2;
			end
			else if(abdul_flush) begin
				WAY1[flush_index].dirty <= nxt_dirty1;
				WAY2[flush_index].dirty <= nxt_dirty2;
			end
			else begin
				WAY1[daddr.idx].dirty <= nxt_dirty1;
				WAY2[daddr.idx].dirty <= nxt_dirty2;
			end
		
			BLK1flag <= nxt_BLK1flag;
			BLK2flag <= nxt_BLK2flag;
			count <= next_count;
			miss <= next_miss;
			hit_flag <= nxt_hit_flag;


			flush_index <= nxt_flush_index;
			choose_flushBLK <= nxt_choose_flushBLK;
			//found_dirty_flag <= nxt_found_dirty_flag;
		   	
			// block word next state goes here only upon writing
			if(writeB1W1) begin
				WAY1[daddr.idx].word1 <= nextword;
			end
			if(writeB1W2) begin
				WAY1[daddr.idx].word2 <= nextword;
			end
			if(writeB2W1) begin
				WAY2[daddr.idx].word1 <= nextword;
			end
			if(writeB2W2) begin
				WAY2[daddr.idx].word2 <= nextword;
			end		   		
		end
	end


// IDLE -> Check read or write, check dhit. If read hit, send data to CPU, update LRU. If write hit, write to block, set dirty bit, update LRU. Read miss, go to MISS_READ
// MISS_READ -> request memory, choose replacement victim based on LRU, return data to CPU upon reply, replace victim and 


endmodule
