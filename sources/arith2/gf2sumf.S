/*M
.SH NAME
gf2sumf - of characteristic 2 sum as function

.SH SYNOPSIS
.nf
#include<_arith2.h>

gf2el gf2sumf(G, a, b)
obj G;
gf2el a,b;

.SH DESCRIPTION
gf2sumf() is identical to gf2sum().

.SH SEE ALSO
gf2sum
M*/
/*H
	Version 1	01.06.1995   E.Herrmann
   DATE gf2sumf       : 951201
H*/
	
#include<_arith2.h>

gf2el gf2sumf( G, a, b)
 obj G;
 gf2el a,b;
{
 return ( gf2sum( G, a, b) );
}

