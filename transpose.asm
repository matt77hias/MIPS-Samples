.data
original:	.asciiz "The original matrix"
transposed:	.asciiz	"The transposed matrix"
endofline:	.asciiz "\n"

.text
main:
li $s3, 4
move $a0, $s3
jal data
move $s2, $v0

li $v0, 4
la $a0, original
syscall
li $v0, 4
la $a0, endofline
syscall

move $a0, $s2
move $a1, $s3
jal print
li $v0, 4
la $a0, endofline
syscall

move $a0, $s2
move $a1, $s3
jal transpose

li $v0, 4
la $a0, transposed
syscall
li $v0, 4
la $a0, endofline
syscall

move $a0, $s2
move $a1, $s3
jal print
li $v0, 4
la $a0, endofline
syscall

li $v0, 10
syscall

#######################

data:
move $t0, $zero
lui $t2, 0x1001
add $t2, $t2, 100
move $v0, $t2

mult $a0, $a0
mflo $a0

dataloop:
beq $a0, $zero enddata
sw $t0, 0($t2)
addi $t0, $t0, 1
addi $t2, $t2, 4
addi $a0, $a0, -1
j dataloop
enddata: 
jr $ra

#######################

transpose:
addi $t0, $a1, -1
move $t1, $t0

li $t8, -1
rowloop:
beq $t0, $t8, endrowloop
addi $t1, $t0, -1
columnloop:
beq $t1, $t8, endcolumnloop

mult $t0, $a1
mflo $t2
add $t2, $t2, $t1
sll $t2, $t2, 2
add $t2, $t2, $a0
lw $t4, 0($t2)

mult $t1, $a1
mflo $t3
add $t3, $t3, $t0
sll $t3, $t3, 2
add $t3, $t3, $a0
lw $t5, 0($t3)

sw $t4, 0($t3)
sw $t5, 0($t2)

addi $t1, $t1, -1
j columnloop

endcolumnloop:
addi $t0, $t0, -1
j rowloop

endrowloop:
jr $ra

#######################

print:
move $s0, $a0
move $s1, $a1

mult $a1, $a1
mflo $t0

printloop:
beq $t0, $zero, endprintloop

div $t0, $s1
mfhi $t1
bne $t1, $zero, afterrowend
la $a0, endofline
li $v0, 4
syscall

afterrowend:
lw $a0, 0($s0)
li $v0, 1
syscall

addi $t0, $t0, -1
addi $s0, $s0, 4
j printloop

endprintloop:
jr $ra

#######################