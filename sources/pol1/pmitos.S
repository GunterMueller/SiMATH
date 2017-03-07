/*M
.SH NAME
pmitos - polynomial over modular integers to symmetric remainder system, (recursive)

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol pmitos(r,M,P)  
single r; 
int M; 
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B M
is an integer number, M > 0.
.TP 4
.B P
is a polynomial in r variables over Z with coefficients of the positive remainder system modulo M.
.PP
pmitos returns the polynomial P1 in r variables over Z with coefficients of the symmetric remainder system modulo M. P1 is congruent to P modulo M.

M*/

/*H
	Version 1	08.04.1988	R.Boeffgen
	Version 2	15.05.1992	P1 gebunden.  PS
   DATE pmitos        : 890501.920601
H*/


# include <_pol1.h>

pol pmitos( r, M, P )
single r;
int M;
pol P;
{
	pol Ps;
   /***    r oder P Null    ***/
	if ( P==0 )  Ps = 0;
	else if ( r==0 )  Ps = mitos( M,P );
	else {
   /***    allgemeiner Fall    ***/
		single e1;
		pol P1;
		bind( M,P );
		init( Ps,P1 );
		for ( r--, Ps=_0;  P!=_0;  P=lred(P) ) {
			e1= lfirst( P );
			P = lred( P );
			P1= lfirst( P );
			P1= r ? pmitos(r,M,P1) : mitos(M,P1);
			Ps= lcomp2( P1, e1, Ps );
		}
		Ps = linv( Ps );
	}
   /***    Ergebnis    ***/
	return( Ps );
}
