.data
  start:    .asciz "******Print Name******\n"
  end:      .asciz "******End Print******\n"
  team:     .asciz "Team 15\n"
  name1:    .asciz "CHEN YU XIANG\n"
  name2:    .asciz "LIN PIN WEI\n"
  name3:    .asciz "CHEN GUAN JIE\n"

.text
  .global name  @ funtion name
  .global team  @ string : team number
  .global name1 @ student1
  .global name2 @ student2
  .global name3 @ student3
  .global main

  name:
    stmfd sp!, {lr}
    ldr   r0, =start    @ r0 = first line
    bl    printf
    ldr   r0, =team     @ r0 = team number
    bl    printf

	mrs	  r0,  CPSR		@ back up CPSR
    mov   r3,  r14      @ r1 = r13
    adds  r14, r0, r15  @ r14 = r0 + r15 and set flags
    mov   r14, r3       @ recover the r14
	msr   CPSR_f, r0    @ recover CPSR

    ldr   r0, =name1    @ r0 = student1 name
    bl    printf
    ldr   r0, =name2    @ r0 = student2 name
    bl    printf
    ldr   r0, =name3    @ r0 = student3 name
    bl    printf
    ldr   r0, =end      @ r0 = last line
    bl    printf

    ldmfd sp!, {lr}
    mov   pc, lr
	