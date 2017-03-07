/*M
.SH NAME
gf2nbsqu - Galois-field of characteristic 2, normal basis, square 

.SH SYNOPSIS
.nf
#include<_arith2.h>

gf2el gf2nbsqu(G, a)  
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
gf2nbsqrt returns an element of GF(2^n), say b. b is the square of a in GF(2^n), i.e.
.IP
b = a * a.
.PP
b is given in special bit notation and represented with respect to the same normal basis as a.

.SH SEE ALSO
udpm2tosb
                             
M*/
                    
/*H
	Version 1	14.09.1994	Josef Gebel
   DATE gf2nbsqu      : 941201
H*/

#include <_arith2.h>
				
gf2el gf2nbsqu( G, a )
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
	       n;    /***   field degree			***/
	gf2el  b;    /***   a^2 will be stored in b		***/

	bind( G, a );

	/***   INITIALIZATIONS	(beginning)  ***/

	init( b );

	b = _0;
	d  = ( 1 << 30 ) - 1;  /***   d = 00111...1111	 ( 30 times '1' ) ***/
	l = -1;
	n  = lfirst( G );
	m  = n - lfirst( a ) - 1;
	a  = lred( a );
	a1 = lfirst( a );

	/***   INITIALIZATIONS	(end)  ***/

	/***   Test if another word has to be added to a   ***/

	if( m )
	{
	    /***   a does not have highest degree n-1, the highest degree  ***/
	    /***   possible: maybe one more word has to be added.	   ***/
	    b1 = a1 >> 30;
	    if( b1 )
	    {
		/***   the first bit in the first 'single' word of a is 1  ***/
		/***   a^2 has one more word than a, namely the word 1	   ***/
		b = list1( 1 );
		l += 30;
	    }
	}

	/***   square procedure (ring shift)		   ***/

	while( 1 )
	{
	    b1 = ( a1 << 1 ) & d;

	    a = lred( a );
	    if( a == _0 )
	    {
		if( !m )
		{    
		    b1++;
		}
		b = lcomp( b1, b );
		break;
	    }
	    a1 = lfirst( a );
	    if( a1 >> 29 )
	    {
		b1++;
	    }

	    l += 30;
	    b = lcomp( b1, b );
	}
 
	/***   canceling of leading zero words in b	   ***/

	b = linv( b );
	while( !lfirst( b ) )
	{
	    l -= 30;
	    b = lred( b );
	}

	/***   canceling of the first 1 in the 1st word	   ***/
	/***   if a had maximal degree (n-1)		   ***/

	b1 = lfirst( b );

	if( !m )
	{
	    m = n - l - 1;
	    a1 = ( 1 << m );
	    a1--;
	    b1 = lfirst( b );
	    b1 &= a1;
	    b = lred( b );
	    if( b1 )
	    {
		b = lcomp( b1, b );
	    }
	    else
	    {
		l -= 30;
		while( !lfirst( b ) )
		{
		    l -= 30;
		    b = lred( b );
		}
	    }
	}

	b1 = lfirst( b );

	/***   determination of the degree of a^2	   ***/

	while( b1 )
	{
	    b1 >>= 1;
	    l++;
	}

	b = lcomp( l, b );

	return( b );
    }
	
    /***   a = 0 ==> a^2 = 0			       ***/
    return( 0 );
}
