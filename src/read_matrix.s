.globl read_matrix

.text
# ==============================================================================
# FUNCTION: Allocates memory and reads in a binary file as a matrix of integers
#
# FILE FORMAT:
#   The first 8 bytes are two 4 byte ints representing the # of rows and columns
#   in the matrix. Every 4 bytes afterwards is an element of the matrix in
#   row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is a pointer to an integer, we will set it to the number of rows
#   a2 (int*)  is a pointer to an integer, we will set it to the number of columns
# Returns:
#   a0 (int*)  is the pointer to the matrix in memory
# Exceptions:
# - If malloc returns an error,
#   this function terminates the program with error code 88.
# - If you receive an fopen error or eof, 
#   this function terminates the program with error code 90.
# - If you receive an fread error or eof,
#   this function terminates the program with error code 91.
# - If you receive an fclose error or eof,
#   this function terminates the program with error code 92.
# ==============================================================================
read_matrix:
    addi sp, sp, -28
    # Prologue
    sw ra, 0(sp)
	sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)
    sw s3, 16(sp)
    sw s4, 20(sp)
    sw s5, 24(sp)
    
    #save args into s0-s2
    mv s0, a0
    mv s1, a1
    mv s2 ,a2
    
    #args for fopen
    mv a1, s0       #path
    li a2, 0        #permission
    jal ra, fopen   
    #fopen error
    addi t0, x0, -1
    beq t0, a0, exit_90
    
    mv s3, a0       #save descriptor into s3
    
    mv a1, s3       #read rows and cols
    mv a2, s1
    li a3, 4
    jal fread
    #fread error
    li t1, 4
    bne a0, t1, exit_91
    mv a2, s2
    jal fread
    #fread error
    li t1, 4
    bne a0, t1, exit_91
    
    lw t0, 0(s1)
    lw t1, 0(s2)
    mul t0, t0, t1
    mv s4, t0           #number of elements
    addi t1, x0, 4
    mul a0, t0, t1      #bytes of matrix
    jal ra, malloc
    #malloc error
    beq a0, x0, exit_88
    
    mv s5, a0           #pointer to the buffer
    add t0, x0, x0
    jal ra, loop_start
    
    mv a1, s3
    jal ra, fclose
    #fclose error
    bne a0, x0, exit_92
        
    mv a0, s5           #set return value
    
    # Epilogue
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    lw s3, 16(sp)
    lw s4, 20(sp)
    lw s5, 24(sp)
    addi sp, sp, 28
    ret

loop_start:
    beq t0, s4, loop_end
    addi sp, sp, -8
    sw ra, 0(sp)
    sw t0, 4(sp)
    mv a1, s3
    addi t1, x0, 4
    mul t1, t0, t1
    add a2, s5, t1
    li a3, 4
    jal fread
    #fread error
    li a3, 4
    bne a0, a3, exit_91
    lw ra, 0(sp)
    lw t0, 4(sp)
    addi sp, sp, 8
    addi t0, t0, 1
    j loop_start
    
loop_end:
    ret

exit_88:
    li a1, 88
    j exit2

exit_90:
    li a1, 90
    j exit2

exit_91:
    li a1, 91
    j exit2

exit_92:
    li a1, 92
    j exit2
