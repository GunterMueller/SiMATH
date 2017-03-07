/*M
.SH NAME
ifelprod - integer factor exponent list product

.SH SYNOPSIS
.nf
#include<_arith2.h>

list ifelprod( a,b )  
list a, b;
   
.SH DESCRIPTION
.TP 4
.B a, b
are the factor-exponent lists of two integer numbers, say A, B respectively, both not equal to zero.
.PP
ifelprod returns the factor-exponent list of an integer number, say C, where
.IP
C = A * B.

M*/
                                  
/*H
	Version 1        3.08.1988      Christine Hollinger
	Version 2	24.09.1991	J.S. pisum ersetzt, da pisum
					nur single Primteiler zuliesse.
   DATE ifelprod      : 890501.891001.910930.9203__
H*/


#include<_arith2.h>

list ifelprod( a,b )
list a,b;
{
	list P3;
	int e1, e2;
	single k1,k2;
	init(P3,e1,e2);
	bind(a,b);

	if( a == _0 ) return(b);
	if( b == _0 ) return(a);
	P3 = _0;
	do {
		e1 = lfirst(a);
		e2 = lfirst(b);
		if ( icomp(e1,e2) > 0 ) {
			a  = lred(a);
			k1 = lfirst(a);
			a  = lred(a);
			P3 = lcomp2(k1,e1,P3);
		}
		else {
			if ( icomp(e1,e2) < 0 ) {
				b  = lred(b);
				k2 = lfirst(b);
				b  = lred(b);
				P3 = lcomp2(k2,e2,P3);
			}
			else {
				a  = lred(a);
				b  = lred(b);
				k1 = lfirst(a);
				k2 = lfirst(b);
				a  = lred(a);
				b  = lred(b);
				k1 = k1 + k2;
				P3 = lcomp2(k1,e1,P3);
			}
		}
	} while (a != _0  &&  b != _0);
	if (a  == _0) a = b;
	if (P3 == _0) P3 = a;
	else {
		b  = P3;
		P3 = linv(b);
		lsred(b,a);
	}

	return(P3);
}
