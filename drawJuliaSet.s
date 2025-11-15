.data
num1:  .word 1000
num2:  .word 1500
num3:  .word 480000
num4:  .word 240000
num5:  .word 4000000
num6:  .word 0xffff

i:	   .word 255

.text
  .global drawJuliaSet    @ Function

  drawJuliaSet :
    stmfd sp!, {r4-r11, lr}

@================================================================
    mov   r4, r0     @ r4 = cY
    mov   r11, r1    @ r11 = frame
    mov   r6, #0     @ x = r6, set x = 0


  forX :
    cmp   r6, #640 		  @ if ( x < 640 )
    bge   projectRequire  @ end of X label
						  @ do project base require
    mov   r7, #0      	  @ y = r7 , set y = 0

  forY :
    cmp   r7, #480  	  @ if ( y < 480 )
    bge   Endy
@============================loop y for zx first================================
	ldr  r0, =num2    	  @ set r0 = 1500
	ldr  r0, [r0]		  @ set value of 1500
	mul	 r0, r0, r6 	  @ r0 = 1500 * x, x = r6
	ldr  r1, =num3	 	  @ set r1 = 480000
	ldr  r1, [r1]		  @ set value of 480000
	sub  r0, r0, r1		  @ r0 = r0 - r1 ( 1500x - 480000 )
	mov  r1, #320		  @ r1 = 320
	bl   __aeabi_idiv	  @ div the value of r0 and r1
	mov  r8, r0  		  @ r8 = (1500x-480000)/320, store in r8(zx)

@============================set up for zy================================
	ldr  r0, =num1    	  @ set r0 = 1000
	ldr  r0, [r0]		  @ set value of 1000
	mul	 r0, r0, r7 	  @ r0 = 1000 * y, y = r7
	ldr  r1, =num4	 	  @ set r1 = 240000
	ldr  r1, [r1]		  @ set value of 240000
	sub  r0, r0, r1		  @ r0 = r0 - r1 ( 1000x - .40000 )
	mov  r1, #240		  @ r1 = 240
	bl   __aeabi_idiv	  @ div the value of r0 and r1
	mov  r9, r0  		  @ r8 = (1000y-240000)/240, store in r9(zy)

	ldr  r10, =i		  @ i = r10, set i = 255
	ldr  r10, [r10]		  @ set value of 255

	mul  r0, r8, r8		  @ set r0 = zx * zx
	mul  r1, r9, r9		  @ set r1 = zy * zy
	add  r2, r0, r1 	  @ set r2 = sqare(zx) + sqare(zy)
	ldr  r3, =num5		  @ set r3 = 4000000
	ldr  r3, [r3]		  @ set value of 4000000

	cmp     r2, r3		  @ if sqare(zx) + sqare(zy) > 4000000
	bge     docolor		  @ fill the color
	cmplt 	r10, #0		  @ if i <= 0
	ble     docolor		  @ fill the color
@============================set up for zx&zy================================
while:
	sub     r0, r0, r1	  @ r0 = sqare(zx) - sqare(zy)
	ldr     r1, =num1	  @ set r1 = 1000
	ldr		r1, [r1]	  @ set value of 1000
	bl		__aeabi_idiv  @ r0 = r0 / r1
	sub		r5, r0, #700  @ store the result minus cx(700) in r5

	mul     r0, r8, r9	  @ r0 = zx*zy
	mov     r1, #500	  @ r1 = 500
	bl      __aeabi_idiv  @ r0 = r0 / r1
	add     r9, r0, r4    @ store (r0 + cy) in r9

	mov     r8, r5        @ zx = tmp
	sub     r10, #1       @ i--
@==========================condition of while================================
	mul  r0, r8, r8		  @ set r0 = zx * zx
	mul  r1, r9, r9		  @ set r1 = zy * zy
	add  r2, r0, r1 	  @ set r2 = sqare(zx) + sqare(zy)
	ldr  r3, =num5		  @ set r3 = 4000000
	ldr  r3, [r3]		  @ set value of 4000000

	cmp     r2, r3		  @ if sqare(zx) + sqare(zy) > 4000000
	bge     docolor		  @ fill the color
	cmplt 	r10, #0		  @ if i <= 0
	ble     docolor		  @ fill the color

	bl 	    while

@==========================do the color===============================
docolor:
	and     r10, r10, #0xff			@ color = r10, r10 = i&0xff
	
	mov		r0, #8					@ prepare for lsl
	orr     r10, r10, r10, lsl r0   @ store [ r10 | ( r10>>8 ) ] in r10

	ldr     r0, =num6				@ set 0xffff in r0
	ldr	    r0, [r0]				@ set the value if 0xffff

	bic		r10, r0, r10            @ store(0xffff & ~color) in r10

    mov     r0, r11           	    @ r0 = frame
    mov     r1, #1280    		 	@ r1 = 1280 (640*2)
    mul     r1, r1, r7              @ r1 = 1280y (r7 = y)
    add     r0, r1             		@ r0 = frame + 1280y
    add     r0, r6, ror #31     	@ r0 =(frame + 1280y) + 2x (r6 = x)

    strh    r10, [r0]				@ store by half( int16_t )

@================================================================
    add   r7, #1          @ y++
    b     forY 		  	  @ loopY of y
@================================================================
  Endy :
    add   r6, #1          @ x++
    b     forX			  @ loopX of x
@================================================================
  projectRequire :
  
@===================== project require ==================

	mrs	  r0,  CPSR		@ back up CPSR
    mov   r3,  r14      @ back up lr in r3 
    adds  r14, r0, r15  @ r14 = r0 + r15 and set flags
    mov   r14, r3       @ recover the r14
	msr   CPSR_f, r0    @ recover CPSR
	
    ldr   r1, =num1   		 	@ r1 = address of num1
    ldr   r1, [r1]              @ r1 = value of id1
    ldr   r2, =num2             @ r2 = address of num2
    ldr   r2, [r2]              @ r2 = value of num2
    addeq r3, r1, r2            @ r3 = id1 + id2
    ldr   r1, =num3             @ r1 = address of num3
    ldr   r1, [r1]              @ r1 = value of num3
    add   r3, r3, r1 ,ror #31   @ r3 = r3 + id3 * 2
    sub   r3, r1                @ r3 = r3 - id3

    addge r3, r3, #1            @ r3 = r3 + 1
    sub   r3, #1                @ r3 = r3 - 1

    ldrne r4, [r4, #1]          @ [register, num]
    ldrne r6, [r4, r5]          @ [register, rg2]
    ldrne r6, [r4, #3]!         @ [register, num]!
	
@================= end of project require ================
  
    ldmfd sp!, {r4-r11, lr}
    mov   pc, lr

@================================================================


