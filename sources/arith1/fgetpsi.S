/* #define DEBUG 1 */

/*M
.SH NAME
fgetpsi - file get power series over the integers

.SH SYNOPSIS
.nf
#include <_arith1.h>

list fgetpsi(VL, fp)
list VL;
FILE *fp;

.SH DESCRIPTION
fgetpsi() reads a power series expansion with integer coefficients in the
variable represented by the list of variables VL from the file *fp. The
variable must not consist of more than one character. The input must be
terminated by a "big-O" symbol. Exponents and coefficients of the series
must not be omitted. A valid power series representation for this program
is e.g.
.HP
	1*q^0 + 2*q^1 + 3*q^2 + O(q^3).

.SH BUGS AND REMARKS
The representation of the power series is too restrictive for everyday
applications. The program has to be replaced by another version
according to general SIMATH conventions, in order to allow a more general
representation of power series.
M*/
/*H
	Version 1	01.04.1994	Michael Pfeifer
H*/

#include <assert.h>
#include <_arith1.h>

#define COEFFICIENT 0
#define EXPONENT 1

list            fgetpsi(VL, fp)
    list            VL;				  /* the variable list */
    FILE           *fp;				  /* a file pointer */
{
    char            c;				  /* a character */

    single          acc;			  /* the term in the "big O" */
    single          end;			  /* a flag, set when reaching the end of the input string */
    single          exp;			  /* an exponent in the series */
    single          flag;			  /* distinguishes between coefficients and exponents */
    single          i;				  /* a counter */
    single          ind;			  /* the lowest index in the series */
    single          sign;			  /* the sign of a number */

    list            L;				  /* a list of coefficients and exponents */
    list            P;				  /* this list will be returned */
    int             number;			  /* a coefficient of the series */

    bind(VL);

    init(L);
    init(P);
    init(number);

    L = _0;
    end = 0;
    sign = 1;
    flag = COEFFICIENT;
    while (1) {
	c = fgetc(fp);
	if (c == '^')
	    sign = 1;
	if (c == '+')
	    sign = 1;
	if (c == '-')
	    sign = -1;
	if (c == 'O')
	    end = 1;
	if (isdigit(c) && (end == 0)) {
	    ungetc(c, fp);
	    number = fgeti(fp);
	    number = iprod(sign, number);
	    if (flag == COEFFICIENT) {
		L = lcomp(number, L);
		flag = EXPONENT;
	    }
	    else {
		L = lcomp(number, L);
		flag = COEFFICIENT;
	    }
	}
	if (isdigit(c) && (end == 1)) {
	    ungetc(c, fp);
	    acc = fgeti(fp);
	    break;
	}
    }

    L = linv(L);

    if (L != _0) {
	ind = lsecond(L);
	P = _0;
	for (i = ind; i < acc; i++)
	    P = lcomp(0, P);
	while (L != _0) {
	    number = lfirst(L);
	    exp = lsecond(L);
	    L = lred2(L);
	    leset(P, exp - ind + 1, number);
	}
	P = lcomp(acc - ind, P);
	P = lcomp(ind, P);
    }
    else {
	P = list2(acc, 0);
    }

    assert(llength(P) == lsecond(P) + 2);

    return (P);
}
