/*M
.SH NAME
nfelmodi - number field element modulo integer

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel nfelmodi( F, a, M )  
pol F; 
nfel a; 
int M;

.SH DESCRIPTION
.TP 4
.B F
is an irreducible, univariate polynomial in dense representation over Z. F generates a number field, say K.
.TP 4
.B a
is an element of K (for representation of number field elements s. nfneg).
.TP 4
.B M
is an integer number.
.PP
For a != 0, HNa as described in the documentation of nfneg, the following equation must hold:
.IP
gcd (M, HNa) = 1,
.PP
then nfelmodi returns an element of K, say b, where 
.IP
b = a mod M.
 
.SH SEE ALSO
nfneg

M*/
                                   
/*H
	Version 1       03.04.1989      Christine Hollinger
	Version 2       24.10.1990      C.H.    ( Placebo F )
	Version 3       01.08.1991      INFELPROD -> NFELIPROD.  PS
   DATE nfelmodi      : 890601.901120.910915
H*/

#include <_arith2.h>

nfel nfelmodi( F, a, M )
pol F;
nfel a;
int M;
{
	bind( a,M );            /*** F nicht binden, da Placebo ***/

	/*** a = 0 -> a mod M = 0. ***/

	if( a )
	{       int HNa;
		init( HNa );

		/*** a mod M = HNa^(-1) * ( ar*x^r +...+ a0 ) mod M. ***/
		HNa = lfirst( a );
		HNa = miinv( M,HNa );
		a = lred( a );
		a = lcomp( 1,a );
		a = nfeliprod( F, a, HNa );
		a = lred( a );
		a = udpitoudpmi( a,M );
		if( a )         a = lcomp( 1,a );
	}
	return( a );
}
