/*M
.SH NAME
nfsnegf - number field, sparse representation, negation as function

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel nfsnegf(F, a)  
pol F; 
nfel a;
  
.SH DESCRIPTION
.TP 4
.B F
is an irreducible, univariate polynomial over Q of degree r (say), with r >= 1. F generates the number field K (say).
.TP 4
.B a
is an  element of K, represented as univariate sparse polynomial over Q of degree < r.
.PP
nfsnegf returns the same result as the macro nfsneg, namely the additiv inverse element of a in K.
 
M*/
         
/*H
	Version 1       12.09.1990	Th. Weis
   DATE nfsnegf       : 910915
H*/

#include <_arith2.h>

nfel nfsnegf( F, a )
pol  F;
nfel a;

{
	return( prneg( 1, a ) );
}
