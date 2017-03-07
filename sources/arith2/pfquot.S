/*M
.SH NAME
pfquot - p-adic field quotient
(MACRO)

.SH SYNOPSIS
.nf
#include<_arith2.h>

pfel pfquot(p, a, b)        
single p; 
pfel a, b;
     
.SH DESCRIPTION
.TP 4
.B p
is a single prime.
.TP 4
.B a, b
are the approximations of two elements (say A, B resp.) of the p-adic number field Qp (s.itopfel), b != 0.
.PP
pfquot returns the approximation of the p-adic field element A/B.

.SH SEE ALSO
itopfel

M*/
                           
/*H
	Version 1       17.04.1990      Christine Hollinger
   DATE pfquot        : 901120
H*/

#define   pfquot( p,a,b )       ( (a) ? pfprod( p,a,pfinv(p,b) ) : 0 )
