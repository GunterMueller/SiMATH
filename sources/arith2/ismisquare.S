/*M
.SH NAME
ismisquare - is modular integer square ? 

.SH SYNOPSIS
.nf
#include<_arith2.h>

int ismisquare(M, A)  
int M, A;
 
.SH DESCRIPTION
.TP 4
.B M
is a positive integer number.
.TP 4
.B A
is an element in Z/M*Z. 
.PP
ismisquare returns 
.TP 4
-1, if A is not a square in Z/M*Z, and
.TP 4
 W,
(0 <= W < M) with W^2 = A, else.

M*/
                                   
/*H
	Version 1	13.08.1991	J.Schmitt
	Version 2	29.10.1993	von 'arith1 nach 'arith2 wegen 
					Aufruf von UPMIRF aus 'pol2.  PS
   DATE ismisquare    : 910915.931130
H*/

# include <_arith2.h>

int ismisquare(m,a)
int m,a;
{       
	int b;
	init(b);
        bind(m,a);

	if( !a ) return(0);
	b = list4(2,1,0,mineg(m,a));

	b = upmirf(m,b);
	if ( b == _0 ) return(-1);
	a = lfirst(b);
	b = lsecond(b);
	if ( !misum(m,a,b) ) return(a);
	return(-1);
}
