.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 (int*) is the pointer to the array
#	a1 (int)  is the # of elements in the array
# Returns:
#	None
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 78.
# ==============================================================================
relu:
    # Prologue
    addi sp, sp, -12
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    addi t0, x0, 1
    blt a1, t0, EXIT
    add s0, a0, x0      #store address of array in s0
    add s1, a1, x0      #store length of array in s1
    add t0, x0, x0
loop_start:
    beq t0, s1, loop_end
    slli t1, t0, 2
    add a0, t1, s0
    lw a1, 0(a0)
    bge a1, x0, loop_continue
    add t1, x0, x0
    sw t1, 0(a0)
    addi t0, t0, 1
    j loop_start
loop_continue:
    addi t0, t0, 1
    j loop_start

loop_end:
    add a0, s0, x0
    add a1, s1, x0
    # Epilogue
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    addi sp, sp, 12
	ret

EXIT:
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    addi sp, sp, 12
    li a1, 78
    j exit2
