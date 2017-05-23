#---------------------------------------
# Count Days
#---------------------------------------

# set the address where you want this
# code segment
  org 0x0000

  ori $29, $0, 0xFFFC
  
  #Days = CurrentDay+(30*(CurrentMonth-1))+365*(CurrentYear-2000)  

  #Constants
  ori $2, $0, 30 
  ori $3, $0, 365 
  #ori $4, $0, 2000

  #Variables
  ori $5, $0, 6 #Day {1..31}
  ori $6, $0, 1 #Month {1..12}
  ori $7, $0, 2017 #Year

  #Executions
  addi $8, $6, -1 //Month block
  addi $9, $7, -2000 //Year block

  #Temp regs for blocks
  ori $10, $0, 0 #MONTH FINAL
  
  ori $11, $0, 0 #YEAR FINAL

  MONTH:
	 add $10, $10, $8
	 addi $2, $2, -1
	 bne $2, $0, MONTH

  YEAR:
	add $11, $11, $9
	addi $3, $3, -1
	bne $3, $0, YEAR

  ori $12, $0, 0
  
  add $12, $10, $5

  ori $13, $0, 0

  add $13, $12, $11 #Final answer in register 13


  halt	
