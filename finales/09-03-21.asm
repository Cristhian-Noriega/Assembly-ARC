
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


cte20 .equ B7130h
cte12 .equ 0A1h
len   .equ 64      !16 words x 4 bytes = 64 bytes

add %r15, %r0, %r16   ! backup para despues volver

sethi cte20, %r1   
sll %r1, 2, %r1 
or %r1, cte12, %r1   ! guardo la direccion del periferico en r1 

pop %r20          ! guardo la direccion del inicio  del arreglo en r20 
and %r0, len, %r3 ! guardo la longitud del arreglo en r3 
call promedio 
pop %r2           ! obtengo el resultado del promedio por stack
st %r2, %r1       ! almaceno el resultado en la direccion de memoria del periferico
jmpl %r16 + 4, %r0

promedio: add %r0, %r0, %r5   ! inicializo mi contador
        loop: andcc %r3, %r3, %r0
              be done 
              addcc %r3, -4, %r4 ! decremento el len/indice
              ld %r3, %r20, %r6  ! elemento actual
              sll %r6, 31, %r7   ! me quedo con el bit mas significativo en el bit 31   
              orcc %r7, %r0, %r0 ! or bitwise para ver si es par o impar
              be espar
              ba loop

        espar: addcc %r6, %r5, %r5
               ba loop 

        fin: sll %r5, 4, %r5    ! divido entre 16 moviendo hacia la izquieda 4 lugares
             push %r5           ! mando por stack el resultado
             jmpl %r15 + 4, %r0  


            



