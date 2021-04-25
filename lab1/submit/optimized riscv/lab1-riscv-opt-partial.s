image_process:
        lw s0, n 
        lw s1, m 
        slli s4, s1, 2
        addi s2, s0, -2
        addi s3, s1, -2
        addi t0, zero, -2
        addi t1, zero, -2
        la a0, img
        la a1, result_img
        addi a0, a0, -8 #img location
        sub a0, a0, s4
        addi a1, a1, -8 #result_img location
        sub a1, a1, s4
Outloop:
        addi t0, t0, 2
        add a0, a0, s4
        add a1, a1, s4
        addi t1, zero, -2
        bge t0, s0, exit
Inloop:
        addi t1, t1, 2
        bge t1, s1, Outloop
        addi a0, a0, 8 #increment locating address
        addi a1, a1, 8
#Judge whether border pixel
        blt s2, t0, Border00
        blt s3, t1, Border01
        beq t0, zero, Border1 
        beq t0, s2, Border3
        beq t1, zero, Border20
        beq t1, s3, Border22
#For inner pixels
#second line
        lw t2, -4(a0)
        addi t5, t2, 0
        slli t2, t2, 1
        addi t3, t2, 0
        lw t2, 0(a0)
        addi t6, t2, 0
        slli t2, t2, 1
        addi t4, t2, 0
        add t5, t5, t2
        slli t2, t2, 1
        add t3, t3, t2
        lw t2, 4(a0)
        add t5, t5, t2
        slli t2, t2, 1
        add t3, t3, t2
        add t6, t6, t2
        slli t2, t2, 1
        add t4, t4, t2
        lw t2, 8(a0)
        add t6, t6, t2
        slli t2, t2, 1
        add t4, t4, t2
#first line
        sub a2, a0, s4
        lw t2, -4(a2)
        add t3, t3, t2
        lw t2, 0(a2)
        add t4, t4, t2
        slli t2, t2, 1
        add t3, t3, t2
        lw t2, 4(a2)
        add t3, t3, t2
        slli t2, t2, 1
        add t4, t4, t2
        lw t2, 8(a2)
        add t4, t4, t2
#third line
        add a2, a0, s4
        lw t2, -4(a2)
        add t3, t3, t2
        slli t2, t2, 1
        add t5, t5, t2
        lw t2, 0(a2)
        add t4, t4, t2
        slli t2, t2, 1
        add t3, t3, t2
        add t6, t6, t2
        slli t2, t2, 1
        add t5, t5, t2
        lw t2, 4(a2)
        add t3, t3, t2
        slli t2, t2, 1
        add t4, t4, t2
        add t5, t5, t2
        slli t2, t2, 1
        add t6, t6, t2
        lw t2, 8(a2)
        add t4, t4, t2
        slli t2, t2, 1
        add t6, t6, t2
#fourth line
        add a2, a2, s4
        lw t2, -4(a2)
        add t5, t5, t2
        lw t2, 0(a2)
        add t6, t6, t2
        slli t2, t2, 1
        add t5, t5, t2
        lw t2, 4(a2)
        add t5, t5, t2
        slli t2, t2, 1
        add t6, t6, t2
        lw t2, 8(a2)
        add t6, t6, t2
#store
        srli t3, t3, 4
        srli t4, t4, 4
        srli t5, t5, 4
        srli t6, t6, 4
        sw t3, 0(a1)
        sw t4, 4(a1)
        add a2, a1, s4
        sw t5, 0(a2)
        sw t6, 4(a2)
        j Inloop
Border00:
        lw t2, 0(a0)
        sw t2, 0(a1)
        blt s3, t1, Inloop
        lw t2, 4(a0)
        sw t2, 4(a1)
        j Inloop
Border01:
        lw t2, 0(a0)
        sw t2, 0(a1)
        add a2, a0, s4
        lw t2, 0(a2)
        add a2, a1, s4
        sw t2, 0(a2)
        j Inloop
Border1:
        beq t1, zero, Border10
        beq t1, s3, Border12
        lw t2, -4(a0)
        addi t5, t2, 0
        lw t2, 0(a0)
        sw t2, 0(a1)
        addi t6, t2, 0
        slli t2, t2, 1
        add t5, t5, t2
        lw t2, 4(a0)
        sw t2, 4(a1)
        add t5, t5, t2
        slli t2, t2, 1
        add t6, t6, t2
        lw t2, 8(a0)
        add t6, t6, t2
        add a2, a0, s4
        lw t2, -4(a2)
        slli t2, t2, 1
        add t5, t5, t2
        lw t2, 0(a2)
        slli t2, t2, 1
        add t6, t6, t2
        slli t2, t2, 1
        add t5, t5, t2
        lw t2, 4(a2)
        slli t2, t2, 1
        add t5, t5, t2
        slli t2, t2, 1
        add t6, t6, t2
        lw t2, 8(a2)
        slli t2, t2, 1
        add t6, t6, t2
        add a2, a2, s4
        lw t2, -4(a2)
        add t5, t5, t2
        lw t2, 0(a2)
        add t6, t6, t2
        slli t2, t2, 1
        add t5, t5, t2
        lw t2, 4(a2)
        add t5, t5, t2
        slli t2, t2, 1
        add t6, t6, t2
        lw t2, 8(a2)
        add t6, t6, t2
        srli t5, t5, 4
        srli t6, t6, 4
        add a2, a1, s4
        sw t5, 0(a2)
        sw t6, 4(a2)
        j Inloop
Border10:
        lw t2, 0(a0)
        sw t2, 0(a1)
        addi t6, t2, 0
        lw t2, 4(a0)
        sw t2, 4(a1)
        slli t2, t2, 1
        add t6, t6, t2
        lw t2, 8(a0)
        add t6, t6, t2
        add a2, a0, s4
        lw t2, 0(a2)
        addi t5, t2, 0
        slli t2, t2, 1
        add t6, t6, t2
        lw t2, 4(a2)
        slli t2, t2, 2
        add t6, t6, t2
        lw t2, 8(a2)
        slli t2, t2, 1
        add t6, t6, t2
        add a2, a2, s4
        lw t2, 0(a2)
        add t6, t6, t2
        lw t2, 4(a2)
        slli t2, t2, 1
        add t6, t6, t2
        lw t2, 8(a2)
        add t6, t6, t2
        srli t6, t6, 4
        add a2, a1, s4
        sw t5, 0(a2)
        sw t6, 4(a2)
        j Inloop
Border12:
        lw t2, -4(a0)
        addi t5, t2, 0
        lw t2, 0(a0)
        sw t2, 0(a1)
        slli t2, t2, 1
        add t5, t5, t2
        lw t2, 4(a0)
        sw t2, 4(a1)
        add t5, t5, t2
        add a2, a0, s4 
        lw t2, -4(a2) 
        slli t2, t2, 1
        add t5, t5, t2
        lw t2, 0(a2)
        slli t2, t2, 2
        add t5, t5, t2
        lw t2, 4(a2)
        addi t6, t2, 0
        slli t2, t2, 1
        add t5, t5, t2
        add a2, a2, s4
        lw t2, -4(a2)
        add t5, t5, t2
        lw t2, 0(a2)
        slli t2, t2, 1
        add t5, t5, t2
        lw t2, 4(a2) 
        add t5, t5, t2
        srli t5, t5, 4
        add a2, a1, s4
        sw t5, 0(a2)
        sw t6, 4(a2)
        j Inloop
Border3:
        beq t1, zero, Border30
        beq t1, s3, Border32
        sub a2, a0, s4
        lw t2, -4(a2)
        addi t3, t2, 0
        lw t2, 0(a2)
        addi t4, t2, 0
        slli t2, t2, 1
        add t3, t3, t2
        lw t2, 4(a2)
        add t3, t3, t2
        slli t2, t2, 1
        add t4, t4, t2
        lw t2, 8(a2)
        add t4, t4, t2
        lw t2, -4(a0)
        slli t2, t2, 1
        add t3, t3, t2
        lw t2, 0(a0)
        slli t2, t2, 1
        add t4, t4, t2
        slli t2, t2, 1
        add t3, t3, t2
        lw t2, 4(a0)
        slli t2, t2, 1
        add t3, t3, t2
        slli t2, t2, 1
        add t4, t4, t2
        lw t2 8(a0)
        slli t2, t2, 1
        add t4, t4, t2
        add a2, a0, s4
        lw t2, -4(a2)
        add t3, t3, t2
        lw t2, 0(a2)
        addi t5, t2, 0
        add t4, t4, t2
        slli t2, t2, 1
        add t3, t3, t2
        lw t2, 4(a2)
        addi t6, t2, 0
        add t3, t3, t2
        slli t2, t2, 1
        add t4, t4, t2
        lw t2, 8(a2)
        add t4, t4, t2
        srli t3, t3, 4
        srli t4, t4, 4
        sw t3, 0(a1)
        sw t4, 4(a1)
        add a2, a1, s4
        sw t5, 0(a2)
        sw t6, 4(a2)
        j Inloop
Border30:
        sub a2, a0, s4
        lw t2, 0(a2)
        addi t4, t2, 0
        lw t2, 4(a2)
        slli t2, t2, 1
        add t4, t4, t2
        lw t2, 8(a2)
        add t4, t4, t2
        lw t2, 0(a0)
        sw t2, 0(a1)
        slli t2, t2, 1
        add t4, t4, t2
        lw t2, 4(a0)
        slli t2, t2, 2
        add t4, t4, t2
        lw t2, 8(a0)
        slli t2, t2, 1
        add t4, t4, t2
        add a2, a0, s4
        lw t2, 0(a2)
        addi t5, t2, 0
        add t4, t4, t2
        lw t2, 4(a2)
        addi t6, t2, 0
        slli t2, t2, 1
        add t4, t4, t2
        lw t2, 8(a2)
        add t4, t4, t2
        srli t4, t4, 4
        sw t4, 4(a1)
        add a2, a1, s4
        sw t5, 0(a2)
        sw t6, 4(a2)
        j Inloop
Border32:
        sub a2, a0, s4
        lw t2, -4(a2)
        addi t3, t2, 0
        lw t2, 0(a2)
        slli t2, t2, 1
        add t3, t3, t2
        lw t2, 4(a2)
        add t3, t3, t2
        lw t2, -4(a0)
        slli t2, t2, 1
        add t3, t3, t2
        lw t2, 0(a0)
        slli t2, t2, 2
        add t3, t3, t2
        lw t2, 4(a0)
        sw t2, 4(a1)
        slli t2, t2, 1
        add t3, t3, t2
        add a2, a0, s4
        lw t2, -4(a2)
        add t3, t3, t2
        lw t2, 0(a2)
        addi t5, t2, 0
        slli t2, t2, 1
        add t3, t3, t2
        lw t2, 4(a2)
        addi t6, t2, 0
        add t3, t3, t2
        srli t3, t3, 4
        sw t3, 0(a1)
        add a2, a1, s4
        sw t5, 0(a2)
        sw t6, 4(a2)
        j Inloop
Border20:      
        sub a2, a0, s4
        lw t2, 0(a2)
        addi t4, t2, 0
        lw t2, 4(a2)
        slli t2, t2, 1
        add t4, t4, t2
        lw t2, 8(a2)
        add t4, t4, t2
        lw t2, 0(a0)
        addi t3, t2, 0
        addi t6, t2, 0
        slli t2, t2, 1
        add t4, t4, t2
        lw t2, 4(a0)
        slli t2, t2, 1
        add t6, t6, t2
        slli t2, t2, 1
        add t4, t4, t2
        lw t2, 8(a0)
        add t6, t6, t2
        slli t2, t2, 1
        add t4, t4, t2
        add a2, a0, s4
        lw t2, 0(a2)
        addi t5, t2, 0
        add t4, t4, t2
        slli t2, t2, 1
        add t6, t6, t2
        lw t2, 4(a2)
        slli t2, t2, 1
        add t4, t4, t2
        slli t2, t2, 1
        add t6, t6, t2
        lw t2, 8(a2)
        add t4, t4, t2
        slli t2, t2, 1
        add t6, t6, t2
        add a2, a2, s4
        lw t2, 0(a2)
        add t6, t6, t2
        lw t2, 4(a2)
        slli t2, t2, 1
        add t6, t6, t2
        lw t2, 8(a2)
        add t6, t6, t2
        srli t4, t4, 4
        srli t6, t6, 4
        sw t3, 0(a1)
        sw t4, 4(a1)
        add a2, a1, s4
        sw t5, 0(a2)
        sw t6, 4(a2)
        j Inloop
Border22:
        sub a2, a0, s4
        lw t2, -4(a2)
        addi t3, t2, 0
        lw t2, 0(a2)
        slli t2, t2, 1
        add t3, t3, t2
        lw t2, 4(a2)
        add t3, t3, t2
        lw t2, -4(a0)
        addi t5, t2, 0
        slli t2, t2, 1
        add t3, t3, t2
        lw t2, 0(a0)
        slli t2, t2, 1
        add t5, t5, t2
        slli t2, t2, 1
        add t3, t3, t2
        lw t2 4(a0)
        addi t4, t2, 0
        add t5, t5, t2
        slli t2, t2, 1
        add t3, t3, t2
        add a2, a0, s4
        lw t2, -4(a2)
        add t3, t3, t2
        slli t2, t2, 1
        add t5, t5, t2
        lw t2, 0(a2)
        slli t2, t2, 1
        add t3, t3, t2
        slli t2, t2, 1
        add t5, t5, t2
        lw t2, 4(a2)
        addi t6, t2, 0
        add t3, t3, t2
        slli t2, t2, 1
        add t5, t5, t2
        add a2, a2, s4
        lw t2, -4(a2)
        add t5, t5, t2
        lw t2, 0(a2)
        slli t2, t2, 1
        add t5, t5, t2
        lw t2, 4(a2)
        add t5, t5, t2
        srli t3, t3, 4
        srli t5, t5, 4
        sw t3, 0(a1)
        sw t4, 4(a1)
        add a2, a1, s4
        sw t5, 0(a2)
        sw t6, 4(a2)
        j Inloop
exit:
        ret