/*M
.SH NAME
nfssumf - number field, sparse representation, sum as function

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel nfssumf(F,a,b)  
pol F; 
nfel a, b;
 
.SH DESCRIPTION
.TP 4
.B F
is an irreducible, univariate polynomial over Q of degree r (say), with r >= 1. F generates the number field K (say).
.TP 4
.B a, b
are elements of K, represented as univariate sparse polynomials over Q of degree < r.
.PP  
nfssumf returns the same result as the macro nfssum, namely the sum of a and b in K.

M*/

/*H
	Version 1       12.09.1990	Th. Weis
   DATE nfssumf       : 910915
H*/

#include <_arith2.h>

nfel nfssumf( F, a, b )
pol  F;
nfel a, b;

{
	return( prsum( 1, a, b ) );
}
