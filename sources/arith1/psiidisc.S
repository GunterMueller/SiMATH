/* #define DEBUG 1 */

/*M
.SH NAME
psiidisc - power series over the integers, inverse of the discriminant

.SH SYNOPSIS
.nf
#include <_arith1.h>
	
list psiidisc(n)
single n;

.SH DESCRIPTION
psiidisc() returns the first n coefficients of the Fourier expansion of
the inverse of the discriminant modular form.

.SH FILES AND DIRECTORIES
psiidisc() tries to avoid recomputing coefficients.  All the
coefficients computed by psiidisc() are written to the file
`$HOME/discriminant-inverse'. Subsequent calls to psiidisc() will reuse
the coefficients stored in `$HOME/discriminant-inverse'.

If the environment variable SIMATH_DATA is set to a writable directory,
psiidisc() will use the file `$SIMATH_DATA/discriminant-inverse' instead
of `$HOME/discriminant-inverse' to store the results of the computations.
M*/
/*H
	Version 1	01.04.1994	Michael Pfeifer
H*/

#include <assert.h>
#include <stdlib.h>
#include <unistd.h>
#include <_arith1.h>
#include <_debug.h>

list            psiidisc(n)
    single          n;
{
    FILE           *data_base;			  /* the data file itself */
    char            data_base_name[MAXPATHLEN];	  /* the name of the data file */
    char            env_value[MAXPATHLEN];	  /* the value of the environment variable SIMATH_DATA */
    char            forms_dir[MAXPATHLEN];	  /* the directory storing the modular forms */
    char            short_name[MAXPATHLEN];	  /* the basename of the data file */

    single          first;			  /* the beginning of the expansion */
    single          i;				  /* a counter */
    single          length;			  /* the length of the series expansion stored in the file */
    single          s;				  /* the number of coefficients we read from the file */
    single          try_update;			  /* try_update is 1 if we try to update the data base */

    int             qesc;			  /* a coefficient of the Fourier expansion */
    list            DISC;			  /* the series expansion of the discriminant */
    list            IDISC;			  /* the list of the coefficients */
    list            LH;				  /* used for creating the list */
    list            P;				  /* the first part of the expansion of the inverse */

    init(qesc);
    init(DISC);
    init(IDISC);
    init(LH);
    init(P);

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
    sprintf(short_name, "discriminant-inverse");
    sprintf(data_base_name, "%s/%s", forms_dir, short_name);
    if (access(data_base_name, R_OK) == 0) {

	/*
	 * We can access the data file. We try to read the coefficients we need.
	 */

	data_base = fopen(data_base_name, "r");
	first = fgetsi(data_base);
	length = fgetsi(data_base);
	s = smin(n, length);
	P = list2(-1, s);
	LH = P;
	for (i = 1; i <= s; i++) {
	    qesc = fgeto(data_base);
	    LH = lconc(LH, list1(qesc));
	    LH = lred(LH);
	}
	fclose(data_base);
	if (s < n)
	    try_update = 1;
    }
    else {
	P = _0;
	try_update = 1;
    }

    DISC = psidisc(n);
    IDISC = psiinvsv(n, DISC, P);

    if (try_update == 1) {

#if (DEBUG >= 1)
	DEBUG_LFF;
	printf("entering fputpsisv()\n");
	fflush(stdout);
#endif

	fputpsisv(short_name, IDISC);

#if (DEBUG >= 1)
	DEBUG_LFF;
	printf("leaving fputpsisv()\n");
	fflush(stdout);
#endif

    }

    assert(llength(IDISC) == lsecond(IDISC) + 2);

    return (IDISC);
}
