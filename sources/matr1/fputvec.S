/*M
.SH NAME
fputvec - file put vector

.SH SYNOPSIS
.nf
#include<_matr1.h>

single fputvec(V, pf, fputfunc, numargs, arg1, arg2, arg3)
vec V;
FILE *pf;
single (*fputfunc)();
single numargs;
obj arg1, arg2, arg3;

.SH DESCRIPTION
fputvec() writes the vector V to the output file *pf
and returns 0 or ERROR in case an error has occurred.

.PP
.TP 4
.B V
is a vector.
.TP 4
.B pf
is a pointer to the output file.
.TP 4
.B fputfunc
is an output function for a single element of the vector.
This function is given pf and the additional arguments.
.TP 4
.B numargs
is the number of additional arguments actually used by fputfunc.
.TP 4
.B arg1, ..., arg3
are at most 8 optional arguments for fputfunc.

M*/



/*H
	Version 1       01.03.1989      U.Schneiders
	Version 2	24.07.1991	single arg1,arg2,arg3;
					 -->  obj arg1,arg2,arg3;  Th. W.
   DATE fputvec       : 890601.910915
H*/

# include <_matr1.h>

single fputvec(V,pf,fputfkt,anzahlargs,arg1,arg2,arg3)
vec    V;
FILE   *pf;
single (*fputfkt)();
single anzahlargs;
obj    arg1, arg2, arg3;
{
	obj a;
	single ret;

	bind( V );
	bind( arg1,arg2,arg3 );

	if ( fputc( '(', pf ) == EOF )
	{       errmsgio( "fputvec", "MA125" );
		return( ERROR);
	}

	init( a );
	while( V != _0 )
	{       fputc( ' ', pf );
		a = lfirst( V );
		switch (anzahlargs)
		{       case 0: ret = (*fputfkt)(a, pf);
				break;
			case 1: ret = (*fputfkt)(arg1, a, pf);
				break;
			case 2: ret = (*fputfkt)(arg1, a, arg2, pf);
				break;
			case 3: /*** pms ***/
				ret = (*fputfkt)(arg1, arg2, a, arg3, pf);
				break;
		}
		if( ret == ERROR )
		{       errmsgio( "fputvec", "MA125" );
			return( ERROR);
		}
		V = lred( V );
	}
	a = fprintf( pf, " ) " );
	if( a < 0 )
	{       errmsgio( "fputvec", "MA125" );
		return( ERROR );
	}
	return( 0 );
}
