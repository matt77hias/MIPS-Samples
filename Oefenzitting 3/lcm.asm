.text
main:
addi $a0, $zero, 7
addi $a1, $zero, 11
jal lcm

add $a0, $zero, $v0
li $v0, 1
syscall
li $v0, 10
syscall

lcm:
# mul $t0, $a0, $a1
mult $a0, $a1
mflo $t0

addi $sp, $sp, -8
sw $ra, 4($sp)
sw $t0, 0($sp)
jal gcd
lw $t0, 0($sp)
lw $ra, 4($sp)
addi $sp, $sp, 8

div $t0, $v0
mflo $v0
jr $ra

gcd:
beq $a0, $a1, end
slt $t0, $a0, $a1
bne $t0, $zero, other

addi $sp, $sp, -4
sw $ra, 0($sp)
sub $a0, $a0, $a1
jal gcd
lw $ra, 0($sp)
addi $sp, $sp, 4
jr $ra

other:
add $t1, $zero, $a1
add $a1, $zero, $a0
add $a0, $zero, $t1

addi $sp, $sp, -4
sw $ra, 0($sp)
jal gcd
lw $ra, 0($sp)
addi $sp, $sp, 4
jr $ra

end:
add $v0, $zero, $a0
jr $ra


