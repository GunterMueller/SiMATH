/*M
.SH NAME
fputmaflfx - file put matrix of floating point numbers by fix point

.SH SYNOPSIS
.nf
#include<_matr1.h>

single fputmaflfx(M, v, n, pf)
matrix M;
single v, n;
FILE *pf;

.SH DESCRIPTION
fputmaflfx() writes the matrix M to the output file *pf
and returns 0 or ERROR in case an error has occurred.

.PP
.TP 4
.B M
is a matrix of floating point numbers.
.TP 4
.B v
is the number of digits to write.
.TP 4
.B n
is the number of decimal places to write.
.TP 4
.B pf
is a pointer to the output file.
M*/
/*H
	Version 1	12.11.1992 	Josef Gebel
   DATE fputmaflfx    : 921130
H*/

#include <_matr1.h>

single fputmaflfx( M, v, n, pf )
matrix M;
single v, n; 
FILE   *pf;
{
    list Z;
    floating a;
    single ret;
    
    bind( M );
    
    if( fputs( "( ",pf ) == EOF ) 
    {
        errmsgio( "fputmaflfx", "MA125" );
        return( ERROR );
    }
    fprintf( pf,"\n" );
    while( M != _0 ) 
    {
        Z = lfirst( M );
        fputs( "( ",pf );
        while( Z != _0 )  
	{
            fputc( ' ', pf );
            a = lfirst( Z );
            ret = fputflfx( a, v, n, pf );
            if( ret == ERROR ) 
	    {
                errmsgio( "fputmaflfx", "MA125" );
                return( ERROR );
            }
            fputc( ' ', pf );
            Z = lred( Z );
        }
        fprintf( pf," )\n" );
        M = lred( M );
    }
    if( fputs( " )",pf ) == EOF ) 
    {
        errmsgio( "fputmaflfx", "MA125" );
        return( ERROR );
    }
    return( 0 );
}
