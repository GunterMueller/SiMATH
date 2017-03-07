/*M
.SH NAME
igcd - integer greatest common divisor

.SH SYNOPSIS
.nf
#include<_arith1.h>

int igcd(A,B)
int A,B;

.SH DESCRIPTION
igcd() returns the greatest common divisor of A and B.
M*/
/*H
	Version  1      23.06.1986      R. Boeffgen
	Version  2	14.02.1992	Essener Arithm. eingebaut.  MC
   DATE igcd          : 890501.920331
H*/

#include<_arith1.h>
#ifndef LP64
#include<_Earith.h>
#endif

int igcd(A, B)
	int A, B;
{

	if (!A)
		return (B);
	else if (!B)
		return (A);
	else if (issingle(A)) {
		A = sabs(A);
		if issingle(B) 
			return (sgcd(A, sabs(B)));
		else
			return (sgcd(A, mshom(A, B)));
	} else if (issingle(B)) {
		B = sabs(B);
		return (sgcd(B, mshom(B, A)));
	} else
#ifdef LP64
	        return igcd_lo(A, B);
#else
	{
		LONG eb[LAENGE], ea[LAENGE];

		bind(A, B);

		if (itoEsb(A, ea, LAENGE - 1) == 2 ||
		    itoEsb(B, eb, (LAENGE - 1) - ea[0]) == 2) {
			A = igcd_lo(A, B);
		} else {
			Ecompute_ggt(ea, eb, ea);
			A = Etoi(ea);
		}
		return (A);
	}
#endif

}
