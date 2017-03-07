/*M
.SH NAME
pfdif - p-adic field element difference
(MACRO)

.SH SYNOPSIS
.nf
#include<_arith2.h>

pfel pfdif(p, a, b)   
single p; 
pfel a, b;
 
.SH DESCRIPTION
.TP 4
.B p
is a single prime.
.TP 4
.B a, b
are the approximations of two elements (say A, B resp.) of the p-adic number field Qp (s.itopfel).
.PP
pfdif returns the approximation a - b, which is equal to  A - B at the first 
min( d,d' ) + 1 - vp( A - B ) digits (for the definition of d see itopfel; d' analogous to d , but with regard to b). 

.SH SEE ALSO
itopfel

M*/
                                                  
/*H
	Version 1       07.03.1990      Christine Hollinger
   DATE pfdif         : 901120
H*/

#define         pfdif( p, a, b )        pfsum( p, a, pfneg( p,b ) )
