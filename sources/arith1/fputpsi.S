/* #define DEBUG 1 */

/*M
.SH NAME
fputpsi - file put power series over the integers

.SH SYNOPSIS
.nf
#include <_arith1.h>

void fputpsi(P, VL, fp)
list P, VL;
FILE *fp;
	
.SH DESCRIPTION
fputpsi() writes a power series expansion P with integer coefficients in
the variable described by VL onto the file *fp.  The variable described
by VL must not consist of more than one characters.

BUGS AND REMARKS:
All coefficients of the power series are printed (except when the
coefficient is zero). This enables fgetpsi() to read the output of
fputpsi(). The program has to be replaced by another version according
to general SIMATH conventions.
M*/
/*H
	Version 1	01.04.1994	Michael Pfeifer
H*/

#include <assert.h>
#include <_arith1.h>

void            fputpsi(P, VL, fp)
    list            P;				  /* the power series to be printed */
    list            VL;				  /* a variable list */
    FILE           *fp;				  /* a file pointer */
{
    single          ind;			  /* a counter */

    int             vl;				  /* the coefficients of the series */
    int             coeff;			  /* a coefficient of the series */
    list            HP;				  /* a pointer to the entries of P */

    bind(P);
    bind(VL);

    init(vl);
    init(coeff);
    init(HP);

    assert(llength(P) == lsecond(P) + 2);

    vl = lfirst(lfirst(VL));
    ind = lfirst(P);
    HP = lred2(P);

    while (HP != _0) {
	coeff = lfirst(HP);

	assert(isint(coeff));

	if (coeff == 0) {
	    ind++;
	    HP = lred(HP);
	    continue;
	}
	if (icomp(coeff, 0) > 0) {
	    fputs(" + ", fp);
	    fputi(iabs(coeff), fp);
	    fputc('*', fp);
	    fputc(vl, fp);
	    fputc('^', fp);
	    fputsi(ind, fp);
	    ind++;
	    HP = lred(HP);
	}
	else {
	    fputs(" - ", fp);
	    fputi(iabs(coeff), fp);
	    fputc('*', fp);
	    fputc(vl, fp);
	    fputc('^', fp);
	    fputsi(ind, fp);
	    ind++;
	    HP = lred(HP);
	}
    }
    fputs(" + O(", fp);
    fputc(vl, fp);
    fputc('^', fp);
    fputsi(ind, fp);
    fputc(')', fp);
}
