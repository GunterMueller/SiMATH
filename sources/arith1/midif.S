/*M
.SH NAME
midif - modular integer difference

.SH SYNOPSIS
.nf
#include<_arith1.h>

int midif(M,A,B)
int M,A,B;

.SH DESCRIPTION
midif() returns A - B for M > 0 and A,B from Z/MZ. 
M*/
/*H
	Version 1        9.2.1987               Pascale Serf
	Version 2       12.3.1987               Macro --> Unterprogramm
						  Pascale Serf
   DATE midif         : 890501
H*/


# include <_arith1.h>

int midif(M,A,B)
int M,A,B;
{
	int C;

	bind3(M,A,B);
	init(C);

	C = idif(A,B);
	if ( isign(C) < 0 ) return(isum(M,C));
	else return(C);
}
