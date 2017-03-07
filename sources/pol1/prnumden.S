/*M
.SH NAME
prnumden - polynomial over the rationals numerator and denominator

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol prnumden(r, P, pA)
single r;
pol P;
int *pA;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P
is a polynomial in r variables over the rational numbers.
.TP 4
. B pA
points on an integer.
.PP
prnumden computes the integer n and the polynomial P1 in r variables over the integer numbers, where
.IP
 P = P1/n,   and
 the gcd of the basis coefficients of P1 is coprime  
 to n.
.PP
If P = 0, n is 1.
.PP
prnumden returns the polynomial P1 and writes n to *pA.

M*/

/*H
	Version 1       08.02.1988      B. Weis
	Version 2       20.06.1988      B. Weis
			Header berichtigt
   DATE prnumden      : 890501
H*/


#include <_pol1.h>

pol prnumden(r,P,pA)
single r;
pol P;
int *pA;
{
	int A, B, C;
	pol P1=0, PS;
	bind(P,P1);
	init(A,B,C);

/* P ungleich 0 */

	if (P) {

/* r gleich 0 */

		if (!r) P1 = lfirst(P), *pA = lsecond(P);

/* allgemeiner Fall */

		else {
			P1 = ptodip(r,P);
			A = lsecond(lfirst(P1));
			PS = lred2(P1);
			while (PS != _0) {
				A = ilcm(A,lsecond(lfirst(PS)));
				PS = lred2(PS);
				}
			PS = P1;
			while (PS != _0) {
				B = lfirst(PS);
				C = lfirst(B);
				B = lsecond(B);
				B = iquot(A,B);
				C = iprod(C,B);
				lsfirst(PS,C);
				PS = lred2(PS);
				}
			P1 = diptop(r,P1);
			*pA = A;
			}
		}
	else *pA = 1;

/* Ausgabe */

	return(P1);
}
