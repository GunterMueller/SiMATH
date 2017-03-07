/* #define DEBUG 1 */

/*M
.SH NAME
fputpsisv - file put power series over the integers, special version

.SH SYNOPSIS
.nf
#include <_arith1.h>

void fputpsisv(s, L)
char *s;
list L;

.SH DESCRIPTION
fputpsisv() is used, to store Fourier expansions of modular forms and
functions in a file in the user's home directory. If the environment
variable SIMATH_DATA is set to a writable directory, fputpsisv() writes
to a file in the directory given by the environment variable SIMATH_DATA.

fputpsisv() writes the list L to the file `$HOME/NAME' or to the file
`$SIMATH_DATA/NAME', where NAME = *s is the name of the data file.

Let the Fourier expansion L be represented by the list
.HP
	L = (first, length, a_first, a_{first + 1} , ... , a_{first + length}).
.PP
fputpsisv() writes `first' and `length' as integers to the data file. The
entries
.HP
	a_first, a_{first + 1}, ... , a_{first + length}
.PP
are written as objects to the file. All objects in the
file are separated by newline characters. Therefore, the data
file for the above list L has the form
.nf

		first
		length
		a_first
		a_{first + 1}
		a_{first + 2}
		  .
		  .
		  .
		a_{first + length}

.fi
While fputpsisv() is writing to a file, a lock file is created, that
prevents other processes from writing to the same file at the same
time. In this case, the data of the second process is written to the
current working directory.

fputpsisv() protects itself against interrupts by ignoring the SIGINT
signal while writing to the data file.

.SH BUGS AND REMARKS
fputpsisv() does not care about the form of the data to update. It may
be used in any application dealing with series expansions.
M*/
/*H
  	Version 1	01.04.1994	Michael Pfeifer
  	Version 2	18.12.1998	Marc Conrad (MAXHOSTNAMELEN)
H*/

#include <signal.h>
#include <stdlib.h>
#include <unistd.h>
#include <_arith1.h>
#include <_debug.h>

/* MAXHOSTNAMELEN scheint nicht ueberall definiert zu sein (?) */
#ifndef MAXHOSTNAMELEN
#define MAXHOSTNAMELEN 128
#endif

/*c
	write_list() actually writes the data to the file once all the
	administrative tasks are done.
c*/

/* - static - */

static void     write_list(f, L)
    FILE           *f;				  /* the data file to write to */
    list            L;				  /* the list to be written */
{
    list            LH;				  /* nothing special */
    obj             OBJ;			  /* an object */

    bind(L);

    init(LH);
    init(OBJ);

    LH = L;
    while (LH != _0) {
	OBJ = lfirst(LH);
	LH = lred(LH);
	fputo(OBJ, f);
	fprintf(f, "\n");
    }
}

/* - extern - */

void            fputpsisv(s, L)
    char           *s;				  /* the name of the data base to update */
    list            L;				  /* a list of data */
{
    FILE           *data_base;			  /* the file to update */
    FILE           *lock_file;			  /* the lock file itself */
    char            data_base_name[MAXPATHLEN];	  /* the name of the data file */
    char            lock_file_name[MAXPATHLEN];	  /* the name of the lock file */
    char            env_value[MAXPATHLEN];	  /* the value of the environment variable SIMATH_DATA */
    char            forms_dir[MAXPATHLEN];	  /* the directory storing the modular forms */

    void            write_list();

    bind(L);

    /*
     * We protect this routine against interrupts.
     */

    signal(SIGINT, SIG_DFL);
    signal(SIGINT, SIG_IGN);

    if (getenv("SIMATH_DATA") != NULL)
	sprintf(env_value, "%s\0", getenv("SIMATH_DATA"));
    else
	sprintf(env_value, "%s\0", getenv("HOME"));
    sprintf(forms_dir, "%s", env_value);
    sprintf(data_base_name, "%s/%s", forms_dir, s);

#if (DEBUG >= 1)
    DEBUG_LFF;
    printf("Writing data to directory `%s'\n", forms_dir);
#endif

    /*
     * We tell other processes not to update the data base while this routine is writing to the file.
     */

    sprintf(lock_file_name, "%s-lock", data_base_name);
    if (access(lock_file_name, W_OK) == 0) {

	/*
	 * The lock file exists. There is another process writing. This process will write in the current working
	 * directory.
	 */

	FILE           *help_file;		  /* the help file itself */
	char            help_file_name[MAXPATHLEN];	/* the help file name */
	char            hostname[MAXHOSTNAMELEN]; /* the current host name */

	gethostname(hostname, MAXHOSTNAMELEN);
	sprintf(help_file_name, "%s-%s-%i", s, hostname, getpid());
	help_file = fopen(help_file_name, "w");
	if (help_file != NULL);
	{
	    printf("Another process is currently updating the data file.\n");
	    printf("Writing to `%s' in current working directory\n", help_file_name);

	    write_list(help_file, L);
	    fclose(help_file);
	}
    }
    else {

	/*
	 * No other process is writing. This process will try to update the data base. First We have to create the
	 * lock file
	 */

	lock_file = fopen(lock_file_name, "w");

	if (access(data_base_name, R_OK) == 0) {

	    /*
	     * The data file exists. We read the length of of the series expansion.
	     */

	    data_base = fopen(data_base_name, "r");
	    if (data_base == NULL)
		printf("fputpsisv(): warning: cannot update data base\n");
	    else {
		single          length;		  /* the index of the highest coefficient in the data base */

		length = fgetsi(data_base);
		length = fgetsi(data_base);
		fclose(data_base);

		if (lsecond(L) > length) {
		    data_base = fopen(data_base_name, "w");
		    if (data_base == NULL)
			printf("fputpsisv(): warning: cannot update data base\n");
		    else {
			write_list(data_base, L);
			fclose(data_base);
		    }
		}
	    }

	    fclose(lock_file);
	}
	else {

	    /*
	     * The data file does not exist. We write the data.
	     */

	    data_base = fopen(data_base_name, "w");
	    if (data_base == NULL)
		printf("fputpsisv(): warning: cannot update data base\n");
	    else {
		write_list(data_base, L);
		fclose(data_base);
	    }
	}

	/*
	 * We have to remove the lock file.
	 */

	unlink(lock_file_name);
    }

    /*
     * We enable default behaviour of interrupt signal.
     */

    signal(SIGINT, SIG_DFL);
}
