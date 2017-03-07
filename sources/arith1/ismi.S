/*M
.SH NAME
ismi - is modular integer ?

.SH SYNOPSIS
.nf
#include<_arith1.h>

single ismi(m,a)
obj m,a;

.SH DESCRIPTION
ismi() returns 1 if 0 < m and a is in Z/mZ,
0 otherwise.
M*/
/*H
	Version 1       29.02.1988      M. Reichert
   DATE ismi          : 890501
H*/


#include <_arith1.h>

single ismi(m,a)
obj m,a;
{
	if ( !isint(m) || !isint(a) ) return(0);
	if ( icomp(m,0) <= 0 ) return(0);
	if ( icomp(a,0) < 0 || icomp(m,a) <= 0 ) return(0);
	return( 1 );
}
