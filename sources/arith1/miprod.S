/*M
.SH NAME
miprod - modular integer product

.SH SYNOPSIS
.nf
#include<_arith1.h>

int miprod(M,A,B)
int M,A,B;

.SH DESCRIPTION
miprod() returns A * B for M > 0 and A,B from Z/MZ.
M*/
/*H
	Version 1	09.02.1987	Pascale Serf
	Version 2	12.03.1987	Laufzeit jetzt kuerzer.  PS
	Version 3 	27.04.1992	Laufzeit jetzt noch kuerzer
					(kein Macro mehr).  MC
	Version 4 	11.12.1992	Ausdehneung des Definitions-
					bereiches von A, B.  MC
   DATE miprod        : 890501.9203__.921130.930115
H*/

#ifndef LP64
# include <_Earith.h>
#endif
# include <_arith1.h>

int miprod(M, A, B)
	int M, A, B;
{
	int E;

	if (!A || !B)
		return (0);
	else if (issingle(M)) {
		if (A < 0)
			A = mshom(M, A);
		if (B < 0)
			B = mshom(M, B);
		E = msprod(M, A, B);
	} else {
#ifndef LP64
		LONG eb[LAENGE], ea[LAENGE], em[LAENGE], ee[LAENGE];
#endif
		bind(M, A, B, E);
#ifndef LP64
		if (itoEb(M, em, (LAENGE - 1) / 2))
			E = mihom(M, iprod(A, B));
		else if (1 != itoEsb(A, ea, (LAENGE - 1) / 2))
			E = mihom(M, iprod(A, B));
		else if (1 != itoEsb(B, eb, (LAENGE - 1) / 2))
			E = mihom(M, iprod(A, B));
		else {
			Emmult(ea, eb, ee, em);
			E = Etoi(ee);
		}
#else
		E = iprod(A, B);
		E = mihom(M, E);
#endif
	}
	return (E);
}




