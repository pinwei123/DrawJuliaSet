.data
  first:        .asciz "****Input ID****\n"
  msg1:         .asciz "** Please Enter Member 1 ID: **\n"
  msg2:         .asciz "** Please Enter Member 2 ID: **\n"
  msg3:         .asciz "** Please Enter Member 3 ID: **\n"
  msg4:         .asciz "** Please Enter Command **\n"
  msg5:         .asciz "*****Print Team Member ID and ID Summation*****\n"
  msg6:         .asciz "ID Summation = "
  last:         .asciz "*****End Print*****\n"
  enter:        .asciz "\n"
  p:            .asciz "p"
  int:          .asciz "%d"
  string:       .asciz "%s"


  id1:          .word 0
  id2:          .word 0
  id3:          .word 0
  sum:          .word 0
  command :     .space 100

  id1_address:   .word 0
  id2_address:   .word 0
  id3_address:   .word 0
  idSum_address: .word 0

  .text
    .global id
    .global id1
    .global id2
    .global id3
    .global sum


  id:
    stmfd sp!, {lr}

 @==============將main.c中id函數的變數放入data段宣告的label==========
    ldr   r4, =id1_address  	@ r4 = id1_address
    str   r0, [r4]				@ store value
    ldr   r4, =id2_address  	@ r4 = id2_address
    str   r1, [r4]				@ store value
    ldr   r4, =id3_address  	@ r4 = id3_address
    str   r2, [r4]				@ store value
    ldr   r4, =idSum_address  	@ r4 = idSum_address
    str   r3, [r4]				@ store value
@========================================

@=============== first line =============
    ldr     r0, =first  @ r0 = first line
    bl      printf      @ print ****Input ID****\n
@=============== input id 1 =============
    ldr     r0, =msg1  @ r0 = line2
    bl      printf     @ print ** Please Enter Member 1 ID: **\n
    ldr     r0, =int   @ r0 = %d
    ldr     r1, =id1   @ r1 = id1
    bl      scanf

@===========將scanf進來的id1位置與資料放入id1_address=========
    ldr    r1, =id1_address
    ldr    r1, [r1]
    ldr    r0, =id1
    ldr    r0, [r0]
    str    r0, [r1]

@============== input id 2 =============
    ldr     r0, =msg2  		@ r0 = line3
    bl      printf   		@ print ** Please Enter Member 2 ID: **\n
    ldr     r0, =int  		@ r0 = %d
    ldr     r1, =id2  		@ r1 = id2
    bl      scanf

@===============將scanf進來的id1位置與資料放入id2_address==============
    ldr   r1, =id2_address
    ldr   r1, [r1]
    ldr   r0, =id2
    ldr   r0, [r0]
    str   r0, [r1]

@============== input id 3 =============
    ldr     r0, =msg3  		@ r0 = line4
    bl      printf     		@ print ** Please Enter Member 3 ID: **\n
    ldr     r0, =int   		@ r0 = %d
    ldr     r1, =id3   		@ r1 = id3
    bl      scanf

@===============將scanf進來的id1位置與資料放入id3_address===============
    ldr   r1, =id3_address
    ldr   r1, [r1]
    ldr   r0, =id3
    ldr   r0, [r0]
    str   r0, [r1]
@============== add all id =============
    ldr     r2, =id1  		@ r2 = id1
    ldr     r2, [r2]

    ldr     r3, =id2  		@ r3 = id2
    ldr     r3, [r3]
    add     r1, r2, r3  	@ r1 = id1 + id2

    ldr     r2, =id3  		@ r2 = id3
    ldr     r2, [r2]
    add     r1, r1, r2  	@ r1 = r1 + id3
    ldr     r4, =sum  		@ r4  = address of sum
    str     r1, [r4]  		@ store the result in r4


 @=====================================
    ldr   r1, =idSum_address
    ldr   r1, [r1]
    ldr   r0, =sum
    ldr   r0, [r0]
    str   r0, [r1]
@============== scan p =============
    ldr     r0, =msg4  		@ r0 = line5
    bl      printf   		@ print ** Please Enter Command **\n

    ldr     r0, =string  	@ r0 = %s
    ldr     r1, =command 	@ command 'p' or not
    bl      scanf
@============== check is p or not =============

    ldr     r0, =command 	@ r0 = command
    ldr     r0, [r0]  		@ value of r0
    ldr     r1, =p   		@ r1 = p
    ldrb    r1, [r1] 		@ byte of p
    cmp     r0, r1   		@ p == command?
    blne    ifnotP
@===================== project require ==================

    ldr   r1, =id1   		 	@ r1 = address of id1
    ldr   r1, [r1]              @ r1 = value of id1
    ldr   r2, =id2              @ r2 = address of id2
    ldr   r2, [r2]              @ r2 = value of id2
    addeq r3, r1, r2            @ r3 = id1 + id2
    ldr   r1, =id3              @ r1 = address of id3
    ldr   r1, [r1]              @ r1 = value of id3
    add   r3, r3, r1 ,ror #31   @ r3 = r3 + id3 * 2
    sub   r3, r1                @ r3 = r3 - id3

    addge r3, r3, #1            @ r3 = r3 + 1
    sub   r3, #1                @ r3 = r3 - 1

    ldrne r4, [r4, #1]          @ [register, num]
    ldrne r6, [r4, r5]          @ [register, rg2]
    ldrne r6, [r4, #3]!         @ [register, num]!

@================= end of project require ================
@============== print id1 =============
    ldr     r0, =msg5  @ r0 = line6
    bl      printf   @ print *****Print Team Member ID and ID Summation*****\n

    ldr     r0, =enter  @ r0 = \n
    bl      printf

    ldr     r0, =int  @ r0 = %d
    ldr     r1, =id1  @ r1 = address of id1
    ldr     r1, [r1]  @ r1 = value of id1
    bl      printf
    ldr     r0, =enter
    bl      printf   @ print \n
@============== print id 2 =============
    ldr     r0, =int  @ r0 = %d
    ldr     r1, =id2  @ r1 = address of id2
    ldr     r1, [r1]  @ r1 = value of id2
    bl      printf
    ldr     r0, =enter
    bl      printf   @ print \n
@============== print id 3 =============
    ldr     r0, =int        @ r0 = %d
    ldr     r1, =id3  		@ r1 = address of id3
    ldr     r1, [r1]  		@ r1 = value of id3
    bl      printf
    ldr     r0, =enter
    bl      printf   		@ print \n
@============== print summation =============
    ldr     r0, =enter
    bl      printf
    ldr     r0, =msg6  		@ r0 = line7
    bl      printf  		@ print "ID Summation ="

    ldr     r0, =int  		@ r0 = %d
    ldr     r1, =sum  		@ r1 = sum
    ldr     r1, [r1]  		@ r1 = value fo sum
    bl      printf

    ldr     r0, =enter
    bl      printf

    ldr     r0, =last
    bl      printf    		@ print last line

    ldmfd   sp!,{lr}
    mov     pc, lr

  ifnotP:
    ldr     r0, =last
    bl      printf
    ldmfd   sp!,{lr}
    mov     pc, lr
