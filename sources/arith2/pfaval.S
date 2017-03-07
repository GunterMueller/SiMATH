/*M
.SH NAME
pfaval - p-adic field additive valuation
(MACRO)

.SH SYNOPSIS
.nf
#include<_arith2.h>

int pfaval(p,a)       
single p; 
pfel a;

.SH DESCRIPTION
.TP 4
.B p
is a single prime.
.TP 4
.B a 
is the approximation of an element (say A) of the p-adic number field Qp. a is not equal to zero (for the representation of p-adic field elements s. itopfel).
.PP
Let vp be the additive p-adic valuation, then pfadval returns
.IP
vp(a) = vp(A).
 
.SH SEE ALSO
itopfel

M*/
              
/*H
	Version 1       09.03.1990      Christine Hollinger
   DATE pfaval        : 901120
H*/

#define         pfaval( p,a )           lsecond( a )
