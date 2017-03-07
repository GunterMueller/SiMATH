/*M
.SH NAME
qffmsdcns1 - quadratic function field over modular singles divisor class number subroutine 1

.SH SYNOPSIS
.nf
#include<_arith3.h>

int qffmsdcns1(m, P)  
single m; 
pol P;
 
.SH DESCRIPTION
.TP 4
.B m
is a prime number, 2 < m < BASIS.
.TP 4
.B P
is a squarefree polynomial in Z/mZ[x] of odd degree and not equal to zero.
.PP
qffmsdcns1 returns the divisor class number of the field Z/mZ(X,P^(1/2)). 

M*/
                         
/*H
	Version 1	31.05.1987      B. Weis
	Version 2       08.09.1987      B. Weis
			Sonderfall berichtigt
	Version 3       07.10.1987      B. Weis
			mehrfach-genaue Arithmetik
	Version 4       20.09.1988      "qffmsdcns0" jetzt "udpmssumjs";
					"init", "bind" optimiert.   RB
	Version 5	08.11.1991	Alter Name QFFDCNS1.	AS
   DATE qffmsdcns1      : 890501.920331
H*/


#include <_arith3.h>

int qffmsdcns1(m,P)
single m;
pol P;
{
	single n;
	int A=1;

/* Berechnung der Divisorklassenzahl */

	n = lfirst(P)/2;
	if (n) {
		int H, M, S;
		bind( P,A );
		init( H,M );
		P = ptodp(1,P);
		S = udpmssumjs(m,P,n);
		A = isum(A,S);
		M = m;
		while (--n) {
			H = isum(M,1);
			S = udpmssumjs(m,P,n);
			H = iprod(H,S);
			A = isum(A,H);
			M = isprod(M,m);
			}
		A = isum(A,M);
		}

/* Ausgabe */

	return(A);
}
