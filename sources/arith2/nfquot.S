/*M
.SH NAME
nfquot - number field quotient

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel nfquot( F, a, b )  
pol F; 
nfel a, b;
    
.SH DESCRIPTION
.TP 4
.B F
is an irreducible, univariate polynomial in dense representation over Z. F generates a number field, say K.
.TP 4
.B a, b
are elements of K (for representation of number field elements s. nfneg), b != 0.
.PP
nfquot returns an element of K, say c, where 
.IP
c = a * b^(-1).

.SH SEE ALSO
nfneg

M*/
    
/*H
	Version 1       01.03.1989      Christine Hollinger
   DATE nfquot        : 890601.9011__
H*/

#include <_arith2.h>

nfel nfquot( F, a, b )
pol F;
nfel a,b;
{
	bind( F, a, b );

	if( a )
	{       b = nfinv( F,b );
		a = nfprod( F, a, b );
	}
	return( a );
}
