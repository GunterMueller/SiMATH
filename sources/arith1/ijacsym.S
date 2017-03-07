/*M
.SH NAME
ijacsym - integer Jacobi-symbol

.SH SYNOPSIS
.nf
#include<_arith1.h>

single ijacsym(A,B)
int A,B;

.SH DESCRIPTION
ijacsym() returns the value of the Jacobi-symbol (A / B)
or 1 in case B equals 1.

.PP
.TP 4
.B A
is an integer.
.TP 4
.B B
is an odd, positive integer with gcd(A,B) = 1.
M*/
/*H
	Version 1       08.01.1987      M.A. Reichert
	Version 2 	19.05.1992	komplett neu (mit Essen).  MC
   DATE ijacsym       : 890501.9011__.9107__.921130.9512__
H*/

#include<_arith1.h>
#ifndef LP64
#include<_Earith.h>
#endif

single ijacsym(A, B)
     int A, B;
{
#ifdef LP64
    return (ijacsym_lo(A, B));
#else

	LONG eb[LAENGE], ea[LAENGE];

	bind(A, B);
	if (isign(A) < 0)
		A = mihom(B, A);
	if (itoEb(A, ea, (LAENGE - 1) / 2) ||
	    itoEb(B, eb, (LAENGE - 1) / 2)) {
		A = ijacsym_lo(A, B);
	} else
		A = (single) (Ejacobi(ea, eb));
	return (A);
#endif
}
