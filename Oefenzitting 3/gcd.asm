.text
main:
addi $a0, $zero, 7
addi $a1, $zero, 11
jal gcd

add $a0, $zero, $v0
li $v0, 1
syscall
li $v0, 10
syscall

gcd:
add $t0, $zero, $a0
add $t1, $zero, $a1
slt $t2, $t0, $t1
beq $t2, $zero, loop
add $t0, $zero, $a1
add $t1, $zero, $a0

loop:
div $t0, $t1
mfhi $t2
beq $t2, $zero, end
add $t0, $zero, $t1
add $t1, $zero, $t2
j loop

end:
add $v0, $zero, $t1
jr $ra