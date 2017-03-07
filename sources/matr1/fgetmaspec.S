/*M
.SH NAME
fgetmaspec - file get matrix, special

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix fgetmaspec(pf, fgetfunc, numargs, arg1, ..., arg8)
FILE *pf;
obj (*fgetfunc)();
single numargs;
obj arg1, ..., arg8;

.SH DESCRIPTION
fgetmaspec() returns the matrix
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
.B arg1, ..., arg8
are at most 8 optional arguments for fgetfunc.
M*/





/*H
	Version 1	17.03.1990	Th. Weis
   DATE fgetmaspec    : 910915
H*/

#include <_matr1.h>

matrix fgetmaspec(pf,fgetfkt,anzahlargs,arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8)
FILE   *pf;
obj    ( *fgetfkt )();
single anzahlargs;
obj    arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8;
{
	matrix M;
	list   Z;
	obj    a;
	single c;               /* eingelesenes Zeichen */
	single i = 0;           /* Laenge der ersten Zeile */
	single j;
	single fehler = 0;      /* Schalter */

	bind( arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8 );
	init( M, Z, a );

	M = ERROR;
	if ( ( c = fgetcs( pf ) ) == EOF )
	{
	   errmsgio( "fgetmaspec", "MA120" );
	   return( ERROR );
	}
	if ( c != '(' )
	{
	   errmsgio( "fgetmaspec", "MA132" );
	   fehler = 1;
	}
	c = fgetcs( pf );
	while ( ( c != ')' ) )
	{
	   if  ( c != '(' )
	   {
	      errmsgio( "fgetmaspec", "MA132" );
	      fehler = 1;
	   }
	   c = fgetcs( pf );
	   Z = _0;
	   j = 0;
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
		 errmsgio( "fgetmaspec", "MA122" );
		 fehler = 1;
	      }
	      Z = lcomp( a, Z );
	      j++;
	      if ( ( c = fgetcs( pf ) ) == ',' )  c = fgetcs( pf );
	   }
	   Z = linv( Z );
	   if ( !i )
	   {
	      M = list1( Z );
	      i = j;
	      if ( !j )
	      {

/*** erste Zeile: Laenge 0 ***/

		 fehler = 1;
		 errmsgio( "fgetmaspec", "MA130" );
		 i = 1;
	      }
	   }
	   else
	   {
	      M = lcomp( Z, M );
	      if ( i != j )
	      {
		 fehler = 1;
		 errmsgio( "fgetmaspec", "MA131" );
	      }
	    }
	    if ( ( c = fgetcs( pf ) ) == ',' )  c = fgetcs( pf );
	}
	if ( M == -BASIS )
	{

/*** Eingabe von () ***/

	   fehler = 1;
	   errmsgio( "fgetmaspec", "MA140" );
	}
	if ( fehler ) M = ERROR;
	else M = linv( M );
	return( M );
}
