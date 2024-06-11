clc
// Comprobar si cumple por teorema de roché forbenius
// Ingresando la Matriz A
function [Aa,rA,rAb,n]=forbenius(A,b)
// Matriz Aumentada Aa
Aa=[A b]
// Hallando los rangos
 rA= rank (A)
 rAb= rank (Aa)
 [m,n]= size (A)
endfunction

