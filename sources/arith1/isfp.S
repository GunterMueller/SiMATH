/*M
.SH NAME
isfp - integer square-free part

.SH SYNOPSIS
.nf
#include<_arith1.h>

int isfp(A)
int A;

.SH DESCRIPTION
isfp() returns the square-free part B of A,
i.e. B is square-free and the quotient A/B is a square.
It holds that sign(A)=sign(B), especially B=0 in case A=0. 
M*/
/*H
	Version 1       09.10.1987      MAR.
	Version 2       27.09.1988      Spezialfall 0 abgefangen. PS
   DATE isfp          : 890501
H*/



# include <_arith1.h>

int isfp( A )
int A;
{
	single s;
	list L;
	int P1, P2, T;

	bind( A );
	init( L, P1, P2, T );

	/***    Spezialfall: A = 0    ***/
	if ( !A ) return(0);

	/***    allgemeiner Fall: A != 0    ***/
	T = 1;
	s = isign( A );
	P1 = ( s<0 ? ineg(A) : A );
	L = ifact( P1 );
	while ( llength( L ) >= 2 ) {
		P1 = lfirst( L );
		P2 = lsecond( L );
		if ( idif( P1, P2 ) == 0 )
			L = lred2( L );
		else {
			T = iprod( T, P1 );
			L = lred( L );
		}
	}
	if ( L != _0 ) T = iprod( T, lfirst(L) );
	if ( s < 0 ) T = ineg(T);
	return( T );
}
