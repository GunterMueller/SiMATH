/*M
.SH NAME
quadratic function field over modular singles divisor class number subroutine 3

.SH SYNOPSIS
.nf
#include<_arith3.h>

int qffmsdcns3(m, P)  
single m; 
pol P;

.SH DESCRIPTION
.TP 4
.B m
is a prime number, 2 < m < BASIS.
.TP 4
.B P
is a squarefree polynomial in Z/mZ[x] of even degree and not equal to zero. The leading coefficient of P is a square in Z/mZ.
.PP
qffmsdcns3 returns the divisor class number of the field Z/mZ(X,P^(1/2)).
                                                                        
.SH SEE ALSO
M*/
                       
/*H
	Version 1	31.05.1987      B. Weis
	Version 2       07.10.1987      B. Weis
			mehrfach-genaue Arithmetik
	Version 3       20.09.1988      "qffmsdcns0" zu "udpmssumjs".  RB
        Version 4       22.05.1989      C.H/U.S divs
	Version 5	08.11.1991	Alter Name QFFDCNS3.	AS
   DATE qffmsdcns3      : 890501.890601.920331
H*/


#include <_arith3.h>

int qffmsdcns3(m,P)
single m;
pol P;
 {
	single i, ms, n, ns;
	int A=0, H, M, S;
	list Sl;
	bind( P,A );
	init( H,M,S,Sl );
	ns = lfirst( P );
        n = divs( ns, 2);

/* Berechnung der Divisorklassenzahl */

	Sl = list1(1);
	ns--;
	P = ptodp(1,P);
	for (i = 1; i < n; i++) {
		S = udpmssumjs(m,P,i);
		Sl = lcomp(S, Sl);
		H = isprod(S,i);
		A = idif(A,H);
		}
	M = iexp(m,n-1);
	H = isprod(M,ns);
	A = isum(A,H);
	ms = m-1;
	S = 0;
	Sl = linv(Sl);
	for (i = 1; i < n; i++) {
		S = isum(lfirst(Sl),S);
		Sl = lred(Sl);
		H = isprod(S,ms);
		H = idif(H,lfirst(Sl));
		M = isquot(M,m);
		H = isprod(H,M);
		ns--;
		H = isprod(H,ns);
		A = idif(A,H);
		}

/* Ausgabe */

	return(A);
}
