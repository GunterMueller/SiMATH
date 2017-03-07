/*M
.SH NAME
nfneg - number field element negation

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel nfneg( F, a )               
pol F; 
nfel a;
   
.SH DESCRIPTION
.TP 4
.B F
is an irreducible, univariate polynomial in dense representation over Z of degree r (say). F generates a number field, say K.
.TP 4
.B a
is an element of K. 
.IP
a = (HNa s a_s ... a_0) is represented as an univariate dense polynomial of degree s < r with coefficients a_0, ...,a_s in Z and the positive and integral common denominator HNa, where gcd (HNa, a_s, ..., a_0) = 1 (For a = 0, a is represented by 0).   
.PP
nfinv returns an element of K, say b, where
.IP
b = (-1) * a .

M*/
            
/*H
	Version 1       09.02.1989      Christine Hollinger
	Version 2       24.10.1990      C.H.    ( Placebo F )
   DATE nfneg         : 890601.901120
H*/

#include <_arith2.h>

nfel nfneg( F,a )
pol F;
nfel a;
{
	bind( a );

	/*** Falls a ungleich Null, negieren der Koeffizienten. ***/

	if( a )
	{       int HNa;
		pol P;
		init( HNa,P );

		HNa = lfirst( a );
		P = lred( a );
		P = udpineg( P );
		a = lcomp( HNa,P );
	}
	return( a );
}
