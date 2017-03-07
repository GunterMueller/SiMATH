/* #define DEBUG 1 */

/*M
.SH NAME
psiiquot - power series over integers, integer quotient

.SH SYNOPSIS
.nf
#include <_arith1.h>

list psiiquot(n, P, m)
single n;
list P;
int m;

.SH DESCRIPTION
psiiquot() computes the first n coefficients of the scalar multiplication
of the series P with integer coefficients by 1/m (if this is possible),
i.e. all the coefficients of the series P are divided by the integer m.

If P does not allow to compute the first n coefficients of the the result,
psiiquot() will compute as many coefficients as possible.

.SH BUGS AND REMARKS
Even if psiiquot() computes less than n coefficients, (e.g.  because less
than n coefficients of P are known) no error or warning is displayed.

psiiquot() uses ordinary SIMATH integer division. psiiquot() returns
a power series with integer coefficients. It is not checked if the
coefficients of P are divisible by m.
M*/
/*H
  	Version 1	01.04.1994	Michael Pfeifer
H*/

#include <assert.h>
#include <_arith1.h>
#include <_debug.h>

list            psiiquot(n, P, m)
    single          n;				  /* the length of the result */
    list            P;				  /* a power series with integer coefficients */
    int             m;				  /* the factor */
{
    if (P == 0)
	return (P);

    if (llength(P) == 2)
	return (P);

    {
	single          K;			  /* the length of P */
	single          i;			  /* a counter */
	single          k;			  /* the lowest index of P */

	int             a;			  /* a coefficient of P */
	list            QUOT;			  /* this is the quotient of P by the scalar m */

	init(a);
	init(QUOT);

	bind(P);
	bind(m);

	assert(llength(P) == lsecond(P) + 2);

	QUOT = _0;
	k = lfirst(P);
	P = lred(P);
	K = lsecond(P);
	P = lred(P);

	for (i = 1; ((i <= n) && (P != _0)); i++) {
	    a = lfirst(P);

#if (DEBUG >= 1)
	    if (mihom(m, a) != 0) {
		DEBUG_LFF;
		printf("quotiont not an integer\n");
	    }
	    fflush(stdout);
#endif

	    a = iquot(a, m);
	    QUOT = lcomp(a, QUOT);
	    P = lred(P);
	}

	QUOT = linv(QUOT);
	QUOT = lcomp(i - 1, QUOT);
	QUOT = lcomp(k, QUOT);

	assert(llength(QUOT) == lsecond(QUOT) + 2);

	return (QUOT);
    }
}
