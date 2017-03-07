/*M
.SH NAME
fgetvec - file get vector

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec fgetvec(pf, fgetfunc, numargs, arg1, arg2, arg3)
FILE *pf;
obj (*fgetfunc)();
single numargs;
obj arg1, arg2, arg3;

.SH DESCRIPTION
fgetvec() returns the vector
read from the input file *pf or ERROR in case an error has occurred.

.PP
.TP 4
.B pf
is a pointer to the input file.
.TP 4
.B fgetfunc
is an input function for a single element of the vector.
This function is given pf and the additional arguments.
.TP 4
.B numargs
is the number of additional arguments actually used by fgetfunc.
.TP 4
.B arg1, arg2, arg3
are at most 3 optional arguments for fgetfunc.


.SH SEE ALSO
fgetveci, fgetvecr, fgetvecms
M*/









/*H
	Version 1       27.02.1989      U.Schneiders
	Version 2       11.12.1989      U.Schneiders ( Vektor ganz einlesen )
	Version 3	24.07.1991	single arg1,arg2,arg3;
					 --> obj arg1,arg2,arg3;
   DATE fgetvec       : 890601.900101.910915
H*/

#include <_matr1.h>

vec fgetvec(pf,fgetfkt,anzahlargs,arg1,arg2,arg3)
FILE   *pf;
obj    ( *fgetfkt ) ();
single anzahlargs;
obj    arg1,arg2,arg3;
{
	single c, f = 0;
	vec V;
	obj a;

	bind(arg1,arg2,arg3);

	/*** Fehlerbehandlung   ***/

	if ( ( c = fgetcs( pf ) ) == EOF )
	{       errmsgio( "fgetvec", "MA120" );
		return( ERROR );
	}
	if ( c != '(' )
	{       errmsgio( "fgetvec", "MA132" );
		f = 1;
	}
	c = fgetcs( pf );
	if( c == ')' )
	{       errmsgio( "fgetvec", "V000" );
		f = 1;
	}

	/*** Einlesen   ***/

	init( a, V );
	V = _0;
	while ( c != ')' )
	{
		ungetc( c, pf );
		switch( anzahlargs )
		{       case 0: a = (*fgetfkt)( pf );
				break;
			case 1: a = (*fgetfkt)( arg1, pf );
				break;
			case 2: a = (*fgetfkt)( arg1, arg2, pf );
				break;
			case 3: a = (*fgetfkt)( arg1, arg2, arg3, pf );
				break;
		}
		if( a == ERROR )
		{       errmsgio( "fgetvec", "V001" );
			f = 1;
		}
		V = lcomp( a, V );
		if ( ( c = fgetcs( pf ) ) == ',' )  c = fgetcs( pf );
	}
	if( f ) return( ERROR );
	return( linv( V ) );
}
