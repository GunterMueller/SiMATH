/*M
.SH NAME
miinv - modular integer inverse

.SH SYNOPSIS
.nf
#include<_arith1.h>

int miinv(M,A)
int M,A;

.SH DESCRIPTION
miinv() returns returns A^(-1) for M>0 and A from Z/MZ in case gcd(A,M)=1,
and 0 otherwise.
M*/
/*H
	Version 1       25.11.1986	M.A.Reichert
        Version 2       19.06.1990      iegcd durch ihegcd ersetzt;   
					ausserdem jetzt Rueckgabewert = 0,
					falls nicht teilerfremd.  MC
	Version 3 	14.02.1992	Essener Arithm. & Beschleuniging.  MC.
	Version 4	15.04.1994	Dokumentation geaendert: 0 <= A < M. MC.
   DATE miinv         : 890501.901120.920331.941201
H*/

#include<_arith1.h>
#ifndef LP64
#include<_Earith.h>
#endif

int miinv(M, A)
int M, A;
{


	single s, lA, lM;


	if (!A)
		A = 0;
	else if (A == 1)
		return (1);
	else if (issingle(M)) {
		A = msinv(M, A);
	} else if (issingle(A)) {
		int X, y, m;
                             
		bind( M );
		init(X, m, y);
		isqrem(M, A, &X, &s);
		if (!s) return (0);     
		else if ( s == 1 ) return( idif( M, X ) );

		y = msinv(s, (A % s));

		if (!y)
			return (0);

		m = isquot(isum(1, isprod(A, -y)), -s);

		A = isum(y, iprod(m, X));
		A = mihom(M, A);
	} else {
#ifdef LP64
	        A = miinv_lo(M, A);
#else
/* Der folgende Test, welche Arithmetik benutzt wird, ist heuristisch  */
/* Das heisst in empirischen Test's ausprobiert                       */
		lA = llength(A);
		if ((lA + (lA << 1) - 6 < (lM = llength(M)))
		    || (lM + lA) >= (LAENGE - 2)) {
			A = miinv_lo(M, A);
		} else {
			LONG ea[LAENGE], em[LAENGE], erg[LAENGE];

			itoE(M, em);
			itoE(A, ea);

			s = EGGT(ea, em, erg, erg);
			if (!s)
				A = Etoi(erg);
			else
				A = 0;
		}
#endif
	}
	return (A);
}
