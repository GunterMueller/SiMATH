/*M
.SH NAME
fgetma - file get matrix

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix fgetma(pf, fgetfunc, numargs, arg1, arg2, arg3)
FILE *pf;
obj (*fgetfunc)();
single numargs;
obj arg1, arg2, arg3;

.SH DESCRIPTION
fgetma() returns the matrix
read from the input file *pf or ERROR in case an error has occurred.

.PP
.TP 4
.B pf
is a pointer to the input file.
.TP 4
.B fgetfunc
is an input function for a single element of the matrix.
This function is given pf and the additional arguments.
.TP 4
.B numargs
is the number of additional arguments actually used by fgetfunc.
.TP 4
.B arg1, arg2, arg3
are at most 3 optional arguments for fgetfunc.

.SH SEE ALSO
fgetmai, fgetmar, fgetmams
M*/








/*H
	Version 1       24.10.1988      Klaus Petry     Null als Atom
	Version 2	15.02.1990	Th. Weis        Kommentarklammern um
							init-Zeile entfernt
	Version 3       04.07.1991      ueberfl. Zuweisung i=0 beseitigt.  PS
	Version 4	24.07.1991	single arg1,arg2,arg3;
					 -->  obj arg1,arg2,arg3;  Th. W.
   DATE fgetma        : 890501.900315.9107__.910915
H*/

#include <_matr1.h>

matrix fgetma(pf,fgetfkt,anzahlargs,arg1,arg2,arg3)
FILE   *pf;
obj    (*fgetfkt) ();
single anzahlargs;
obj    arg1,arg2,arg3;
{
	matrix M;
	list Z;
	obj a;
	single c;               /* eingelesenes Zeichen */
	single i,j;
	single fehler = 0;      /* Schalter */

	bind (arg1,arg2,arg3);
	init (M,Z,a);

	M = ERROR;
	if ( ( c = fgetcs( pf ) ) == EOF ) {
		errmsgio( "fgetma", "MA120" );
		return( ERROR );
	    }
	if ( c != '(' ) {
		errmsgio("fgetma","MA132");
		fehler = 1;
		}
	c = fgetcs(pf);
	i = 0;                  /* Laenge der ersten Zeile */
	while ( ( c != ')' ) ) {
		if  ( c != '(' )  {
			errmsgio( "fgetma", "MA132" );
			fehler = 1;
			}
		c = fgetcs(pf);
		Z = _0;
		j = 0;
		while ( c != ')' ) {
			ungetc( c, pf );
			switch (anzahlargs) {
				case 0: a = (*fgetfkt)(pf);
					break;
				case 1: a = (*fgetfkt)(arg1, pf);
					break;
				case 2: a = (*fgetfkt)(arg1, arg2, pf);
					break;
				case 3: a = (*fgetfkt)(arg1, arg2, arg3, pf);
					break;
				}
			if (a == ERROR)  {
				errmsgio( "fgetma", "MA122" );
				fehler = 1;
				}
			Z = lcomp(a,Z);
			j++;
			if ( (c=fgetcs(pf)) == ',' )  c = fgetcs(pf);
			}
		Z = linv( Z );
		if (!i) {
			M = list1( Z );
			i = j;
			if ( !j ) {
				/* erste Zeile: Laenge 0 */
				fehler = 1;
				errmsgio("fgetma","MA130");
				i = 1;
				}
			}
		else {
			M = lcomp( Z, M );
			if ( i != j ) {
				fehler = 1;
				errmsgio("fgetma","MA131");
				}
			}
		if ( (c = fgetcs( pf ) ) == ',' )  c = fgetcs(pf);
		}
	if (M == -BASIS) {
		/* Eingabe von () */
		fehler = 1;
		errmsgio( "fgetma", "MA140" );
		}
	if ( fehler ) M = ERROR;
	else M = linv( M );
	return( M );
}
