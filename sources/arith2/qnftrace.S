/*M
.SH NAME
qnftrace - quadratic number field trace of an element

.SH SYNOPSIS
.nf
#include<_arith2.h>

rat qnftrace(D, b)  
int D; 
nfel b;
 
.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
D defines the quadratic number field K (say), where K = Q(D^(1/2)).
.TP 4
.B b
is an element of K (for representation of number field elements s. fputnfel).
.PP  
qnftrace returns the trace of b with regard to K/Q.

.SH SEE ALSO
fputnfel

M*/

/*H
	Version 1       10.04.1989      Christine Hollinger
	Version 2       06.07.1990      C.H.   TRACEQNF -> QNFTRACE
					       F als Placebo
	Version 3       26.08.1991      statt Polynom F "=" x^2-D nur noch D
					als Parameter und Doku angepasst.  PS
	Version 4	18.07.1995	linv -> lcinv, damit a nicht 
					veraendert wird.  PS
   DATE qnftrace      : 890801.901120.9107__.910915.9311__.951201
H*/

#include<_arith2.h>

rat qnftrace( D,a )
int D;
nfel a;
{
	rat R;
	init( R );
	bind( a );

	/*** a = 0 -> S_K/Q( a ) = 0. ***/

	if( a == 0 )    R = 0;

	/*** a != 0 -> a = ( HNa,..., a0 ), S_K/Q( a ) = 2*a0/HNa. ***/
	else
	{       int g,HNa;
		init( g,HNa );

		HNa = lfirst( a );
		a = lcinv( a );
		a = lfirst( a );
		a = isum( a,a );
		g = igcd( a,HNa );
		if( g != 1 )
		{       a = iquot( a,g );
			HNa = iquot( HNa,g );
		}
		R = list2( a,HNa );
	}
	return( R );
}
