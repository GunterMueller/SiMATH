/*M
.SH NAME
uprtonfel - univariate polynomial over rationals to number field element

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel uprtonfel(F, P)  
pol F, P;

.SH DESCRIPTION
.TP 4
.B F
is an irreducible, univariate polynomial in dense representation over Z of degree >= 1. F generates a number field, say K.
.TP 4
.B P
is an univariate polynomial over Q.
.PP
uprtonfel returns 0 for P = 0, and an element of K, say a, else. Thereby, a is reduced and equal to P as an element of K (s. nfneg).
   
.SH SEE ALSO
nfneg

M*/
                                   
/*H
	Version 1       14.05.1992	U. Schneiders
	Version 2	05.02.1993	Fehler beseitigt.  US
   DATE uprtonfel     : 921130.930115
H*/

#include <_arith2.h>

nfel uprtonfel( F, P )
pol F, P;
{
	int hn;
	init( hn );
	bind( F, P );

	F = dptop( 1, F );
	F = pitopr( 1, F );
	P = prrem( 1, P, F );
	if( !P ) return( 0 );	
	P = prnumden( 1, P, &hn );
	P = ptodp( 1, P );
	P = lcomp( hn, P );

	return( P );
}
