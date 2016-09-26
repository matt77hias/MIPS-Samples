.text
main:
addi $a0, $zero, 37
jal prime

add $a0, $zero, $v0
li $v0, 1
syscall
li $v0, 10
syscall

prime:
addi $t2, $zero, 2
add $t0, $zero, $t2
slt $t1, $a0, $t0
beq $t1, $zero, loop
add $v0, $zero, $t2
jr $ra

loop:
addi $t2, $t2, 1
add $t3, $zero, $zero
addi $t4, $zero, 2

loop2:
div $t2, $t4
mfhi $t5
bne $t5, $zero, endloop2
addi $t3, $zero, 1

endloop2:
addi $t4, $t4, 1
bne $t3, $zero, endloop
slt $t1, $t4, $t2
bne $t1, $zero, loop2

primincr:
bne $t3, $zero, endloop
addi $a0, $a0, -1

endloop:
addi $t1, $zero, 1
bne $a0, $t1, loop

end:
add $v0, $zero, $t2
jr $ra

