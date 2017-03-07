/*M
.SH NAME
itor - integer to rational number

.SH SYNOPSIS
.nf
#include<_arith1.h>

rat itor(A)
int A;

.SH DESCRIPTION
itor() returns the value of the integer number A
as a rational number.
M*/

/*H
	Version 1       28.7.1986               R.Boeffgen
	Version 2       18.2.1987               Macro zu Funktion
						H.Stroeher
   DATE itor          : 890501
H*/


# include <_arith1.h>

rat itor ( A )
int A;
{
	bind( A );
	if ( A ) A = list2( A, 1 );
	return( A );
}
