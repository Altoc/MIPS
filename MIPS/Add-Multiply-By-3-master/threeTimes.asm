# Starter code for threeTimes.asm
# Put in comments your name and date please.  You will be
# revising this code.
#
# Ian Whitesel
# 09/25/2018
# 
# This code displays the authors name (you must change
# outpAuth to display YourFirstName and YourLastName".
#
# The code then prompts the user for 3 integer values.
# The code outputs the summation of these 3 values multiplied by 3.
#
# In MARS, make certain in "Settings" to check
# "popup dialog for input syscalls 5,6,7,8,12"
#
            .data      # data segment
	    .align 2   # align the next string on a word boundary
outpAuth:   .asciiz  "This is Ian Whitesel presenting threeTimes.\n"
outpPrompt: .asciiz  "Please enter an integer: "
	    .align 2   #align next prompt on a word boundary
outpStr:    .asciiz  "The sum of your numbers multiplied by 3 is: "
            .align 2   # align users input on a word boundary
#
# main begins
            .text      # code section begins
            .globl	main 
main:  
###############################################################
# system call to display the author of this code
	 la $a0,outpAuth	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall	

#
# system call to prompt user for input
	 la $a0,outpPrompt	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall	

	li $v0, 5		#get user number
	syscall
	add $t0, $v0, $zero	#move user num in v0 to t0

	 la $a0,outpPrompt	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall
	
	li $v0, 5		#get user number
	syscall
	add $t1, $v0, $zero	#move user num in v0 to t1

	
	 la $a0,outpPrompt	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall

	li $v0, 5		#get user number
	syscall
	add $t2, $v0, $zero	#move user num in v0 to t2

#
# system call to display "The sum of your numbers multiplied by 3 is: "
	 la $a0,outpStr 	# system call 4 for print string needs address of string in $a0
	 li $v0,4		# system call 4 for print string needs 4 in $v0
	 syscall  	
################################################################
# write a system call to display the calculation

	add $t0, $t0, $t1	#add first num and second num
	add $t0, $t0, $t2	#add result of first num and second num to third num
	li $t3, 3		#load immediate the value of 3 into register t3
	mul $t0, $t0, $t3	#multiply t0 and t3
	add $a0, $t0, $zero	#move result of multiplication to a0
	li $v0, 1		#print a0
	syscall
#
# Exit gracefully
         li   $v0, 10       # system call for exit
         syscall            # close file
###############################################################
