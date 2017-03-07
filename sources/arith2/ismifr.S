/*M
.SH NAME
ismifr - is modular integer Fermat residue ?

.SH SYNOPSIS
.nf
#include<_arith2.h>

int ismifr(M, A, B)  
int M, A, B;
 
.SH DESCRIPTION
.TP 4
.B M
is a positive integer number.
.TP 4
.B A, B
are elements in Z/M*Z.
.PP
ismifr returns
.TP 4
-1, 
if B^2 - A is not a square in Z/M*Z, and
.TP 4
W,
(0 <= W < M) with W^2 = B^2 - A, else.

M*/
                        

/*H
	Version 1	13.08.1991	J.Schmitt
	Version 2	27.01.1993	von 'arith1 nach 'arith2.  PS
   DATE ismifr        : 910915.930115
H*/

# include <_arith2.h>

int ismifr(m,a,b)
int m,a,b;
{
        bind(m,a,b);

	b = miprod(m,b,b);
	b = midif(m,a,b);

	if( !b ) return(0);
	b = list4(2,1,0,b);

	b = upmirfspec(m,b);
	if ( b == _0 ) return(-1);
	a = lfirst(b);
	b = lsecond(b);
	if ( !misum(m,a,b) ) return(a);
	return(-1);
}
