#Ian Whitesel
#Ask user for number of floating point values they'd like to have averaged
#Average those FP values into one FP value
#11/13/2018

.data
prompt1:	.asciiz "How many values to average: "
prompt2:	.asciiz "Enter floating-point value: "
result:		.asciiz "The average is: "

	        .text
	        .globl	main
main:  
#Prompt user to enter the number of values they'd like to average
	la $a0, prompt1
	li $v0, 4
	syscall
#Get user number and move it to s0
	li $v0, 5
	syscall
	add $s0, $v0, $zero
#Prompt user to enter their floating-point number
	addi $s3, $sp, 0	#initialize accessor
loop1start:
	la $a0, prompt2
	li $v0, 4
	syscall
#Get user number and move it to f0
	li $v0, 6	#implicitly moves value from $v0 to $f0
	syscall
	
	swc1 $f0, ($s3)  #  store user value into sp + accessor
	
	addi $s3, $s3, 4	#accessor = accessor + 4
	addi $s1, $s1, 1	#iterator++
	bne $s0, $s1, loop1start	#loop if s1 != s0

loop1end:
#Average out user values
	add $s1, $zero, $zero	#set iterator back to 0
	
	addi $s3, $sp, 0	#initialize accessor
	
	lwc1 $f2, ($s3)		#load the first value
	
	addi $s3, $s3, 4	#accessor = accessor + 4
loop2start:
	lwc1 $f3, ($s3)
	add.s $f2, $f2, $f3
	
	addi $s3, $s3, 4	#accessor = accessor + 4
	addi $s1, $s1, 1	#iterator++
	bne $s0, $s1, loop2start	#loop if s1 != s0
loop2end:
	mtc1 $s0, $f11		#move number of values that user input to fp register
  	cvt.s.w $f11, $f11	#convert number of values that user entered into a fp number
  	
  	div.s $f2, $f2, $f11
#message for result
	la $a0, result
	li $v0, 4
	syscall
#display result
  	li $v0, 2
  	mov.s $f12, $f2   # Move contents of register $f2 to register $f12
  	syscall

#Exit
         li   $v0, 10
         syscall
