.globl write_matrix

.text
# ==============================================================================
# FUNCTION: Writes a matrix of integers into a binary file
# FILE FORMAT:
#   The first 8 bytes of the file will be two 4 byte ints representing the
#   numbers of rows and columns respectively. Every 4 bytes thereafter is an
#   element of the matrix in row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is the pointer to the start of the matrix in memory
#   a2 (int)   is the number of rows in the matrix
#   a3 (int)   is the number of columns in the matrix
# Returns:
#   None
# Exceptions:
# - If you receive an fopen error or eof,
#   this function terminates the program with error code 93.
# - If you receive an fwrite error or eof,
#   this function terminates the program with error code 94.
# - If you receive an fclose error or eof,
#   this function terminates the program with error code 95.
# ==============================================================================
write_matrix:
    
    # Prologue
    addi sp, sp, -28
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)
    sw s3, 16(sp)
    sw s4, 20(sp)
    sw s5, 24(sp)
    mv s0, a0       #pointer to file
    mv s1, a1       #pointer to buffer
    mv s2, a2       #rows
    mv s3, a3       #cols
    
    #args for fopen
    mv a1, s0
    addi a2, x0, 1      #write only
    jal fopen
    #fopen error
    addi t0, x0, -1
    beq t0, a0, exit_93
    mv s4, a0           #descriptor
    
    addi sp, sp, -4
    sw s2, 0(sp)
    mv a1, s4
    mv a2, sp
    addi a3, x0, 1
    addi a4, x0, 4
    jal fwrite
    #fwrite error
    addi t0, x0, 1
    bne t0, a0, exit_94
    addi sp, sp, 4
    
    addi sp, sp, -4
    sw s3, 0(sp)
    mv a1, s4
    mv a2, sp
    addi a3, x0, 1
    addi a4, x0, 4
    jal fwrite
    #fwrite error
    addi t0, x0, 1
    bne t0, a0, exit_94
    addi sp, sp, 4
    
    mul s5, s2, s3
    add t0, x0, x0
loop_start:
    beq t0, s5, loop_end
    addi sp, sp, -4
    sw t0, 0(sp)
    mv a1, s4
    addi t1, x0, 4
    mul t1, t1, t0
    add t1, t1, s1
    mv a2, t1       #pointer to the element to be stored
    addi a3, x0, 1
    addi a4, x0, 4
    jal fwrite
    #fwrite error
    addi t1, x0, 1
    bne t1, a0, exit_94
    
    lw t0, 0(sp)
    addi sp, sp, 4
    addi t0, t0, 1
    j loop_start
loop_end:
    mv a1, s4
    jal fclose
    #fclose error
    bne a0, x0, exit_95
    
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

exit_93:
    li a1, 93
    j exit2
    
exit_94:
    li a1, 94
    j exit2
    
exit_95:
    li a1, 95
    j exit2
