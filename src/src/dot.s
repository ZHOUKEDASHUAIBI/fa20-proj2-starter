.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 (int*) is the pointer to the start of v0
#   a1 (int*) is the pointer to the start of v1
#   a2 (int)  is the length of the vectors
#   a3 (int)  is the stride of v0
#   a4 (int)  is the stride of v1
# Returns:
#   a0 (int)  is the dot product of v0 and v1
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 75.
# - If the stride of either vector is less than 1,
#   this function terminates the program with error code 76.
# =======================================================
dot:
    addi sp, sp, -20
    # Prologue
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)
    sw s3, 16(sp)
    add s0, a0, x0      #use t0?
    add s1, a1, x0
    add s2, a2, x0      #s2 = length
    add s3, x0, x0      #sum = 0
    addi t0, x0, 1
    blt s2, t0, Exit1
    blt a3, t0, Exit2
    blt a4, t0, Exit2
    addi t1, x0, 4
    mul a3, a3, t1
    mul a4, a4, t1
    add t1, s0, x0
    add t2, s1, x0
    add t0, x0, x0      #set index = 0
loop_start:
    beq t0, s2, loop_end
    lw a0, 0(t1)
    lw a1, 0(t2)
    mul t3, a0, a1
    add s3, s3, t3
    add t1, t1, a3
    add t2, t2, a4
    addi t0, t0, 1
    j loop_start
loop_end:
    add a0, s3, x0
    # Epilogue
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    lw s3, 16(sp)
    addi sp, sp, 20
    ret
Exit1:
    li a1, 75
    j exit2
Exit2:
    li a1, 76
    j exit2
