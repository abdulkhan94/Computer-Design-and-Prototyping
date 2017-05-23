#---------------------------------------
# Multiply Procedure
#---------------------------------------

# set the address where you want this
# code segment
  org 0x0000

  ori $29, $0, 0xFFFC
  
  ori $2, $0, 2 #Test variables
  push $2

  ori $3, $0, 2
  push $3

  ori $4, $0, 3
  push $4

  ori $5, $0, 2
  push $5

  ori $10, $0, 0 #The accumulator
  ori $15, $0, 3 #The number of inputs for main loop counter


  MAIN: 
	beq $15, $0, EXIT #NOT SURE HOW TO HERE
	pop $11 #Pops first two things on stack to multiply
	pop $12
        ori $10, $0, 0 #Need to set reg 10 back to zero as answer of the last mult was on top of stack
	addi $15, $15, -1
	j MULT

  MULT: 
	add $10, $10, $11
	addi $12, $12, -1
	bne $12, $0, MULT

  MULT_END:
        push $10 #Pushes the result of the last mult to the top of the stack
	j MAIN

  EXIT:
	push $10
	halt


