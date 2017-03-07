/* #define DEBUG 1 */

/*M
.SH NAME
psidisc - power series over the integers, discriminant

.SH SYNOPSIS
.nf
#include <_arith1.h>

list psidisc(n)
single n;

.SH DESCRIPTION
psidisc() returns the first n coefficients of the Fourier expansion of
the discriminant modular form.

.SH FILES AND DIRECTORIES
psidisc() tries to avoid recomputing coefficients.  All the
coefficients computed by psidisc() are written to the file
`$HOME/discriminant'. Subsequent calls to psidisc() will reuse the
coefficients stored in `$HOME/discriminant'.

If the environment variable SIMATH_DATA is set to a writable directory,
psidisc() will use the file `$SIMATH_DATA/discriminant' instead of
`$HOME/discriminant' to store the results of the computations.
M*/
/*H
	Version 1 	01.04.1994	Michael Pfeifer
H*/

#include <assert.h>
#include <stdlib.h>
#include <unistd.h>
#include <_arith1.h>
#include <_debug.h>

list            psidisc(n)
    single          n;				  /* the number of coefficients to compute */
{
    FILE           *data_base;			  /* the data file itself */
    char            data_base_name[MAXPATHLEN];	  /* the name of the data file */
    char            env_value[MAXPATHLEN];	  /* the value of the environment variable SIMATH_DATA */
    char            forms_dir[MAXPATHLEN];	  /* the directory storing the modular forms */
    char            short_name[MAXPATHLEN];	  /* the basename of the data file */

    single          i;				  /* a counter */
    single          length;			  /* the length of the series expansion stored in the file */
    single          try_update;			  /* try_update is 1 if we try to update the data base */

    int             qesc;			  /* a coefficient of the Fourier expansion */
    list            DISC;			  /* the list of the coefficients */
    list            LH;				  /* used for creating the list */

    init(qesc);
    init(DISC);
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
     * We create the name of the data file and check if we can read it.
     */

    length = 0;
    try_update = 0;
    sprintf(short_name, "discriminant");
    sprintf(data_base_name, "%s/%s", forms_dir, short_name);
    if (access(data_base_name, R_OK) == 0) {

	/*
	 * We can access the data file. We try to read the coefficients we need.
	 */

	data_base = fopen(data_base_name, "r");
	length = fgetsi(data_base);
	length = fgetsi(data_base);

	if (length >= n) {

	    /*
	     * We find everything we need in the data file.
	     */

	    DISC = list2(1, n);
	    LH = DISC;
	    for (i = 1; i <= n; i++) {
		qesc = fgeto(data_base);
		LH = lconc(LH, list1(qesc));
		LH = lred(LH);
	    }
	}
	fclose(data_base);
    }

    if (length < n) {
	list            ES4;			  /* the third power of the Eisenstein series of weight 4 */
	list            ES6;			  /* the square of the Eisenstein series of weight 6 */

	init(ES4);
	init(ES6);

	/*
	 * We recompute all coefficients. We compute the first n + 1 coefficients of the Eisenstein series, since
	 * we know that the discriminant is a cusp form and therefore the first coefficient vanishes when
	 * subtracting ES6 from ES4.
	 */

	try_update = 1;
	ES4 = psipes4(n + 1, 3);
	ES6 = psipes6(n + 1, 2);
	DISC = psidif(n + 1, ES4, ES6);
	DISC = psiiquot(n, DISC, 1728);
    }

    if (try_update == 1) {

	/*
	 * In this case we try to update the data base.
	 */

#if (DEBUG >= 1)
	printf("entering fputpsisv()\n");
	fflush(stdout);
#endif

	fputpsisv(short_name, DISC);

#if (DEBUG >= 1)
	printf("leaving fputpsisv()\n");
	fflush(stdout);
#endif

    }

    assert(llength(DISC) == lsecond(DISC) + 2);

    return (DISC);
}
