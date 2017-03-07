/*M
.SH NAME
fputqnfid - file put quadratic number field ideal
.SH SYNOPSIS

.nf
#include<_arith2.h>

single fputqnfid(D, A, pf)  
int D; 
list A; 
FILE *pf;

.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
D defines the quadratic number field K (say), where K = Q(D^(1/2)).
.TP 4
.B A
is an ideal in the ring of integers, say O_K, of K (for the representation of ideals s. qnfidprod).  
.TP 4
.B pf
points on the output file *pf.
.PP
fputqnfid writes A to the file *pf and returns 0 by success and ERROR else.
.SH NOTES
An ideal A = (a b c d) will be outputed in the following way:
.PP
(0) for A being the zero ideal,
.PP
[b/s, (c+D^(1/2))/s],     for a == 1,
.PP
{(a)[b/s, (c+D^(1/2))/s]} else. 
.SH SEE ALSO
qnfidprod

M*/
                                    
/*H
	Version 1       10.10.1993	Josef Gebel
   DATE fputqnfid   : 931130
H*/

#include <_arith2.h>

fputqnfid( D, A, pf ) 
int  D; 
list A;
FILE *pf; 
{
    int a;

    bind( D, A );
    init( a );

    if( !( a = lfirst( A ) ) )
    {
	/***   A stellt das Nullideal dar   ***/
	if( ( fputc( '(', pf ) == ERROR )
	 || ( fputc( '0', pf ) == ERROR )
	 || ( fputc( ')', pf ) == ERROR ) )
	{
	    return( ERROR );
	}
    }
    else
    {
        single s;
        int    b, c;
    
        init( b, c );
        
        b = lsecond( A );
        c = lthird ( A );
        s = lfourth( A );
        b = isquot( b, s );
    
        if( a != 1 )
                    {
	    if( ( fputc( '{', pf ) == ERROR )
	     || ( fputc( '(', pf ) == ERROR )
	     || ( fputi(   a, pf ) == ERROR )
	     || ( fputc( ')', pf ) == ERROR ) )
	    {
	        return( ERROR );
	    }
        }
        if( ( fputc( '[', pf ) == ERROR )
         || ( fputi(   b, pf ) == ERROR )
         || ( fputc( ',', pf ) == ERROR ) 
         || ( ( s == 2 ) && c && ( fputc( '(', pf ) == ERROR ) )
         || ( c && ( fputi(   c, pf ) == ERROR ) )
         || ( c && ( fputc( '+', pf ) == ERROR ) )
         || ( ( isign( D ) < 0 ) && ( fputc( '(', pf ) == ERROR ) )
         || ( fputi(   D, pf ) == ERROR )
         || ( ( isign( D ) < 0 ) && ( fputc( ')', pf ) == ERROR ) )
         || ( fputc( '^', pf ) == ERROR )
         || ( fputc( '(', pf ) == ERROR )
         || ( fputc( '1', pf ) == ERROR )
         || ( fputc( '/', pf ) == ERROR )
         || ( fputc( '2', pf ) == ERROR )
         || ( fputc( ')', pf ) == ERROR )
         || ( ( s == 2 ) && c && ( fputc( ')', pf ) == ERROR ) )
         || ( ( s == 2 ) && ( fputc( '/', pf ) == ERROR ) )
         || ( ( s == 2 ) && ( fputc( '2', pf ) == ERROR ) )
         || ( fputc( ']', pf ) == ERROR ) )
        {
	    return( ERROR );
        }
    	
        if( ( a != 1 ) && ( fputc( '}', pf ) == ERROR ) )
        {
	    return( ERROR );
        }
    }
    return( 0 );
}
