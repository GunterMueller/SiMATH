/*M
.SH NAME
nfinv - number field inverse

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel nfinv(F, a)         
pol F; 
nfel a;
 
.SH DESCRIPTION
.TP 4
.B F
is an irreducible, univariate polynomial in dense representation over Z. F generates a number field, say K.
.TP 4
.B a
is an element of K (for representation of number field elements s. nfneg).  
.PP
nfinv returns an element of K, say b, where
.IP
b = a^(-1).

.SH SEE ALSO
nfneg

M*/
                                
/*H
	Version 1       14.02.1989      Christine Hollinger
	Version 1.1     27.10.1989      C.H.  ( init( A ) )
   DATE nfinv         : 890601.891101.9011__
H*/

# include <_arith2.h>

nfel nfinv(F,a)
pol F;
nfel a;
{
	pol a1, a2, b, b1, b2, q, r, w;
	rat A;
	init( a1, a2, b, b1, b2, q, r, w, A );
	bind(F,a);

	/*** a, F rational anpassen. ***/
	a1 = udpitoudpr( F );
	a2 = nfeltoudpr( a );

	/*** Initialisierungen. ***/
	b = 0;
	b1 = itor( 1 );
	b1 = list2( 0,b1 );

	/***  Euklidischer Algorithmus fuer a1 und a2. ***/
	while ( lfirst( a2 ) )
	{       q = udprqrem( a1, a2, &r);
		a1 = a2;
		a2 =r;
		w = udprprod( q,b1 );
		b2 = udprdif( b,w );
		b = b1;
		b1 = b2;
	}
	A = rinv( lsecond( a2 ) );
	b = udprrprod( b1, A );

	/*** Umformen in Typ nfel. ***/
	b = udprtonfel( b );
	return( b );
}
