.globl argmax

.text
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#	element. If there are multiple, return the one
#	with the smallest index.
# Arguments:
# 	a0 (int*) is the pointer to the start of the vector
#	a1 (int)  is the # of elements in the vector
# Returns:
#	a0 (int)  is the first index of the largest element
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 77.
# =================================================================
argmax:
    addi sp, sp, -16
    # Prologue
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)
    add s0, a0, x0
    add s1, a1, x0
    add t0, x0, x0
    lw t2, 0(s0)
    addi t1, x0, 1
    bge s1, t1, loop_start
    li a1, 77
    j exit2
loop_start:
    beq t0, s1, loop_end
    slli t1, t0, 2
    add a0, s0, t1
    lw a1, 0(a0)
    blt t2, a1, loop_continue
    addi t0, t0, 1
    j loop_start
loop_continue:
    add s2, t0, x0
    addi t0, t0, 1
    j loop_start
loop_end:
    add a0, s2, x0
    # Epilogue
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    addi sp, sp, 16
    ret
