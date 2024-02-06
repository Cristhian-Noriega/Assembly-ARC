# Enunciados de finales


### 09-03-21

Un programa recibe por stack la direccion de inicio de un arreglo de 16 elementos no signados. Debe calcular el promedio de todos los elementos (pares) y comunicar el resultado a un periférico mapeado en la direccion B71300A1h

* a) El promedio debe ser calculado por una subrutina
* b) El promedio debe ser calculado utilizando una macro

### 16-08-22

Escribir un programa en codigo Assembler ARC que recibe via stack la direccion de inicio  y la extension
(cantidad de palabras de 32 bits) de un arreglo. Cada byte de este arreglo es interpretado  como un caracter alfabetico que interesa enviar a imprimir. La impresora utilizada admite solo caracteres en el 
rango de 10 a 127 (valor decimal).
El programa pedido debe recorrer el arreglo enviando cada byte (via stack) a una subrutina que se encarga de imprimirlo solo en caso de este sen encuetre dentro del rango admitido. La impresora esta mapeada en la direccion D0100080h y la impresion de cada caracter se realiza escribiendola en el byte menos significativo de esa direccion sin alterar el contenido de los otros tres bytes.

### 18-02-20

Un programa declara un arreglo de 32 bits y carga en el las primeras 32 lecturas de un periferico que esta mapeado en la direccion C3101200h. Una vez finalizada esta tarea invoca una subrutina que calcula su promedio. El programa principal devuelve el promedio por stack y termina.
Los valores entregados por el dispositivo estan representados en un sistema numerico de complemento a 2.
La rutina, que debe ser declarada en el mismo modulo del programa principal, recibe por stack la direccion del arreglo y devuelve tambien por stack el promedio calculado. En caso de excederse de rango de representacion devuelve un cero.
