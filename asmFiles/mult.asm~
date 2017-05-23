#---------------------------------------
# Multiply
#---------------------------------------

# set the address where you want this
# code segment
  org 0x0000

  ori $29, $0, 0xFFFC

  ori $5, $0, 3
  ori $6, $0, 4

  ori $7, $0, 0 #For the accumulator
	
  push $5 
  push $6

  MULTIPLY: 
	    add $7, $7, $5 #accum = 2+2
	    
	    addi $6, $6, -1 #loop var = 3-1

	    bne $6, $0, MULTIPLY
	  

  push $7 #Final answer which is in the accumulator 
  halt

