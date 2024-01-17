.begin 
.org 2048

andcc %r10, %r0, %r10
ld [A], %r20
ld [B], %r3  !cargo la mascara de bajos en r3
ld [C], %r4  !cargo la mascara de altos en r4

andcc %r20, %r3, %r1  !16 bits bajos en r1   0000AAAA
andcc %r20, %r4, %r2  !16 bits altos en r2   BBBB0000

srl %r2, 16, %r5  !muevo a der 16 bits r2    0000BBBB
srl %r1, 16, %r6  !muevo a izq 16 bits r1    AAAA0000

addcc %r1, %r5, %r20
addcc %r2, %r6, %r0

bvs overflow
ba fin 

overflow: addcc %r10, 1, %r10

fin: jmpl %r15 + 4, %r0
.end

