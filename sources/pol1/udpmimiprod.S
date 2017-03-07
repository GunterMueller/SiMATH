/*M
.SH NAME
udpmimiprod - univariate dense polynomial over modular integers, modular integer product

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol udpmimiprod(m, P, a)  
int m, a; 
pol P;

.SH DESCRIPTION
.TP 4
.B m
is an integer number, m > 0.     
.TP 4                                                                           
.B P                                                                            
is an univariate dense polynomial over Z/mZ.               
.TP 4
.B a
is an element of Z/mZ.
.PP
udpmimiprod returns the polynomial P1, where                                    
.IP                                                                             
P1 = A * P.                                                                     
                  
M*/

/*H
	Version 1 	14.08.91	J.Schmitt
   DATE udpmimiprod   : 910915
H*/

#include <_pol1.h>
 
pol udpmimiprod(m,P,a)
int m;
pol P;
int a;
{
	single e;
	int k;
	pol P1;
	bind(m,P,a);
	init(k,P1);

/* P oder a gleich 0 */

	if (P == 0  ||  a == 0) P1 = 0;

/* allgemeiner Fall: P,a ungleich 0 */

	else {
		P1 = _0;
		e = lfirst(P);
		P = lred(P);
		do {
			k = lfirst(P);
			P =lred(P);
			k = miprod(m,k,a);
			P1 = lcomp(k,P1);
		} while (P != _0);
		P1 = linv(P1);
		while (P1 != _0  &&  lfirst(P1) == 0) {
			P1 = lred(P1);
			e--;
		}
		if ( P1 == _0 ) P1 = 0;
		else P1 = lcomp(e,P1);
	}

/* Ausgabe */

	return(P1);
}
