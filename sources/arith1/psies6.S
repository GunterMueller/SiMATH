/* #define DEBUG 1 */

/*M
.SH NAME
psies6 - power series over integers, Eisenstein series of weight 6

.SH SYNOPSIS
.nf
#include <_arith1.h>

list psies6(n)
single n;

.SH DESCRIPTION
psies6() returns the Fourier expansion of the Eisenstein series of weight
6 up to the n-th coefficient.

.SH FILES AND DIRECTORIES
psies6() tries to avoid recomputing coefficients.  All the
coefficients computed by psies6() are written to the file
`$HOME/eisenstein-6-1'. Subsequent calls to psies6() will reuse the
coefficients stored in `$HOME/eisenstein-6-1'.

If the environment variable SIMATH_DATA is set to a writable directory,
psies6() will use the file `$SIMATH_DATA/eisenstein-6-1' instead of
`$HOME/eisenstein-6-1' to store the results of the computations.
M*/
/*H
	Version 1	01.04.1994	Michael Pfeifer
H*/

#include <assert.h>
#include <stdlib.h>
#include <unistd.h>
#include <_arith1.h>
#include <_debug.h>

/*c
	ices6() is static in psies6(). ices6() returns the n-th
	coefficient of the Eisenstein series of weight 6 to psies6().
c*/

/* - static - */

static int      ices6(n)
    single          n;				  /* the index of the coefficient */
{
    int             qesc;			  /* the coefficient of the series */
    list            DL;				  /* the list of the divisors of n */

    init(qesc);
    init(DL);

    if (n == 0)
	return (1);
    else {
	DL = ilistdiv(n);
	qesc = 0;
	while (DL != _0) {
	    qesc = isum(iexp(lfirst(DL), 5), qesc);
	    DL = lred(DL);
	}
	qesc = isprod(qesc, -504);
	return (qesc);
    }
}

/* - extern - */

list            psies6(n)
    single          n;				  /* the length of the Eisenstein series */
{
    FILE           *data_base;			  /* the data file itself */
    char            data_base_name[MAXPATHLEN];	  /* the name of the data file */
    char            env_value[MAXPATHLEN];	  /* the value of the environment variable SIMATH_DATA */
    char            forms_dir[MAXPATHLEN];	  /* the directory storing the modular forms */
    char            short_name[MAXPATHLEN];	  /* the basename of the data file */

    single          i;				  /* a counter */
    single          try_update;			  /* try_update is 1 if we try to update the data base */

    int             qesc;			  /* a coefficient of the Fourier expansion */
    list            ES6;			  /* the list of the coefficients */
    list            LH;				  /* used for creating the list */

    init(qesc);
    init(ES6);
    init(LH);

    if (getenv("SIMATH_DATA") != NULL)
	sprintf(env_value, "%s\0", getenv("SIMATH_DATA"));
    else
	sprintf(env_value, "%s\0", getenv("HOME"));
    sprintf(forms_dir, "%s", env_value);

#if (DEBUG >= 1)
    DEBUG_LFF;
    printf("Reading data from directory `%s'\n", forms_dir);
#endif

    /*
     * First we create the name of the data file and check if we can read it.
     */

    try_update = 0;
    sprintf(short_name, "%s\0", "eisenstein-6-1");
    sprintf(data_base_name, "%s/%s\0", forms_dir, short_name);
    if (access(data_base_name, R_OK) == 0) {

	/*
	 * We can access the data file. We try to read the coefficients we need.
	 */

	single          length;			  /* the length of the series expansion stored in the file */

	int             qesc;			  /* a coefficient of the series expansion */

	init(qesc);

	data_base = fopen(data_base_name, "r");
	length = fgetsi(data_base);
	length = fgetsi(data_base);

	if (n > length)
	    try_update = 1;

	ES6 = list2(0, n);
	LH = ES6;
	for (i = 1; i <= smin(n, length); i++) {
	    qesc = fgeto(data_base);
	    LH = lconc(LH, list1(qesc));
	    LH = lred(LH);
	}
	fclose(data_base);
	for (i = smin(n, length); i < n; i++) {
	    qesc = ices6(i);
	    LH = lconc(LH, list1(qesc));
	    LH = lred(LH);
	}
    }
    else {

	/*
	 * We cannot access the data file. We have to compute all the coefficients we need. We try to update the
	 * data base.
	 */

	try_update = 1;

	ES6 = list2(0, n);
	LH = ES6;
	for (i = 0; i < n; i++) {
	    qesc = ices6(i);
	    LH = lconc(LH, list1(qesc));
	    LH = lred(LH);
	}
    }

    if (try_update == 1) {

	/*
	 * In this case we try to update the data base.
	 */

#if (DEBUG >= 1)
	DEBUG_LFF;
	printf("entering fputpsisv()\n");
	fflush(stdout);
#endif

	fputpsisv(short_name, ES6);

#if (DEBUG >= 1)
	DEBUG_LFF;
	printf("leaving fputpsisv()\n");
	fflush(stdout);
#endif

    }

    assert(llength(ES6) == lsecond(ES6) + 2);

    return (ES6);
}
