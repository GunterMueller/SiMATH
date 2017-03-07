/*M
.SH NAME
qnfnorm - quadratic number field norm of an element

.SH SYNOPSIS
.nf
#include<_arith2.h>

rat qnfnorm( D, b )  
int D; 
nfel a;

.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
D defines the quadratic number field K (say), where K = Q(D^(1/2)).
.TP 4
.B b
is an element of K (for representation of number field elements s. fputnfel).
.PP
qnfnorm returns the norm of b with regard to K/Q.

.SH SEE ALSO
fputnfel

M*/
                                                  
/*H
	Version 1       10.04.1989      Christine Hollinger
	Version 2       06.07.1990      C.H.    NORMQNF -> QNFNORM
	Version 3       26.08.1991      statt Polynom F "=" x^2-D nur noch D
					als Parameter und Doku angepasst.  PS
   DATE qnfnorm       : 890801.901120.9107__.910915.9311__
H*/

#include<_arith2.h>

rat qnfnorm( D,a )
int D;
nfel a;
{
	rat R;
	init( R );
	bind( D,a );

	/*** a = 0 -> N_K/Q( a ) = 0. ***/

	if( !a )        R = 0;

	/*** a != 0 -> N_K/Q( x1 + x2*D^(1/2) ) = x1^2 - D*x2^2. ***/
	else
	{       int a0, a1, HNa;
		init( a0, a1, HNa );

		HNa = lfirst( a );
		HNa = iprod( HNa,HNa );
		a0 = lsecond( a );
		switch( a0 )
		{       case 0: a0 = lthird( a );
				a0 = iprod( a0,a0 );
				break;
			case 1: a1 = lthird( a );
				a1 = iprod( a1,a1 );
				a0 = ineg( D );
				a1 = iprod( a1,a0 );
				a0 = lfourth( a );
				a0 = iprod( a0,a0 );
				a0 = isum( a0,a1 );
				a1 = igcd( a0,HNa );
				if( a1 != 1 )
				{       HNa = iquot( HNa,a1 );
					a0 = iquot( a0,a1 );
				}
				break;
			default:break;
		}
		R = list2( a0,HNa );
	}
	return( R );
}
