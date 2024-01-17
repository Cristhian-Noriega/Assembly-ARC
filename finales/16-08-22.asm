
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

imprimir_array: subcc %r21, 1, %r21   ! decremento en 1 la cantidad de elementos 
                bneg fin              ! si la resta da negativo, es porque ya no quedan mas elementos, termino 
                ld %r20, %r2          ! cargo la dir de inicio en r2
                push %r20,            ! pusheo a la pila la dir de inicio (esto es para pasar por pila el argumento a la subrutina)
                call imprimir_elemento 
                ba imprimir_array     ! vuelvo al ciclo for para una nueva iteracion


imprimir_elemento: pop %r2            ! obtengo las 4 letras y las guardo en r2
                   ld %r1, %r4        ! cargo el valor de la dir de la impresora en r4 
                   and %r4, 3_byte_mas, %r4  ! con un and bitwise me quedo con los 3 bits mas significativos de la dir de impresora  

imprimir_letra:    andcc %r2, %r2, %r0  ! verifico que todo el elemento no sea cero 
                   be jmpl %r15 + 4, %r0 
                   and %r2, byte_menos, %r3  ! me quedo con la letra en el byte menos signif y guardo en r3
                   subcc %r3, 10, %r0  ! realizo la resta entre la letra y el rango minimo 
                   bneg siguiente_letra ! si da negativo no pertecene al rango por lo que paso a la sigueinte letra
                   subcc %r3, 127, %r0 ! realizo la resta entre la letra y el rango maximo 
                   bpos siguiente_letra ! si da positivo no pertenece al rango por lo que paso a la siguiente letra
                   
                   or %r3, %r4,      ! junto el byte a imprimir con los 3 de la impresora para no perderlos
                   
                   st %r3, %r1       ! mando a imprimir la letra 
                   siguiente_letra: srl %r2, 8, %r2
                   ba imprimir_letra

fin:               jmpl %r16 + 4, %r0

                   .end


