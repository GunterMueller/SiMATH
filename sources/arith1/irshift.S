/*M
.SH NAME
irshift - integer right shift

.SH SYNOPSIS
.nf
#include<_arith1.h>

int irshift(A)
int A;

.SH DESCRIPTION
irshift() returns A/2 for A>=0 and is much faster than iquot(A, 2).

.SH SEE ALSO
ip2prod, ip2quot, iquot.
M*/
/*H
	Version 1 	02.06.1992	Marc Conrad
   DATE irshift       : 921130
H*/


# include <_arith1.h>

#define lpmoc( A, a ) { A = AVAIL;  AVAIL = lred( AVAIL ); \
lsfirst( A, (a) ); if ( AVAIL == _0 ) {gc(); lsred( A, AVAIL );} }

int irshift(A)
	int A;
{
	if (issingle(A))
		return (A >> 1);
	else {
		list BB, B;
		single a, b;
                             
		bind ( A  );
		init ( BB );

		if (AVAIL == _0)
			gc();
		BB = AVAIL;

		a = lfirst(A);
		A = lred(A);


		while (A != _0) {
			b = lfirst(A);
			A = lred(A);
			a = (a >> 1) | ((b & 1) ? (1 << 29) : 0);
			lpmoc(B, a)
				a = b;
		}
		if (a >> 1) {
			lpmoc(B, (a >> 1) )
		}      
		lsred(B, _0);
		if ( lred( BB ) == _0 ) { return ( lfirst( BB ) );}
		else { return (BB); }
	}

}
