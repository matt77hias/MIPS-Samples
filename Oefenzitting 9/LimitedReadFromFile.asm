.data
fin:   .asciiz "testout.txt"      # filename for input
buffer: .asciiz "The string"

.text
li   $v0, 13      	# system call for open file
la   $a0, fin      	# input file name
li   $a1, 0        	# Open for reading (flags are 0: read, 1: write)
li   $a2, 0        	# mode is ignored
syscall            	# open a file (file descriptor returned in $v0)
move $s6, $v0      	# save the file descriptor

# Read file just opened
li   $v0, 14       	# system call for read file
move $a0, $s6      	# file descriptor 
la   $a1, buffer   	# address of buffer from which to write to
li   $a2, 44       	# hardcoded buffer length
syscall            	# write to file

addi $t2, $zero, 4

# Print string from file
la $t0, buffer	
move $t1, $zero	
loop:
lb $a0, 0($t0)
beq $a0, $zero, endloop

div $t1, $t2
mfhi $t3
bne $t3, $zero, nowait

wait:
lb $t5, 0xffff0000
andi $t5, $t5, 1
beq $t5, $zero, wait
lb $s0, 0xffff0004
nowait:
waitToPrint:
lb $t5, 0xffff0008
andi $t5, $t5, 1
beq $t5, $zero, waitToPrint
nowaitToPrint:
sb $a0, 0xffff000c
addi $t0, $t0, 1
addi $t1, $t1, 1
j loop

endloop:
# Close the file 
li   $v0, 16       	# system call for close file
move $a0, $s6      	# file descriptor to close
syscall            	# close file

li $v0, 10
syscall
