.data
fin:   .asciiz "testout.txt"      # filename for output
buffer: .asciiz "The string"

.text
li   $v0, 13       # system call for open file
la   $a0, fin     # output file name
li   $a1, 0        # Open for writing (flags are 0: read, 1: write)
li   $a2, 0        # mode is ignored
syscall            # open a file (file descriptor returned in $v0)
move $s6, $v0      # save the file descriptor

# Read file just opened
li   $v0, 14       # system call for read file
move $a0, $s6      # file descriptor 
la   $a1, buffer   # address of buffer from which to read
li   $a2, 44       # hardcoded buffer length
syscall            # write to file

# Print string from file
li $v0, 4		   # system call for print string
la $a0, buffer		   # string
syscall			   # print string

# Close the file 
li   $v0, 16       # system call for close file
move $a0, $s6      # file descriptor to close
syscall            # close file

li $v0, 10
syscall