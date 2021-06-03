# find factorial of n inputted by user
#valid for small values of n

.globl main

.data  #subsequent items are stored in data segment at next available address
# string constants
prompt: .asciiz "Please enter a positve integer: "
result: .asciiz "! = "
newline: .asciiz "\n\n"
#end: .asciiz "Program done."


.text #subsequent items are stored in text segments

#main program
#Register usage: n = $s0  and factorial = $s1

main:
	li $v0, 4      #issue prompt
	la $a0, prompt
	syscall
	
	li $v0, 5   #get n from user
	syscall
	
	move $s0,$v0
	
	
# nFact = factorial(n)   #### returns_$v0 = function(Parameter_$a0) #### 
	move	$a0, $s0		
	jal		factorial
	move	$s1, $v0		#result of factorial stored in $s1
	
#print message 'n! = '	
	li $v0,1 
	move $a0, $s0
	syscall
	
	li $v0, 4
	la $a0, result
	syscall
	
#print n!
	li $v0,1 
	move $a0, $s1
	syscall
	
	li		$v0, 4
	la		$a0, newline
	syscall
	
	li $v0, 10
	syscall
	


factorial:
	bnez	$a0, recur		# recur if n != 0

	li		$v0, 1			# else just return 1
	jr		$ra




# recur(){returns factorial(n-1)}
recur:  

#store result of factorial for each call in the stack
	
# allocate stack frame
	sub		$sp, $sp, 8		
	sw		$ra, 0($sp)		# with return address at 0($sp)
	sw		$a0, 4($sp)		# and n at 4($sp)



# $v0 = factorial(n - 1)
	sub		$a0, $a0, 1		
	jal		factorial

	lw		$ra, 0($sp)		# restore return address
	lw		$a0, 4($sp)		# and n from the stack frame
	
#deallocate stack frame
	add		$sp, $sp, 8
			
# return factorial(n - 1)*n
	mul		$v0, $v0, $a0	        
	jr		$ra
	
	

	### PROGRAM ENDED ###	
	
	
	
	
	
	