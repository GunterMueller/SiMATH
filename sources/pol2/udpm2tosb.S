/*M
.SH NAME
udpm2tosb - univariate dense polynomial over modular 2 to special bit-representation

.SH SYNOPSIS
.nf
#include<_pol2.h>

obj udpm2tosb(P)  
pol P;

.SH DESCRIPTION
.TP 4
.B P
is an univariate polynomial in dense representation over Z/2Z.
.PP
udpm2tosb returns the special bit-representation (say a) of the polynomial P, i.e.
.PP
For P = c(n)*X^n + c(n-1)*X^(n-1) + ... + c(1)*x + c(0),
with coefficients in Z/2Z, and c(n) != 0, is
.IP
a = ( n a(k) a(k-1) ... a(1) a(0) ),
.PP
a list of positive singles, where n = deg(P) and k the greatest integer smaller than n/30. For 0 <= i <= k is
.PP
a(i) = c(30*i)*2^0 + c(30*i+1)*2^1 +...+ c(30*i+29)*2^29,
.PP
so every a(i) represents 30 coefficients of P.
  
M*/
              
/*H
	Version 1       10.03.1992	A.Stein 
   DATE udpm2tosb     : 920331
H*/

#include <_arith2.h>

obj udpm2tosb(P)
pol P;
{
	obj a;
	bind(a);

	if( !P ) a = 0;
	else {
		single e, i, l, u;
		bind(P);
		
		e = lfirst(P);
		a = list1(e);
                l = e % 30;
		u = 1 ;
		P = lred2(P);
		while ( l-- ) {
               		u <<= 1;
			if (lfirst(P)) u |= 1;
			P = lred(P);
		}
		a = lcomp(u,a); 
		l = e / 30; 
	        while( l-- ) {
		        for( i=30; i && (!lfirst(P)); P=lred(P), i-- );
			if( i ) { 
				u = 1, P = lred(P), --i;
				while ( i-- ) {
               				u <<= 1;
					if (lfirst(P)) u |= 1;
					P = lred(P);
				}
				a = lcomp(u,a);
			}
			else a = lcomp(0,a);
                }
                a = linv(a);
	}
	return(a);
}
