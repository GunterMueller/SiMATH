/*M
.SH NAME
isqrt - integer square root

.SH SYNOPSIS
.nf
#include<_arith1.h>

int isqrt(A)
int A;

.SH DESCRIPTION
isqrt() returns the integer part of the square root
of A for A >= 0.
M*/
/*H
	Version  1      23.06.1986      R.Boeffgen
	Version  2      29.06.1987      B nicht mehr ganzz. gerundet.  RB
	Version  3      07.04.1988      C eingebunden.  RB
	Version  4 	04.06.1992	Essen und diverse Beschl.  MC
   DATE isqrt         : 890501.921130
H*/


# include <_arith1.h>
#ifndef LP64
# include <_Earith.h>     

#define local_LAENGE 26
#endif

int isqrt(A)
     int A;
{

    if (issingle(A))
	return (ssqrt(A));
    else if (lred(lred(A)) == _0) {
	/*  Falls A = ( a, b )  */
	/*    einfach-genaue Approx */
	single a, b, n;
	single zaehl;

	bind(A);

	a = lfirst(A);
	b = lsecond(A);

	n = slog2(b);
	n += sodd(n);

	a = (b << (30 - n)) | (a >> n);
	b = ssqrt(a) + 1;
	b = b << (n >> 1);

	/*    modifizierte Newton-Methode  */

	do {
	    a = isquot(A, b);
	    b = (b + a) >> 1;
	} while ( b > a );
	return ( b );

    } else {
#ifdef LP64
	return (isqrt_lo(A));
#else
		LONG ea[local_LAENGE], erg[local_LAENGE];
/* SIMATH-isqrt in gewissen Faellen schneller   */

		if (LAENGE < local_LAENGE || itoEb(A, ea, local_LAENGE - 3)) {
			return (isqrt_lo(A));

		} else {
			Ewurzel(ea, erg);
			return (Etoi(erg));
		}
#endif
    }
}
