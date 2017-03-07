/*M
.SH NAME
nfsquot - number field, sparse representation, quotient

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel nfsquot(F,a,b)  
pol F; 
nfel a, b;
       
.SH DESCRIPTION
.TP 4
.B F
is an irreducible, univariate polynomial over Q of degree r (say), with r >= 1. F generates the number field K (say).
.TP 4
.B a, b
are elements of K, represented as univariate sparse polynomials over Q of degree < r, b != 0.
.PP
nfsquot returns an element of K, say c, where
.IP
c = a / b.
.PP
c is represented in the same way as a and b.  

M*/
                                         
/*H
	Version 1       16.06.1988      Pascale Serf
	Version 2       22.07.1988      nf durch nfs ersetzt.  PS
   DATE nfsquot       : 890501
H*/


# include <_arith2.h>

nfel nfsquot(F,a,b)
pol F;
nfel a,b;
{
	bind(F,a,b);

	if ( a ) {
	    b = nfsinv(F,b);
	    a = nfsprod(F,a,b);
	}
	return(a);
}
