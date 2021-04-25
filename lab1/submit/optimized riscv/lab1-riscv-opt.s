.data
# --------------------------------------- TODO: FILL IN YOUR FILE PATH ---------------------------------------------
read_path:
        .string "/home/arch_stu2019012341/yao-archlab-s21/lab1/sample/turing.pixel"
write_path:
        .string "/home/arch_stu2019012341/yao-archlab-s21/lab1/submit/turing_opt.pixel"
# ------------------------------------------------------------------------------------------------------------------
img:
        .zero   1000000
result_img: 
        .zero   1000000
n:
        .zero   4
m:
        .zero   4

.text
main:
        addi    sp,sp,-16
        sw      ra,12(sp)
        jal    image_input 
        jal    image_process
        jal    image_output
        jal    image_to_file
        lw      ra,12(sp)
        li      a0,0
        li a7, 10
        ecall
        addi    sp,sp,16
        jr      ra


_printf_num:
# DO NOT MODIFY THIS!!!
        li a7, 1
        ecall 
        ret


_printf_char:
# DO NOT MODIFY THIS!!!
        li a7, 11
        ecall 
        ret


_read_int:
# DO NOT MODIFY THIS!!!
        mv      a5,a1
        mv      a4,a2
        li a7, 1024
        li a1, 0
        ecall
        mv t3, a0
        li a7, 65
        mv a1, a5
        mv a2, a4
        ecall
        li a7, 57
        mv a0, t3
        ecall
        ret


_write_int:
# DO NOT MODIFY THIS!!! 
        mv a5, a1
        mv a4, a2
        li a7, 1024
        li a1, 1
        ecall
        mv t3, a0
        li a7, 66
        mv a1, a5
        mv a2, a4
        ecall
        li a7, 57
        mv a0, t3
        ecall
        ret 


image_process:
# --------------------------------------- TODO: FILL IN CODE HERE ---------------------------------------
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
        j Outloop

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
Outloop:
        addi t0, t0, 2
        add a0, a0, s4
        add a1, a1, s4
        addi t1, zero, -2
        blt t0, s0, Inloop
        ret
# -------------------------------------------------------------------------------------------------------


image_input:
# DO NOT MODIFY THIS!!!
        addi    sp,sp,-32
        sw      ra,28(sp)
        sw      s0,24(sp)
        sw      s1,20(sp)
        sw      s2,16(sp)
        sw      s3,12(sp)
        sw      s4,8(sp)
        sw      s5,4(sp)
        li      t1,-1000016
        add     sp,sp,t1
        la a0, read_path
        addi a1, sp, 4 # data start at sp + 4, end at sp + 1000016
        li a2, 250002
        jal _read_int

        la a4, n
        lw a3, 4(sp)
        sw a3, 0(a4)
        la a5, m
        lw a3, 8(sp)
        sw a3, 0(a5)

        lw t5, m 
        lw t6, n 
        mul t5, t5, t6 
        addi t1, zero, 0 
        bge t1, t5, L3 
        la s3, img 
        addi s1, sp, 12 # Find the first pixel data; Notice that data[0] = m, data[1] = n. The first pixel data begins at data[3]

L4: 
        lw a5, 0(s1) 
        sw  a5, 0(s3)
        addi s3, s3, 4
        addi s1, s1, 4
        addi t1, t1, 1
        blt t1, t5, L4
L3: 
        li      t1,1000016
        add     sp,sp,t1
        lw      ra,28(sp)
        lw      s0,24(sp)
        lw      s1,20(sp)
        lw      s2,16(sp)
        lw      s3,12(sp)
        lw      s4,8(sp)
        lw      s5,4(sp)
        addi    sp,sp,32
        jr      ra


image_output:
# DO NOT MODIFY THIS!!!
        addi    sp,sp,-32
        sw      ra,28(sp)
        sw      s0,24(sp)
        sw      s1,20(sp)
        sw      s2,16(sp)
        sw      s3,12(sp)
        sw      s4,8(sp)
        sw      s5,4(sp)
        lw s1, n
        mv a0, s1
        jal _printf_num 
        li a0, 10
        jal _printf_char
        lw s2, m
        mv a0, s2
        jal _printf_num  
        li a0, 10
        jal _printf_char

        mul s1, s1, s2 
        la s3, result_img
        addi t1, zero, 0 
        bge t1, s1, L1 
L2:     
        lw a0, 0(s3)
        jal _printf_num
        li a0, 32
        jal _printf_char
        addi s3, s3, 4
        addi t1, t1, 1
        blt t1, s1, L2
L1:
        lw      ra,28(sp)
        lw      s0,24(sp)
        lw      s1,20(sp)
        lw      s2,16(sp)
        lw      s3,12(sp)
        lw      s4,8(sp)
        lw      s5,4(sp)
        addi    sp,sp,32
        jr      ra
        

image_to_file:
# DO NOT MODIFY THIS!!!
        addi    sp,sp,-32
        sw      ra,28(sp)
        sw      s0,24(sp)
        sw      s1,20(sp)
        sw      s2,16(sp)
        sw      s3,12(sp)
        sw      s4,8(sp)
        sw      s5,4(sp)
        li      t1,-1000016
        add     sp,sp,t1

        lw a1, n
        sw a1, 4(sp)
        lw a2, m
        sw a2, 8(sp)

        mul t5, a1, a2 
        addi t1, zero, 0 
        bge t1, t5, L5 
        la s3 result_img 
        addi s1, sp, 12
L6:     
        lw a5, 0(s3)
        sw a5, 0(s1)
        addi s3, s3, 4
        addi s1, s1, 4
        addi t1, t1, 1
        blt t1, t5, L6
L5:     
        la, a0, write_path
        addi a1, sp, 4
        addi a2, t5, 2
        jal _write_int

        li      t1,1000016
        add     sp,sp,t1
        lw      ra,28(sp)
        lw      s0,24(sp)
        lw      s1,20(sp)
        lw      s2,16(sp)
        lw      s3,12(sp)
        lw      s4,8(sp)
        lw      s5,4(sp)
        addi    sp,sp,32
        jr      ra
