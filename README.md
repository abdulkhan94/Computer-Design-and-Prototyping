# Computer Design & Prototyping  

## Introduction  
Over the course of this class we have designed, developed and implemented a Single cycle design, Pipeline
design and a Multicore design. Some advantages of the Single cycle design are that it is simple to design and
since there is less combinational logic it is easier to implement however compared to Pipeline design it lacks in
efficiency and performance. This is because in Single cycle, every instruction regardless of how complex it is,
will require the same amount of time. Due to this the processors clock is dependent on how slow the longest
instruction takes. In comparison, with a pipeline processor you have a higher throughput because you can queue
instructions and the critical path is lower because it is broken up into several stages. After we finished working
on the pipelined processor we developed a cache interface. This was an important step in boosting the
performance because constantly accessing memory slows down the system and with locality caches provide
quicker access. Although it adds more logic blocks and requires more resources the pros definitely outweigh the
cons. Moving on, after our pipelined processor with caches was implemented we started working on a multicore
processor with shared memory. It makes sense to improve performance with two cores since improving the
clock by a factor of 2 would increase the power usage by a factor of 8, but with two cores running at the same
clock would only increase the power usage by a factor of 2. So with 2 cores we were able to deal with twice as
many instructions as before which boosts performance and to make sure there are no synchronization errors
between cores in the memory we had to develop a coherency controller.

Finally, to benchmark the performance of the two processors we have selected to run dual.mergesort.asm as it
will cover most metrics a processor should meet. There are a total of 5399 instructions and it tests plenty of I
type, J type and R type instructions. Furthermore, dual.mergesort.asm introduces many hazards, some which
have to be stalled and some which require forwarding, so it properly tests the functionality for the hazard and
forwarding unit in the pipelined processors as well as cache coherency.

Please refer to the mg258_finalreport.pdf for more information on the design as well the detailed structure of all the blocks. 

## Current Status  
* Fully functional single cycle processor.
* Fully functional pipelined processor with hazard and forwarding unit.
* Fully functional data and instruction cache.
* Fully functional shared memory dual core processor with MSI for cache coherency
