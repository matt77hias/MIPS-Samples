.data 0x10000000
key:     .asciiz "Enter the key: "
value: .asciiz "Enter the value: "
endline: .asciiz "\n"
node:     .asciiz "Node: "
keyvalue:         .asciiz " Key value: "
char: .asciiz " Char: "
nextnode:      .asciiz " Next node: "
start: .asciiz "Start"
endstring: .asciiz "End"

.text
main:
addi $sp, $sp, -12
add $s0, $zero, $zero
lui $s1, 0x1001
add $s2, $zero, $zero
jal mainmethod
li $v0, 10
addi $sp, $sp, 12
syscall

mainmethod:
add $t0, $zero, $zero
add $t2, $zero, $zero

li $v0, 4
la $a0, key
syscall
li $v0, 5
syscall
add $t4, $zero, $v0
li $v0, 4
la $a0, endline
syscall

addi $t5, $zero, -1

mainwhile:
beq $t4, $t5, aftermainwhile
addi $sp, $sp, -16
sw $ra, 12($sp)
sw $t0, 8($sp)
sw $t2, 4($sp)
sw $t4, 0($sp)
#addiu $a0, $zero, 108
jal mymalloc
add $t1, $zero, $v0
lw $t4, 0($sp)
lw $t2, 4($sp)
lw $t0, 8($sp)
lw $ra, 12($sp)
addi $sp, $sp, 16

bne $t0, $zero, next
add $t0, $zero, $t1

next:
sw $t4, 0($t1)

li $v0, 4
la $a0, value
syscall
li $v0, 8
addiu $t8, $t1, 4
addu $a0, $zero, $t8
li $a1, 100
syscall
li $v0, 4
la $a0, endline
syscall

sw $t2, 104($t1)

li $v0, 4
la $a0, key
syscall
li $v0, 5
syscall
add $t4, $zero, $v0
li $v0, 4
la $a0, endline
syscall

add $t2, $zero, $t1
addi $t5, $zero, -1
j mainwhile

aftermainwhile:
add $t0, $zero, $t1 #aanpassing
#sw $zero, 104($t1)
add $a0, $zero, $t0
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $t0, 0($sp)
jal printout
lw $a0, 0($sp)
addi $sp, $sp, 4
jal mergesort
add $a0, $zero, $v0
jal printout
lw $ra, 0($sp)
addi $sp, $sp, 4
jr $ra

mergesort:
bne $a0, $zero, secondcheck
add $v0, $zero, $a0
jr $ra

secondcheck:
lw $t0, 104($a0)
bne $t0, $zero, mergesortini
add $v0, $zero, $a0
jr $ra

mergesortini:
add $t1, $zero, $a0
add $t2, $zero, $t0

mergesortwhile:
beq $t2, $zero, aftermergesortwhile
lw $t0, 104($t2)
beq $t0, $zero, aftermergesortwhile
lw $a0, 104($a0)
lw $t0, 104($a0)
lw $t2, 104($t0)
j mergesortwhile

aftermergesortwhile:
lw $t2, 104($a0)
sw $zero, 104($a0)

addi $sp, $sp, -8
sw $ra, 4($sp)
sw $t2, 0($sp)
add $a0, $zero, $t1
jal mergesort
lw $a0, 0($sp)
sw $v0, 0($sp)
jal mergesort
lw $a0, 0($sp)
addi $sp, $sp, 4
add $a1, $zero, $v0
jal merge
lw $ra, 0($sp)
addi $sp, $sp, 4
jr $ra

merge:
bne $a0, $zero, secondifcheck
add $v0, $zero, $a0
jr $ra

secondifcheck:
bne $a1, $zero, check
add $v0, $zero, $a1
jr $ra

check:
lw $t1, 0($a0)
lw $t2, 0($a1)
slt $t0, $t1, $t2
beq $t0, $zero, elsecheck
add $t3, $zero, $a0
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $t3, 0($sp)
lw $a0, 104($a0)
jal merge
lw $t3, 0($sp)
lw $ra, 4($sp)
addi $sp, $sp, 8
sw $v0, 104($t3)
j end
elsecheck:
add $t3, $zero, $a1
addi $sp, $sp, -8
sw $ra, 4($sp)
sw $t3, 0($sp)
lw $a1, 104($a1)
jal merge
lw $t3, 0($sp)
lw $ra, 4($sp)
addi $sp, $sp, 8
sw $v0, 104($t3)

end:
add $v0, $zero, $t3
jr $ra

printout:
add $t0, $zero, $a0

li $v0, 4
la $a0, start
syscall
li $v0, 4
la $a0, endline
syscall

printwhile:
beq $t0, $zero, afterprintwhile

li $v0, 4
la $a0, node
syscall
li $v0, 1
add $a0, $zero, $t0
syscall

li $v0, 4
la $a0, keyvalue
syscall
li $v0, 1
lw $a0, 0($t0)
syscall
li $v0, 4
la $a0, char
syscall
li $v0, 11
lw $a0, 4($t0)
syscall

li $v0, 4
la $a0, nextnode
syscall
li $v0, 1
lw $a0, 104($t0)
syscall

li $v0, 4
la $a0, endline
syscall

lw $t0, 104($t0)
j printwhile

afterprintwhile: 
li $v0, 4
la $a0, endstring
syscall
li $v0, 4
la $a0, endline
syscall

jr $ra

mymalloc:
beq $s0, $zero, else
add $t0, $zero, $s0
lw $s0, 104($s0)
j endmalloc

else:
add $t0, $s1, $s2
sw $zero, 104($t0)
addi $s2, $s2, 108

endmalloc:
add $v0, $zero, $t0
jr $ra

free:
sw $s0, 4($a0)
add $s0, $zero, $a0
jr $ra
