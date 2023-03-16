.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
# 	d = matmul(m0, m1)
# Arguments:
# 	a0 (int*)  is the pointer to the start of m0 
#	a1 (int)   is the # of rows (height) of m0
#	a2 (int)   is the # of columns (width) of m0
#	a3 (int*)  is the pointer to the start of m1
# 	a4 (int)   is the # of rows (height) of m1
#	a5 (int)   is the # of columns (width) of m1
#	a6 (int*)  is the pointer to the the start of d
# Returns:
#	None (void), sets d = matmul(m0, m1)
# Exceptions:
#   Make sure to check in top to bottom order!
#   - If the dimensions of m0 do not make sense,
#     this function terminates the program with exit code 72.
#   - If the dimensions of m1 do not make sense,
#     this function terminates the program with exit code 73.
#   - If the dimensions of m0 and m1 don't match,
#     this function terminates the program with exit code 74.
# =======================================================
matmul:

    # Error checks

    addi sp, sp, -32
    # Prologue
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)
    sw s3, 16(sp)
    sw s4, 20(sp)
    sw s5, 24(sp)
    sw s6, 28(sp)
    add s0, a0, x0
    add s1, a1, x0
    add s2, a2, x0
    add s3, a3, x0
    add s4, a4, x0
    add s5, a5, x0
    add s6, a6, x0
    bge x0, s1, Exit1
    bge x0, s2, Exit1
    bge x0, s4, Exit2
    bge x0, s5, Exit2
    bne s2, s4, Exit3
    add t0, x0, x0
    add t1, x0, x0
    add t2, x0, x0      #offset of return matrix
outer_loop_start:
    beq t0, s1, outer_loop_end
    jal ra, inner_loop_start
    addi t0, t0, 1
    j outer_loop_start
inner_loop_start:
    beq t1, s5, inner_loop_end
    addi sp, sp, -16
    sw ra, 0(sp)
    sw t0, 4(sp)
    sw t1, 8(sp)
    sw t2, 12(sp)
    mv t3, t0
    mv t4, s2
    mul t3, t3, t4
    slli t3, t3, 2
    add a0, s0, t3       #pointer to v0
    mv t3, t1
    slli t3, t3, 2
    add a1, s3, t3       #pointer to v1
    mv a2, s2            #length of vector
    addi a3, x0, 1       #stride of v0
    mv a4, s5            #stride of v1
    jal dot
    lw ra, 0(sp)
    lw t0, 4(sp)
    lw t1, 8(sp)
    lw t2, 12(sp)
    addi sp, sp, 16
    slli t3, t2, 2
    add t3, t3, s6
    sw a0, 0(t3)
    addi t2, t2, 1
    addi t1, t1, 1
    j inner_loop_start
inner_loop_end:
    add t1, x0, x0
    ret


outer_loop_end:
    add a0, s6, x0
    # Epilogue
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    lw s3, 16(sp)
    lw s4, 20(sp)
    lw s5, 24(sp)
    lw s6, 28(sp)
    addi sp, sp, 32
    ret
Exit1:
    li a1, 72
    j exit2
    
Exit2:
    li a1, 73
    j exit2
    
Exit3:
    li a1, 74
    j exit2
