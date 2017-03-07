/*M
.SH NAME
qffmsdcn - quadratic function field over modular singles divisor class number

.SH SYNOPSIS
.nf
#include<_arith3.h>

int qffmsdcn(m, P)  
single m; 
pol P;

.SH DESCRIPTION
.TP 4
.B m
is a prime number, 2 < m < BASIS.
.TP 4
.B P
is a squarefree polynomial in Z/mZ[x].
.PP
qffmsdcn returns the divisor class number of the field Z/mZ(X,P^(1/2)). 

M*/
         
/*H
	Version 1	31.05.1987      B. Weis
	Version 2       20.09.1988      "bind(P)" geloescht.    RB
	Version 3	08.11.1991	Alter Name QFFDCN.	AS
   DATE qffmsdcn        : 890501.9107__.920331
H*/


#include <_arith3.h>

int qffmsdcn(m,P)
single m;
pol P;
{
	int A;

/* Grad P ungerade */
	if (sodd(lfirst(P)))  A = qffmsdcns1(m,P);

/* Grad P gerade, sign(P) kein Quadrat in Z/mZ */
	else if (ijacsym(lsecond(P),m) < 0)  A = qffmsdcns2(m,P);

/* Grad P gerade, sign(P) ein Quadrat in Z/mZ */
	else A = qffmsdcns3(m,P);

/* Ausgabe */
	return(A);
}
