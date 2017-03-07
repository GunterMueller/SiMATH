/*M
.SH NAME
rhopds - rho-method by Pollard divisor search

.SH SYNOPSIS
.nf
#include<_arith1.h>

int rhopds(N,b,z)
int N;
single b,z;

.SH DESCRIPTION
rhopds() returns a factor of P of N,
worst case P=1 or P=N.
.TP 4
.B N
>1 should not be prime
.TP 4
.B b
>0 should be as random as possible and not to large (i.e. b < 1000)
.TP 4
.B z
is the maximum number of iterations using the polynomial x^2+b

.SH SEE ALSO
N. Koblitz, "A course of Number Theory and cryptography",
Springer 1987, chapter 5.
M*/       
/*H 
	Version 1	13.08.1990	Marc Conrad
	Version 2 	02.07.1992	neu geschrieben mit Essen.  MC
   DATE rhopds        : 901120.921130
H*/

#include <_arith1.h>
#ifndef LP64
#include<_Earith.h>
#endif

int rhopds(N, b, z)
	int N;
	single b, z;
{
#ifdef LP64
    return rhopds_lo(N, b, z);
#else

	single i, v;

	LONG     x[LAENGE], be[3], Ne[LAENGE], vglx[LAENGE];
	LONG  ggte[LAENGE], xq[LAENGE], xdif[LAENGE];

	bind(N);
	if (b > N)
		b = mshom(N, b);

	if (itoEb(N, Ne, (LAENGE - 1) / 2) ) return (rhofrpds(N, b, z));

	itoE(b, be);

	x[0] = 1;
	if (N <= 1967)
		x[1] = 2;
	else
		x[1] = 1967;	/* 1967 : beliebiger Wert */
	z += 2;
	i = 2;
	v = 2;
	Esub(Ne, x, vglx);
	Emquad(x, xq, Ne);
	Emadd(be, xq, x, Ne);
	Eadd(x, vglx, xdif);
/* ---------------- Begin der Iteration ------------------------- */
	while (i < z) {
		if (i == v) {
			if ( (i > 1000)  && Ecompute_ggt(xdif, Ne, ggte) ) {
				return (Etoi(ggte));
			}
			xdif[0] = 1;
			xdif[1] = 1;
			if (Esub(Ne, x, vglx) == -1) {
				Eadd(Ne, Ne, xq);
				Esub(xq, x, vglx);
			}
			v <<= 1;
		}
		i++;
		Emquad(x, xq, Ne);
		Eadd(be, xq, x);
		Eadd(x, vglx, xq);
		Emmult(xdif, xq, ggte, Ne);
		if (ggte[0] == 0) {
			Ecompute_ggt(xdif, Ne, ggte);
			return (Etoi(ggte));
		}
		Etrans(ggte, xdif);

	}

	Ecompute_ggt(xdif, Ne, ggte);
	return (Etoi(ggte));

#endif
}
