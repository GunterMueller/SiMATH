/*M
.SH NAME
fgetvecspec - file get vector, special

.SH SYNOPSIS
.nf
#include<_matr1.h>

vec fgetvecspec(pf, fgetfunc, numargs, arg1, ..., arg8)
FILE *pf;
obj (*fgetfunc)();
single numargs;
obj arg1, ..., arg8;

.SH DESCRIPTION
fgetvecspec() returns the vector
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
.B arg1, ..., arg8
are at most 8 optional arguments for fgetfunc.
M*/









/*H
	Version 1	17.03.1990	Th. Weis
   DATE fgetvecspec   : 910915
H*/

#include <_matr1.h>

vec fgetvecspec(pf,fgetfkt,anzahlargs,arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8)
FILE   *pf;
obj    ( *fgetfkt ) ();
single anzahlargs;
obj    arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8;
{
	obj    a;
	single c, f = 0;
	vec    V;

	bind(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8);

/*** Fehlerbehandlung   ***/

	if ( ( c = fgetcs( pf ) ) == EOF )
	{
	   errmsgio( "fgetvecspec", "MA120" );
	   return( ERROR );
	}
	if ( c != '(' )
	{
	   errmsgio( "fgetvecspec", "MA132" );
	   f = 1;
	}
	c = fgetcs( pf );
	if ( c == ')' )
	{
	   errmsgio( "fgetvecspec", "V000" );
	   f = 1;
	}

/*** Einlesen   ***/

	init( a, V );
	V = _0;
	while ( c != ')' )
	{
	   ungetc( c, pf );
	   switch ( anzahlargs )
	   {
	      case 0: a = ( *fgetfkt )( pf );
		      break;
	      case 1: a = ( *fgetfkt )( arg1, pf );
		      break;
	      case 2: a = ( *fgetfkt )( arg1, arg2, pf );
		      break;
	      case 3: a = ( *fgetfkt )( arg1, arg2, arg3, pf );
		      break;
	      case 4: a = ( *fgetfkt )( arg1, arg2, arg3, arg4, pf );
		      break;
	      case 5: a = ( *fgetfkt )( arg1, arg2, arg3, arg4, arg5, pf );
		      break;
	      case 6: a = ( *fgetfkt )( arg1, arg2, arg3, arg4, arg5, arg6, pf );
		      break;
	      case 7: a = ( *fgetfkt )( arg1, arg2, arg3, arg4, arg5, arg6, arg7, pf );
		      break;
	      case 8: a = ( *fgetfkt )( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, pf );
		      break;
	   }
	   if ( a == ERROR )
	   {
	      errmsgio( "fgetvecspec", "V001" );
	      f = 1;
	   }
	   V = lcomp( a, V );
	   if ( ( c = fgetcs( pf ) ) == ',' )  c = fgetcs( pf );
	}
	if ( f ) return( ERROR );
	return( linv( V ) );
}
