clc
function [fin]=balanceo()
//llamado de balanceo
printf('INTRODUCE LOS REACTIVOS \n\n')
n="si"
CAD=""
while (n~="no")
    S=input('Introduzca reactivo: ','s')
    CAD=char(CAD,S)
    n=input("¿desea agregar otro reactivo? (reponda si o no): ",'s')
    if (n~="no")
        CAD=char(CAD,"+")
    end
end
CAD=char(CAD,"--->")
n="si"
while (n~="no")
    S=input('Introduzca producto: ','s')
    CAD=char(CAD,S)
    n=input("¿desea agregar otro producto?(reponda si o no): ",'s')
    if (n~="no")
        CAD=char(CAD,"+")
    end
end

for k=2:(size(CAD)(1))//Se muestra la reacción a balancear
    printf(CAD(k))
end
//############################################################
//Se pide los valores de la cantidad de átomos
printf("\n\nIntrodusca en forma de matriz el número de átomos por reactivo y luego del producto ")
printf("\nEjemplo:\n")
printf("Para: HNO2 + KMnO4 + H2SO4 ---> HNO3 + MnSO4 + K2SO4 + H2O\n")
printf("Matriz del reactivo\n")
disp([1 0 2 ;1 0 0;2 4 4;0 1 0;0 1 0;0 0 1])
printf("Matriz del producto\n")
disp([1 0 0 2;1 0 0 0;3 4 4 1;0 0 2 0;0 1 0 0;0 1 1 0])
REAC=input("Matriz del reactivo: ")
PROD=input("Matriz del producto: ")
//############################################################
 printf ('Balanceamos la ecuación para obtener Amoniaco\n');

A=[REAC -PROD]
b=zeros(size([A])(1),1)
//Comprobamos por Roché Forbenius
[Aa,rA,rAb,n]=forbenius(A,b)
n1=n
 printf ('\ nEl rango de la Matriz A es: %d\n',rA);
 printf ('\ nEl rango de la Matriz aumentada Aa es: %d\n',rAb );
 printf ('\ El el numero de variables n es: %d\n',n1 )
 if (rA ~= rAb) then
 printf ('El sistema no tiene solucion ');
elseif (rA ==n1) then
 printf ('El sistema tiene solucion unica \n');
 else
 printf ('El sistema tiene infinitas soluciones ');
 end
[r,c]=size(PROD)
//Si tiene infiinitas soluciones le quitamos grados de libertad
while(rA<n)
    y=input('Asigne una variable al ultimo término del balnceo para eliminar grados de libertad: ')
    b=-y*(A(:,(size([A])(2))))
    A=A(:,(1:(size([A])(2))-1))
    [Aa,rA,rAb,n]=forbenius(A,b)
end

//Comprobamos nuevamente por roché forbenius
printf ('\ nEl rango de la Matriz A es: %d\n',rA);
 printf ('\ nEl rango de la Matriz aumentada Aa es: %d\n',rAb );
 printf ('\ El el numero de variables n es: %d\n',n )
 if (rA ~= rAb) then
 printf ('El sistema no tiene solucion ');
elseif (rA ==n) then
 printf ('El sistema tiene solucion unica \n');
 else
 printf ('El sistema tiene infinitas soluciones ');
 end

//Ahora hallamos el resto del balanceo
bien=0
w=b
while(bien==0)
[x,kerA]=linsolve(A,b)
x=-x

if (abs(x(1)-round(x(1)))<0.1) then
    bien=1
else
    y=y+1
    b=w
    b=y*b
end
end
SOL=[]
for k=1:(n1-1)
    SOL=[SOL x(k)]
end
SOL=round([SOL y])

//########################################
//Esta parte te muestra el resultado final
k=2
l=1
printf("\n\nLa reacción balanceada es: \n")
while (k<=(size(CAD)(1)))
    io=SOL(l)
    if (modulo(k,2)==0)then
        printf("%d",(io));
        l=l+1
    end
    printf(CAD(k))
    k=k+1
end
printf("\n")
fin="fin"
endfunction
