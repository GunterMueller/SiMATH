/*M
.SH NAME
udpmideriv - univariate dense polynomial over modular integers derivation

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol udpmideriv(m, P)  
int m; 
pol P;

.SH DESCRIPTION
.TP 4
.B m
is an integer number, m > 0.                                                    
.TP 4                                                                           
.B P                                                                            
is an univariate dense polynomial over Z/mZ.            
.PP
udpmideriv returns the derivation of P.

M*/

/*H
	Version 1 	14.08.91	J.Schmitt
	Version 2	25.11.94	Logik der if(k)-Abfrage 
					korrigiert. AS
   DATE udpmideriv    : 910915.941201
H*/

#include <_pol1.h>

pol udpmideriv(m,P)
int m;
pol P;
{
        single e, e1=(-1);
	int k;
	pol P1;
	bind(m,P);
	init(k,P1);

/* P gleich 0 */

	if (!P) P1 = 0;

/* allgemeiner Fall: P ungleich 0 */

	else {
		e = lfirst(P);
		P = lred(P);
		P1 = _0;
		do {
			k = lfirst(P);
			P = lred(P);
			k = miprod(m,k,e);
			if ( (e1 == -1) || !e ) {
				if ( k ) {
					e1 = e-1;
					P1 = lcomp(k,P1);
				}
			}
			else P1 = lcomp(k,P1);
			e--;
		} while (P != _0);
		if (P1 == _0) P1 = 0;
		else {
			P1 = linv(P1);
			P1 = lcomp(e1,P1);
		}
	}

/* Ausgabe */

	return(P1);
}
