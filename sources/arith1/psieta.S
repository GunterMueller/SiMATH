/* #define DEBUG 1 */

/*M
.SH NAME
psieta - power series over the integers, Dedekind eta function

.SH SYNOPSIS
.nf
#include <_arith1.h>

list psieta(n)
single n;

.SH DESCRIPTION
psieta() returns the first n coefficients of the Fourier expansion of
the Dedekind eta function. The factor q^(1/24) is omitted.

.SH BUGS AND REMARKS:
Since the factor q^(1/24) is omitted in the expansion, it is the users
responsibility to get correct results when using psieta().
M*/
/*H
	Version 1 	01.04.1994	Michael Pfeifer
H*/

#include <assert.h>
#include <_arith1.h>

list            psieta(n)
    single          n;				  /* the number of coefficients to compute */
{
    single          D;				  /* the discriminant of certain quadratic equation */
    single          S;				  /* the integral part of the square root of D */
    single          k;				  /* a counter for the coefficients */
    single          m1;				  /* this is used to determine the sign of the coefficients */
    single          m2;				  /* nearly the same as m1 */

    list            ETA;			  /* the expansion of the eta function */

    init(ETA);

    ETA = _0;

    for (k = 0; k < n; k++) {
	D = 24 * k + 1;
	S = ssqrt(D);
	if (D == S * S) {

	    /*
	     * The discriminant is a square and the quadratic equation 1/2*(3*m^3 + m) = n is solvable in n.
	     */

	    m1 = S - 1;
	    m2 = -S - 1;
	    if (mshom(6, m1) == 0) {
		m1 = m1 / 6;
		ETA = lcomp(mshom(2, m1) ? -1 : 1, ETA);
	    }
	    else {
		if (mshom(6, m2) == 0) {
		    m2 = m2 / 6;
		    ETA = lcomp(mshom(2, m2) ? -1 : 1, ETA);
		}
		else
		    ETA = lcomp(0, ETA);
	    }
	}
	else
	    ETA = lcomp(0, ETA);
    }

    ETA = lcinv(ETA);
    ETA = lcomp(n, ETA);
    ETA = lcomp(0, ETA);

    assert(llength(ETA) == lsecond(ETA) + 2);

    return (ETA);
}
