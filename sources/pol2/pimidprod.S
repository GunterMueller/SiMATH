/*M
.SH NAME
pimidprod - polynomial over integers modular ideal product

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol pimidprod(r, S, P1, P2) 
single r; 
list S; 
pol P1, P2;
 
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B S
= (s1 ... s(r-1)) is a list, consisting of non negative singles.        
.PP
Let I be the ideal, spanned by (X1^s1,...,X(r-1)^s(r-1)), then
.TP 4
.B P1, P2
are polynomials in Z[X1,...,X(r-1),Y] / I.
.PP
pimidprod returns the polynomial P3, where
.IP
P3 = P1 * P2.
 
M*/

/*H
	Version 1       22.02.1989      A.Stein
   DATE pimidprod     : 891101
H*/


#include <_pol2.h>
 
pol pimidprod(r,S,P1,P2)
single r;
list S;
pol P1,P2;
{
	pol P;

/* P1 oder P2 gleich 0 */

	if ( !P1 || !P2 ) P = 0;
	else {

/* Allgemeiner Fall */

		single e1,e2,hr;
		pol Q,P1h;
		obj a,a1,a2;
		bind(S,P1,P2);
		init(P,Q,a,a1,a2,P1h);

		P = 0 ;
		hr = r-1;
		P1 = lcinv(P1);
		P2 = lcinv(P2);
		do {
			a2 = lfirst(P2) ;
			e2 = lsecond(P2) ;
			P2 = lred2(P2) ;
			P1h = P1 ;
			Q = _0 ;
			do {
				a1 = lfirst(P1h) ;
				e1 = lsecond(P1h) ;
				P1h = lred2(P1h) ;
				a = ( !hr ) ? (iprod(a1,a2))
					    : (pitrprod(hr,S,a1,a2));
				if( a ) Q = lcomp2(e1+e2,a,Q);
			}
			while( P1h != _0 );
			if( Q != _0 ) P = pisum(r,P,Q);
		}
		while( P2 != _0 );
	}

/* Ausgabe */

	return(P);
}
