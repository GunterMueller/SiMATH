/*M
.SH NAME
fputnffel - file put quadratic number field element factor exponent list

.SH SYNOPSIS
.nf
#include<_arith2.h>

single fputqnffel(D, L, pf)  
int D; 
list L; 
FILE *pf;

.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
D defines the quadratic number field K (say), where K = Q(D^(1/2)).
.TP 4
.B L
is a list, containing the factorization of a number field element into prime ideals (s. qnfielpifact).  
.TP 4
.B pf
points on the output file *pf.  
.PP
fputqnffel writes L to the file *pf and returns 0 by success and ERROR else.

.SH SEE ALSO
qnfielpifact

M*/
         
/*H
	Version 1       10.10.1993	Josef Gebel
   DATE fputqnffel    : 931130
H*/

#include <_arith2.h>

fputqnffel( D, L, pf ) 
int  D; 
list L;
FILE *pf; 
{
    single e, s;
    list   P;
    int    a, b, c;

    bind( D, L );
    init( P, a, b, c );

    if( lred( L ) == _0 )
    {
	if( fputl( L, pf ) == ERROR )
	{
	    return( ERROR );
	}
	return( 0 );
    }

    while( L != _0 )
    {
	P = lfirst( L );
	e = lsecond( L );
	
	if( fputqnfid( D, P, pf ) == ERROR )
	{
	    return( ERROR );
	}

	if( ( fputc( '^', pf ) == ERROR )
	 || ( fputsi(  e, pf ) == ERROR ) )
	{
	    return( ERROR );
	}

        L = lred4( L );
	if( L != _0 )
	{ 
	    if( ( fputc( ' ', pf ) == ERROR )
	     || ( fputc( '*', pf ) == ERROR )
	     || ( fputc( ' ', pf ) == ERROR ) )
	    {
	        return( ERROR );
	    }
        }
    }
    return( 0 );
}
