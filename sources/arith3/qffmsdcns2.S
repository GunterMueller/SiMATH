/*M
.SH NAME
qffmsdcn2 - quadratic function field over modular singles divisor class number subroutine 2

.SH SYNOPSIS
.nf
#include<_arith3.h>

int qffmsdcns2(m, P)  
single m; 
pol P;   

.SH DESCRIPTION
.TP 4
.B m
is a prime number, 2 < m < BASIS.
.TP 4
.B P
is a squarefree polynomial in Z/mZ[x] of even degree and not equal to zero. The leading coefficient of P is not a square in Z/mZ.
.PP
qffmsdcns2 returns the divisor class number of the field Z/mZ(X,P^(1/2)).                
M*/

/*H
	Version 1	31.05.1987      B. Weis
	Version 2       07.10.1987      B. Weis
			mehrfach-genaue Arithmetik
	Version 3       20.09.1988      "qffmsdcns0" zu "udpmssumjs".  RB
	Version 4	08.11.1991	Alter Name QFFDCNS2.	AS
   DATE qffmsdcns2      : 890501.920331
H*/


#include <_arith3.h>

int qffmsdcns2(m,P)
single m;
pol P;
{
	single i, ms, n;
	int A=1, H, M, S;
	list Sl;
	bind( P,A );
	init( H,M,S,Sl );
	n = lfirst(P)/2;

/* Berechnung der Divisorklassenzahl */

	Sl = list1(1);
	P = ptodp(1,P);
	for (i = 1; i < n; i++) {
		S = udpmssumjs(m,P,i);
		Sl = lcomp(S,Sl);
		A = isum(A,S);
		}
	M = iexp(m,n-1);
	A = isum(A,M);
	ms = m-1;
	S = 0;
	Sl = linv(Sl);
	for (i = 1; i < n; i++) {
		S = idif(lfirst(Sl),S);
		H = isprod(S,ms);
		Sl = lred(Sl);
		H = isum(H,lfirst(Sl));
		M = isquot(M,m);
		H = iprod(H,M);
		A = isum(A,H);
		}
	A = ip2quot(A,1);

/* Ausgabe */

	return(A);
}
