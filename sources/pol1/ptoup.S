/*M
.SH NAME
ptoup - polynomial to univariate polynomial

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol ptoup(r, P) 
single r; 
pol P;
      
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P
is a polynomial in r variables.
.PP
ptoup returns the univariate polynomial P1, where
.PP
P1 = P(0, ..., 0, X).

M*/

/*H
	Version 1       16.02.1989      A.Stein
   DATE ptoup         : 891101.9011__
H*/


#include <_pol1.h>

pol ptoup(r,P)
single r;
pol P;
{
	single e;
	pol P1;
	init(P1);

/* P oder r gleich 0 */

	if ( !P  ||  !r ) P1 = P;

/* P,r ungleich 0 */

	else {
		obj a,ah;
		bind(P);

		r--;
		for( P1 = _0 ; P != _0 ; P = lred2(P) ) {
			e = lfirst(P);
			ah = lsecond(P);
			a = ptbc(r,ah);
			if (a) P1 = lcomp2(a,e,P1);
		}
		P1 = ( P1 == _0 ) ? ( 0 ) : ( linv(P1) ) ;
	}

/* Ausgabe */

	return(P1);
}
