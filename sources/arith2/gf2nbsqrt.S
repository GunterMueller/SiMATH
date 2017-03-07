/*M
.SH NAME
gf2nbsqrt - Galois-field of characteristic 2, normal basis, square root

.SH SYNOPSIS
.nf
#include<_arith2.h>

gf2el gf2nbsqrt(G, a)  
obj G; 
gf2el a;
   
.SH DESCRIPTION
.TP 4
.B G
is an irreducible monic univariate polynomial over GF(2) of degree n > 1 with coefficients in special bit notation (see udpm2tosb). G is interpreted as a gener
ating polynomial of the field GF(2^n). 
.TP 4
.B a
is an elements in GF(2^n) represented in special bit notation with respect to some normal basis.
.PP
gf2nbsqrt returns an element of GF(2^n), say b. b is the square root of a in GF(2^n), i.e.
.IP
b * b = a.
.PP
b is given in special bit notation and represented with respect to the same normal basis as a.

.SH SEE ALSO
udpm2tosb

M*/
                                
/*H
	Version 1	14.09.1994	Josef Gebel
   DATE gf2nbsqrt     : 941201
H*/

#include <_arith2.h>
				
gf2el gf2nbsqrt( G, a )
obj G;
gf2el a;
{
    if( a )					 /***	a != 0	***/
    {

	single a1,   /***   a1 = current 'single' word in a	***/
	       b1,   /***   b1 = current 'single' word in a^2	***/
	       d,    /***   d = 2^30-1, used to cancel the	***/
		     /***   overflow after a left shift		***/
		     /***   since positive SIMATH singles have	***/
		     /***   the form [ 0 0 a29 a28 ... a1 a0 ]	***/
	       l,    /***   counter for the position of the	***/
		     /***   first non zero bit in a^2		***/
	       m,    /***   flag for overflow of the first	***/
		     /***   single word in a^2 (since the	***/
		     /***   maximal length allowed for the	***/
		     /***   first word is n : 30 - 1.		***/
	       p,    /***   counter for the degree of b		***/
	       n;    /***   field degree			***/
	gf2el  b;    /***   a^2 will be stored in b		***/

	bind( G, a );

	/***   INITIALIZATIONS	(beginning)  ***/
	init( b );

	n = lfirst( G );
	a = lred( a );
	b = _0;
	d  = ( 1 << 30 );
	l = ( n - 1 ) / 30;
	m = 0;
	p = -31;

	/***   INITIALIZATIONS	(end)  ***/

	/***   square root procedure (ring shift)	    ***/
	a1 = lfirst( a );

	while( 1 )
	{
	    if( m )
	    {
		a1 |= d;
	    }
	    if( a1 & 1 )
	    {
		m = 1;
	    }
	    else
	    {	
		m = 0;
	    }
	    b1 = ( a1 >> 1 );

	    p += 30;
	    b = lcomp( b1, b );

	    a = lred( a );
	    if( a == _0 )
	    {
		break;
	    }
	    a1 = lfirst( a );
	    l--;
	}
 
	/***   canceling of leading zero words in b	   ***/

	b = linv( b );
	if( m )
	{
	    m = ( n  - 1 ) % 30;
	    d = ( 1 << m );
	    while( l-- )
	    {
		p += 30;
		b = lcomp( 0, b );
	    }

	    b1 = lfirst( b );
	    b = lred( b );
	    b1 |= d;
	    b = lcomp( b1, b );
	}

	/***   canceling of the first 1 in the 1st word	   ***/
	/***   if a had maximal degree (n-1)		   ***/

	while( !( b1 = lfirst( b ) ) )
	{
	    p -= 30;
	    b = lred( b );
	}

	/***   determination of the degree of a^2	   ***/

	while( b1 )
	{
	    p++;
	    b1 >>= 1;
	}
	b = lcomp( p, b );
	return( b );
    }
    /***   a = 0 ==> a^(1/2) = 0			   ***/
    return( 0 );
}
