/*M
.SH NAME
isudpm2sb - is univariate dense polynomial over modular 2 in special bit-representation ?

.SH SYNOPSIS
.nf
#include<_arith2.h>

single isudpm2sb(A)  
obj A;
    
.SH DESCRIPTION
.PP
isudpm2sb returns
.TP 4
1,
if A is a list of non negative singles, which represents an univariate dense polynomial in special bit-representation (also if A = 0), and
.TP 4
0,
else.

.SH SEE ALSO
udpm2tosb

M*/
           
/*H
	Version 1       13.03.1992	A.Stein
   DATE isudpm2sb     : 920331
H*/


# include <_arith2.h>

single isudpm2sb(A)
obj A;
{
	single e, f;

	if( !A ) return(1);
	if( !islistnns(A) ) return(0);
	if( ( lfirst(A)/30 ) != ( llength(A)-2 ) ) return(0);
	if( !( f = lsecond(A) ) ) return(0);
	for( e = 0, f >>= 1; f; f >>= 1) e++;
	if( ( lfirst(A)%30 ) != e ) return(0);	

	return(1);
}
