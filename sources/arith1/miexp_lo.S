/*M
.SH NAME
miexp_lo - modular integer exponentiation ( lists only )

.SH SYNOPSIS
.nf
#include<_arith1.h>

int miexp_lo(M,A,E)
int M,A,E;

.SH DESCRIPTION
miexp_lo() returns A ^ E for E >=0, M >0 and A in Z/MZ.
The computation is completely performed within the SIMATH memory
management, i.e. using only lists.
M*/

/*H
	Version 1       26.02.92    	Marc Conrad (altes miexp)
   DATE miexp_lo      : 921130
H*/


#include <_arith1.h>

int miexp_lo(M,A,E)
int M, A, E;
{
	single i;
	unsigned e1;
	int B;
	bind(M,A,E);
	init(B);

	if (isign(E)<0){
	        errmsgio("miexp_lo", "A105");
		return(ERROR);
	}
	if (!E) B = 1;
	else if (E == 1) B = A;
	else {
		if (issingle(E)) {e1 = E; E = _0;}
		else {E = lcinv(E); e1 = lfirst(E); E = lred(E);}
		for (i = BLOG2; !(e1 & (1<< --i)); );
		B = A;
		for ( ; i; ) {
			B = miprod(M,B,B);
			if (e1 & (1<< --i)) B = miprod(M,B,A);
		}
		while (E != _0) {
			e1 = lfirst(E);
			E = lred(E);
			for (i = BLOG2; i; ) {
				B = miprod(M,B,B);
				if (e1 & (1<< --i)) B = miprod(M,B,A);
			}
		}
	}

/* Ausgabe */

	return(B);
}
