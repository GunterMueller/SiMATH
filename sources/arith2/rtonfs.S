/*M
.SH NAME
rtonfs - rational number to number field element, sparse representation

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel rtonfs(R)  
rat R;

.SH DESCRIPTION
.TP 4
.B R
is a rational number.
.PP
rtonfs returns the representation of R as an univariate sparse polynomial over the rational numbers.
 
M*/
      
/*H
	Version 1       15.07.1988      Pascale Serf
	Version 2       22.07.1988      nf durch nfs ersetzt.  PS
   DATE rtonfs        : 890501
H*/


# include <_arith2.h>

nfel rtonfs(R)
int R;
{
	/***    Fall : R != 0    ***/
	if ( R ) R = list2(0,R);

	return(R);
}
