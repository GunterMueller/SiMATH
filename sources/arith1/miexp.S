/*M
.SH NAME
miexp - modular integer exponentiation

.SH SYNOPSIS
.nf
#include<_arith1.h>

int miexp(M,A,E)
int M,A,E;

.SH DESCRIPTION
miexp() returns returns A ^ E for E >=0, M >0 and A in Z/MZ.
M*/

/*H
	Version 1       18.08.1988              B. Weis
	Version 2 	01.05.1992		Essener Arithmetik.  MC
   DATE miexp         : 890501.921130
H*/

#ifndef LP64
#include <_Earith.h>
#endif
#include <_arith1.h>

int miexp(M, A, E)
	int M, A, E;
{
#ifndef LP64
	LONG eb[LAENGE], ea[LAENGE], em[LAENGE], ee[LAENGE];
#endif
	bind(M, A, E);
        if( isign(E)<0 ){
	        errmsgio("miexp", "A105");
		return(ERROR);
	}

#ifdef LP64
	/*** Essen arith. doesn't work on 64bit machines. ***/
	return (miexp_lo(M, A, E));
#else
	if (!E)
		A = 1;
	else if (issingle(E)) {
		if (issingle(M)) {
			A = msexp(M, A, E);
		} else {
			if (itoEb(M, em, LAENGE / 2 - 1))
				return (miexp_lo(M, A, E));
			itoE(A, ea);
			ee[0] = 1;
			ee[1] = 1;
			while (E != 1) {
				if (E & 1)
					Emmult(ea, ee, ee, em);
				Emquad(ea, ea, em);
				E >>= 1;
			}
			Emmult(ea, ee, ee, em);
			A = Etoi(ee);
		}
	} else {


		if (itoEb(M, em, LAENGE / 2 - 2) ||
		    itoEb(E, ee, LAENGE - 2)) {
			A = miexp_lo(M, A, E);
		} else {
			itoE(A, ea);
			Emexp(ea, ee, eb, em);
			A = Etoi(eb);
		}
	}
/* Ausgabe */

	return (A);
#endif
}
