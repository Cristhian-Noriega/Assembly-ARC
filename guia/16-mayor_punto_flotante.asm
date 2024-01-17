.begin
.org 2048

.macro push reg
    add %r14, -4, %r14
    st reg, %r14
.endmacro


.macro pop reg 
    ld %r14, reg
    add %r14, 4, %r14
.endmacro


.macro obtenerSigno registroConNumero registroDestino 
    srl registroConNumero, 31, registroDestino
.endmacro


.macro obtenerExponente registroConNumero registroDestino
    sll registroConNumero, 1, registroDestino
    srl registroDestino, 24, registroDestino

.macro obtenerMantisa registroConNumero, registroDestino
    sll registroConNumero, 9, registroDestino
.endmacro 

flotanteMayor: 
    pop %r1 
    pop %r2

    obtenerSigno %r1, %r3
    obtenerSigno %r2, %r4

    subcc %r3, %r4, %r0

    be signosIguales
    ba signosDistintos

    