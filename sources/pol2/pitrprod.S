/*M
.SH NAME
pitrprod - polynomial over integers truncation product, (recursive)

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol pitrprod(r, S, P1, P2) 
single r; 
list S; 
pol P1, P2;
 
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B S
= (s1 ... sr) is a list, consisting of non negative singles.
.PP
Let I be the ideal, spanned by (X1^s1,...,Xr^sr), then
.TP 4
.B P1, P2
are polynomials in Z[X1,...,Xr]/I.
.PP
pitrprod returns the polynomial P3, where
.IP
P3 = P1 * P2.
                                                    
M*/

/*H
	Version 1       22.02.1989      A.Stein
   DATE pitrprod      : 891101
H*/


#include <_pol2.h>
 
pol pitrprod(r,S,P1,P2)
single r;
list S;
pol P1,P2;
{
	list S1;
	pol P;
	bind(S);

/* P1 oder P2 oder letztes Element von S gleich 0 */

	if ( !P1 || !P2 || !(S1=lreduct(S,r-1),lfirst(S1)) ) P = 0;
	else {

/* Allgemeinen Fall vorbereiten */

		single s,e1,e2,hr;
		pol Q,P1h;
		obj a,a1,a2;
		bind(P1,P2);
		init(P,Q,P1h,a,a1,a2);

		hr = r-1;
		s = lfirst(S1);
		P1 = lcinv(P1);
		P2 = lcinv(P2);

/* Multiplikation */

		while( P2!=_0 && (e2=lsecond(P2))<s ) {
			a2 = lfirst(P2) ;
			P2 = lred2(P2) ;
			P1h = P1 ;
			Q = _0 ;
			while( P1h!=_0 && (e1=lsecond(P1h))<s-e2 ) {
				a1 = lfirst(P1h) ;
				P1h = lred2(P1h) ;
				a = ( !hr ) ? (iprod(a1,a2))
					    : (pitrprod(hr,S,a1,a2));
				if( a ) Q=lcomp2(e1+e2,a,Q);
			}
			if( Q!=_0 ) P=pisum(r,P,Q);
		}

	}

/* Ausgabe */

	return(P);
}
