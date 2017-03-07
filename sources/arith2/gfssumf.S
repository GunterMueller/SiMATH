/*M
.SH NAME
gfssumf - Galois-field with single characteristic sum as function

.SH SYNOPSIS
.nf
#include<_arith2.h>

gfel gfssumf(p, AL, a, b)  
single p; 
list AL; 
gfel a, b;
 
.SH DESCRIPTION
.TP 4
.B p
is a prime number.
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(p^n), where n = lenght(AL1)+1 (s. gfsalgen).
.TP 4
.B a, b
are elements in GF(p^n), represented as univariate polynomials over Z/pZ of degree < n.  
.PP
gfssumf returns the same result as the macro gfsum, namely the sum of a and b in GF(p^n).

.SH SEE ALSO
 gfsalgen
 gfssum

M*/
                         
/*H
	Version 1       12.09.1990	Th. Weis
   DATE gfssumf       : 910915
H*/

#include <_arith2.h>

gfel gfssumf( p, AL, a, b )
single p;
list   AL;
gfel   a, b;

{
	return( pmssum( 1, p, a, b ) );
}
