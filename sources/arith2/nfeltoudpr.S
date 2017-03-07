/*M
.SH NAME
nfeltoudpr - number field element to univariate dense polynomial over rationals

.SH SYNOPSIS
.nf
#include<_arith2.h>

pol nfeltoudpr(a)  
nfel a;
  
.SH DESCRIPTION
.TP 4
.B a
= (HNa r a_r ... a_0) is the representation of a number field element (s. nfneg), where (r a_r ... a_0) represents an univariate dense polynomial over Z of degree r.
.PP
nfeltoudpr returns the univariate polynomial of degree r in dense representation over Q, (represented by (r b_r ... b_0) ) where
.IP
b_i = a_i / HNa   i = 1...r. 
 
.SH SEE ALSO
nfneg

M*/
              
/*H
	Version 1       13.02.1989      Christine Hollinger
   DATE nfeltoudpr    : 890601.9211__
H*/



#include <_arith2.h>

pol nfeltoudpr( a )
nfel a;
{
	bind( a );

	/*** a = 0, so fertig. ***/

	/*** a ungleich Null -> bi = ai/HNa. ***/
	if( a != 0 )
	{       int HNa, ai,g;
		list b,bi;
		init( HNa, ai, g, b, bi );

		HNa = lfirst( a );
		ai = lsecond( a );      /* ai entspricht Grad r. */
		a = lred2( a );
		b = list1( ai );
		while( a != _0 )
		{       ai = lfirst( a );
			a = lred( a );
			if( ai )
			{       g = igcd( ai, HNa );
				if( g == 1 )    bi = list2( ai,HNa );
				else
				{       ai = iquot( ai,g );
					g = iquot( HNa,g );
					bi = list2( ai,g );
				}
			}
			else    bi = 0;
			b = lcomp( bi,b );
		}
		a = linv( b );
	}
	return( a );
}
