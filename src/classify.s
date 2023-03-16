.globl classify

.text
classify:
    # =====================================
    # COMMAND LINE ARGUMENTS
    # =====================================
    # Args:
    #   a0 (int)    argc
    #   a1 (char**) argv
    #   a2 (int)    print_classification, if this is zero, 
    #               you should print the classification. Otherwise,
    #               this function should not print ANYTHING.
    # Returns:
    #   a0 (int)    Classification
    # Exceptions:
    # - If there are an incorrect number of command line args,
    #   this function terminates the program with exit code 89.
    # - If malloc fails, this function terminats the program with exit code 88.
    #
    # Usage:
    #   main.s <M0_PATH> <M1_PATH> <INPUT_PATH> <OUTPUT_PATH>
    
    addi t0, x0, 5          #incorrect number of args
    bne a0, t0, exit_89
    
    addi sp, sp -48
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)
    sw s3, 16(sp)
    sw s4, 20(sp)
    sw s5, 24(sp)
    sw s6, 28(sp)
    sw s7, 32(sp)
    sw s8, 36(sp)
    sw s9, 40(sp)
    sw s10, 44(sp)
    
    mv s1, a1       #argv
    mv s2, a2       #classification
    
	# =====================================
    # LOAD MATRICES
    # =====================================
    addi a0, x0 ,8
    jal malloc
    beq a0, x0, exit_88
    mv s3, a0           #pointer to heap

    mv a1, s3
    addi a2, a0, 4
    lw a0, 4(s1)
    # Load pretrained m0
    jal read_matrix
    mv s8, a0           #s8:pointer to m0 in memory

    addi a0, x0 ,8
    jal malloc
    beq a0, x0, exit_88
    mv s4, a0           #pointer to heap
    
    mv a1, s4
    addi a2, a0, 4
    lw a0, 8(s1)
    # Load pretrained m1
    jal read_matrix
    mv s9, a0           #s9:pointer to m1

    addi a0, x0 ,8
    jal malloc
    beq a0, x0, exit_88
    mv s5, a0           #pointer to heap

    mv a1, s5
    addi a2, a0, 4
    lw a0, 12(s1)
    # Load input matrix
    jal read_matrix
    mv s10, a0          #s10:pointer to input

    # =====================================
    # RUN LAYERS
    # =====================================
    # 1. LINEAR LAYER:    m0 * input
    # 2. NONLINEAR LAYER: ReLU(m0 * input)
    # 3. LINEAR LAYER:    m1 * ReLU(m0 * input)
    
    #m0 * input
    lw t0, 0(s3)        #row pf m0
    lw t1, 4(s5)       #col of input
    mul a0, t0, t1      #size of mul_mat
    slli a0, a0, 2
    jal malloc
    beq a0, x0, exit_88
    mv s7, a0          #pointer to destination matrix
    mv a0, s8
    lw a1, 0(s3)
    lw a2, 4(s3)
    mv a3, s10
    lw a4, 0(s5)
    lw a5, 4(s5)
    mv a6, s7
    jal ra, matmul

    #ReLU(m0 * input)
    mv a0, s7
    lw t0, 0(s3)
    lw t1, 4(s5)
    mul a1, t0, t1
    jal ra, relu
    
    #m1 * ReLU(m0 * input)
    lw t0, 0(s4)
    lw t1, 4(s5)
    mul a0, t0, t1
    slli a0, a0, 2
    jal malloc
    beq a0, x0, exit_88
    mv s0, a0           #pointer to m1 * ReLU(m0 * input)
    mv a0, s9
    lw a1, 0(s4)
    lw a2, 4(s4)
    mv a3, s7
    lw a4, 0(s3)        #row of m0 * input
    lw a5, 4(s5)        #col of m0 * input
    mv a6, s0
    jal matmul
    
    # =====================================
    # WRITE OUTPUT
    # =====================================
    # Write output matrix
    lw a0, 16(s1)
    mv a1, s0
    lw a2, 0(s4)
    lw a3, 4(s5)
    jal write_matrix

    # =====================================
    # CALCULATE CLASSIFICATION/LABEL
    # =====================================
    # Call argmax
    mv a0, s0
    lw t0, 0(s4)
    lw t1, 4(s5)
    mul a1, t0, t1
    jal argmax
    mv s6, a0
    bne s2, x0, exit
    
    # Print classification
    mv a1, a0
    jal print_int


    # Print newline afterwards for clarity
    li a1, '\n'
    jal print_char

    #free heap
    mv a0, s0
    jal free
    mv a0, s3
    jal free
    mv a0, s4
    jal free
    mv a0, s5
    jal free
    mv a0, s7
    jal free
    #read_matrix heap free
    mv a0, s8
    jal free
    mv a0, s9
    jal free
    mv a0, s10
    jal free
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    lw s3, 16(sp)
    lw s4, 20(sp)
    lw s5, 24(sp)
    lw s6, 28(sp)
    lw s7, 32(sp)
    lw s8, 36(sp)
    lw s9, 40(sp)
    lw s10, 44(sp)
    addi sp, sp, 48
    ret

exit:
    #free heap
    mv a0, s0
    jal free
    mv a0, s3
    jal free
    mv a0, s4
    jal free
    mv a0, s5
    jal free
    mv a0, s7
    jal free
    #read_matrix heap free
    mv a0, s8
    jal free
    mv a0, s9
    jal free
    mv a0, s10
    jal free
    
    mv a0, s6
    
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    lw s3, 16(sp)
    lw s4, 20(sp)
    lw s5, 24(sp)
    lw s6, 28(sp)
    lw s7, 32(sp)
    lw s8, 36(sp)
    lw s9, 40(sp)
    lw s10, 44(sp)
    addi sp, sp, 48
    ret

exit_88:
    li a1, 88
    j exit2

exit_89:
    li a1, 89
    j exit2
    