/*M
.SH NAME
fputmas - file put matrix of singles

.SH SYNOPSIS
.nf
#include<_matr1.h>

single fputmas(M, pf)
matrix M;
FILE *pf;

.SH DESCRIPTION
fputmas() writes the matrix M to the output file *pf
and returns 0 or ERROR in case an error has occurred.

.PP
.TP 4
.B M
is a matrix of singles.
.TP 4
.B pf
is a pointer to the output file.
M*/
/*H
	Version 1       04.05.1988      Klaus Petry
   DATE fputmas       : 890501
H*/


# include <_matr1.h>

single fputmas( M, pf )
matrix M;
FILE *pf;

{
	list Z;
	single i, a, b, anzblanks, ret=0;

	bind( M );
	init( Z );

	if (manrcol (M)) ret = fputmai (M, pf);
	else {
		if ( fputc('(',pf) == EOF ) {
			errmsgio( "fputmas", "MA120" );
			ret = ERROR ;
			}
		else {
			while ( M != _0 ) {
				fprintf(pf,"\n( ");
				Z = lfirst( M );
				M = lred( M );
				while ( Z != _0 ) {
					a = b = lfirst( Z );
					Z = lred( Z );
/* formatiere */
					anzblanks = 10;
					while( b>=10 ) {
						anzblanks--;
						b /= 10;
						}
					for(; anzblanks--;) fputc( ' ', pf );
					fputsi( a, pf );
					}
				fprintf(pf," )");
				}
			fprintf(pf,"\n");
			if ( fputc(')',pf) == EOF ) {
				errmsgio( "fputmas", "MA120" );
				ret = ERROR;
				}
			}
		}
	return( ret );
}
