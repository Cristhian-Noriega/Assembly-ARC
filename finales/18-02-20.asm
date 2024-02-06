.begin 
.org 2048

.macro push reg
    add %r14, -4, %r14
    st reg, %r14
.end macro

.macro pop reg
    ld %r14, reg
    add %r14, 4, %r14
.end macro

cte20 .equ DB101h
cte12 .equ 200h
len   .equ 32
array .dwb 128 ! 32 words x 4 bytes 

main: sethi cte20, %r1
      sll %r1, 2, %r1 
      or %r1, cte12, %r1    ! guardo la direcccion del periferico en r1

      add %r15, %r0, %r1    ! backup de la direccion de vuelta
      add %r0, len, %r2     ! guardo en r2 el len
      add %r0, array, %r3   ! guardo en r3 la direccion de inicio del array
      push %r3              ! paso por stack la direccion del array
      push %r2              ! paso por stack el len

loop: andcc %r2, %r2, %r0   
      be done
      add %r2, -4, %r2 
      ld %r1, %r10
      st %r10, %r2, %r3
      ba loop

done: call promedio
      pop %r30
      push %r30
      jmpl %r16 + 4, %r0

promedio: pop %r5  ! obtengo el len del array
          pop %r6  ! obtengo la direccion del array
          and %r9, %r0, %r9 ! acumulador

loop_promedio: andcc %r5, %r5, %r0
               be done_prom
               add %5, -4, %r5
               ld %r5, %r6, %r4
               addcc %r4, %r9, %r4
               bvs fuera_de_rango
               ba loop_promedio

fuera_de_rango: push %r0
                jmpl %r15 + 4, %r0 

done_prom:     sll %9, 5, %r9  ! divido entre 2^5 = 32
               push %r9
               jmpl %r15 + 4, %r0

.end