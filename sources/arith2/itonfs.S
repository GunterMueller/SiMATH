/*M
.SH NAME
itonfs - integer to number field element, sparse representation

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel itonfs(A)  
int A;
 
.SH DESCRIPTION
.TP 4
.B A
is an integer number.
.PP
itonfs returns the representation of A as an univariate polynomial over the rational numbers in sparse representation.

M*/

/*H
	Version 1       15.07.1988      Pascale Serf
	Version 2       22.07.1988      nf durch nfs ersetzt.  PS
   DATE itonfs        : 890501
H*/


# include <_arith2.h>

nfel itonfs(A)
int A;
{
	/***    Fall : A != 0    ***/
	if ( A ) A = itor(A), A = list2(0,A);

	return(A);
}
