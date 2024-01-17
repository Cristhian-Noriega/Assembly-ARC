
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

cte20 .equ D0100h      ! divido en dos la direccion de la impresora 
cte12 .equ 080h        ! ya que es muy grande para guardarlo en una sola cte

3_byte_mas: FFFFFF00h  ! mascara para quedarme con los 3 bytes mas significativos
byte_menos: 000000FFh  ! mascara para quedarme con el byte menos significativos

add %r15, %r0, %r16    ! hago backup de la direccion de r15 ya que usare call luego

sethi cte20, %r1       ! ubica los 22 bits mas signifactivos la cte 20 (mas dos 0): 00DO100 00.. 
sll %r1, 2, %r1        ! muevo a izquierda dos posiciones, eliminando los dos ceros de mas
or %r1, cte12, %r1     ! or bitwise entre los 20 bits y la cte 12, para guardarlo en r1: D0100 + 080  

pop %r20               ! guardo la dir de inicio del array 
pop %r21               ! guardo la cantidad de elementos del array 

imprimir_array: subcc %r21, 1, %r21
                bneg fin 
                ld %r20, %r2
                push %r20, 
                call imprimir_elemento
                ba imprimir_array


imprimir_elemento: 



