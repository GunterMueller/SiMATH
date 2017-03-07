/*M
.SH NAME
isqrt_lo - integer square root ( lists only )

.SH SYNOPSIS
.nf
#include<_arith1.h>

int isqrt_lo(A)
int A;

.SH DESCRIPTION
isqrt_lo() returns the integer part of the square root
of A for A >= 0.
The computation is completely performed within the SIMATH memory
management, i.e. using only lists and no arrays.
M*/
/*H
	Version  1      02.06.1992	Marc Conrad (altes isqrt)
   DATE isqrt_lo      : 921130
H*/

# include <_arith1.h>

int isqrt_lo ( A )
int A;
{
	if ( issingle(A) )  return( ssqrt(A) );
	{
	    /***    einfach-genaue Approximation    ***/
		int  B,C;
		single  a,b,n;
		bind( A );  init( B,C );
		n = ilog2(A) - BLOG2;
		n += sodd(n);
		a = ip2quot( A, n );
		b = ssqrt(a) + 1;
		B = ip2prod( b, n/2 );
	    /***    modifizierte Newton-Methode    ***/
		for ( C=0 ; icomp(B,C)>0 ; )  {
			C = iquot( A,B );     
			B = irshift( isum(B,C) );          
		}
		return( B );
	}
}
