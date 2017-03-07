/*M
.SH NAME
fputmaspec - file put matrix, special

.SH SYNOPSIS
.nf
#include<_matr1.h>

single fputmaspec(M, pf, fputfunc, numargs, arg1, ..., arg8)
matrix M;
FILE *pf;
single (*fputfunc)();
single numargs;
obj arg1, ..., arg8;

.SH DESCRIPTION
fputmaspec() writes the matrix M to the output file *pf
and returns 0 or ERROR in case an error has occurred.

.PP
.TP 4
.B M
is a matrix.
.TP 4
.B pf
is a pointer to the output file.
.TP 4
.B fputfunc
is an output function for a single element of the matrix.
This function is given pf and the additional arguments.
.TP 4
.B numargs
is the number of additional arguments actually used by fputfunc.
.TP 4
.B arg1, ..., arg3
are at most 8 optional arguments for fputfunc.

M*/
/*H
	Version 1       17.03.1990      Th. Weis
   DATE fputmaspec    : 910915
H*/

#include <_matr1.h>

single fputmaspec(M,pf,fputfkt,anzahlargs,arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8)
matrix M;
FILE   *pf;
single ( *fputfkt )();
single anzahlargs;
obj    arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8;
{
	list   Z;
	obj    a;
	single ret;

	bind( M );
	bind( arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8 );

	if ( fputc( '(', pf ) == EOF )
	{
	   errmsgio( "fputmaspec", "MA125" );
	   return( ERROR );
	}
	fprintf( pf, "\n" );
	while( M != _0 )
	{
	   Z = lfirst( M );
	   fputc( '(', pf );
	   while ( Z != _0 )
	   {
	      fputc( ' ', pf );
	      a = lfirst( Z );
	      switch ( anzahlargs )
	      {
		 case 0: ret = ( *fputfkt )( a, pf );
			 break;
		 case 1: ret = ( *fputfkt )( arg1, a, pf );
			 break;
		 case 2: ret = ( *fputfkt )( arg1, a, arg2, pf );
			 break;
		 case 3: /*** pms ***/
			 ret = ( *fputfkt )( arg1, arg2, a, arg3, pf );
			 break;
		 case 4: ret = ( *fputfkt )( arg1, arg2, a, arg3, arg4, pf );
			 break;
		 case 5: /*** pgfs ***/
			 ret = ( *fputfkt )( arg1, arg2, arg3, a, arg4, arg5, pf );
          		 break;
          	 case 6: ret = ( *fputfkt )( arg1, arg2, arg3, a, arg4, arg5, arg6, pf );
			 break;
          	 case 7: ret = ( *fputfkt )( arg1, arg2, arg3, a, arg4, arg5, arg6, arg7, pf );
			 break;
          	 case 8: ret = ( *fputfkt )( arg1, arg2, arg3, a, arg4, arg5, arg6, arg7, arg8, pf );
			 break;
	      }
	      if ( ret == ERROR )
	      {
		 errmsgio( "fputmaspec", "MA125" );
		 return( ERROR );
	      }
	      fputc( ' ', pf );
	      Z = lred( Z );
	   }
	   fprintf( pf, ")\n" );
	   M = lred( M );
	}
	if ( fputc( ')', pf ) == EOF )
	{
	   errmsgio( "fputmaspec", "MA125" );
	   return( ERROR );
	}
	return( 0 );
}
