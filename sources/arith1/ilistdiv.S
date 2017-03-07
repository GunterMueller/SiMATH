/* #define DEBUG 1 */

/*M
.SH NAME
ilistdiv - integer list of divisors

.SH SYNOPSIS
.nf
#include <_arith1.h>
	
list ilistdiv(n)
int n;

.SH DESCRIPTION
ilistdiv() returns a list of all the divisors of the positive integer n.
In general, the list is not sorted.
M*/
/*H
	Version 1	01.04.1994	Michael Pfeifer
H*/

#include <_arith1.h>

list            ilistdiv(n)
    int             n;				  /* compute the list of all divisors of n */
{
    single          i;				  /* a counter */

    int             p;				  /* a prime in the factor exponent list of n */
    int             pp;				  /* powers of p */
    list            DL;				  /* the list of all the divisors of n */
    list            FE;				  /* the factor exponent list of n */
    list            PL;				  /* the list of the powers of a prime */

    bind(n);

    init(p);
    init(pp);
    init(DL);
    init(FE);
    init(PL);

    if (n == 1) {
	return (list1(1));
    }

    /*
     * First we initialize the divisor list DL and create a factor exponent list FE of n.
     */

    DL = list1(1);
    FE = ifel(ifact(n));

    /*
     * Now we work through the factor exponent list. For every prime we create a list of powers and then we
     * "multiply" the lists.
     */

    while (FE != _0) {
	p = lfirst(FE);
	FE = lred(FE);
	i = lfirst(FE);
	FE = lred(FE);

	PL = list1(1);
	pp = 1;
	for (; i > 0; i--) {
	    pp = iprod(p, pp);
	    PL = lcomp(pp, PL);
	}

	DL = liprod(DL, PL);
    }

    return (DL);
}
