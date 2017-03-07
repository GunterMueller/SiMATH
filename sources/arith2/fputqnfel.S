/*M
.SH NAME
fputqnfel - file put quadratic number field element

.SH SYNOPSIS
.nf
#include<_arith2.h>

single fputqnfel(D, a, pf)  
int D; 
nfel a; 
FILE *pf;
 
.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
D defines the quadratic number field K (say), where K = Q(D^(1/2)).
.TP 4
.B a
is an element of K ( for representation of number field elements s. fputnfel ).
.TP 4
.B pf
points on the output file *pf.       
.PP
fputqnfel writes a to the file *pf and returns 0 by success and ERROR else.

.SH SEE ALSO
fputnfel

M*/

/*H
	Version 1       25.05.1993      Josef Gebel
   DATE fputqnfel     : 931130
H*/

#include <_arith2.h>

single fputqnfel( D, a, pf ) 
int D;
nfel a;
FILE *pf;
{
    bind( D, a );

    if( a )
    {
        int a1, aN;
        rat A1;
    
        init( a1, aN );
        init( A1 );
    
        aN = lfirst( a );
    
        if( lsecond( a ) )
        {
	    /***  a ist in Q(D^(1/2)) \ Q  ***/
            int a2;
	    single s;
            rat A2;
    
            init( a2 );
            init( A2 );
    
	    a1 = lfourth( a );
	    a2 = lthird ( a );
	    s  = isign( D );
    
	    A1 = itor( a1 );
	    A1 = rquot( A1, itor( aN ) );
	    A2 = itor( a2 );
	    A2 = rquot( A2, itor( aN ) );
	    A2 = rabs( A2 );
    
	    if( a1 )
	    {
	        if( ( fputr( A1, pf ) ) == ERROR )
                {
	            return( ERROR );
                }
	        if( a2 )
		{
		    if( ( fputc( ' ', pf ) ) == ERROR )
                    {
	                return( ERROR );
                    }
		    if( isign( a2 ) > 0 )
		    {
	                if( ( fputc( '+', pf ) ) == ERROR )
                        {
	                    return( ERROR );
                        }
		    }
		}
	    }
	    
	    if( a2 )
	    {
	        if( isign( a2 ) < 0 )
		{
                    if( ( fputc( '-', pf ) ) == ERROR )
                    {
	                return( ERROR );
                    }
	        }
	        if( a1 )
	        {
	            if( ( fputc( ' ', pf ) ) == ERROR )
                    {
	                return( ERROR );
                    }
	        }
		if( !isrone( A2 ) )
		{
		    if( ( ( fputr(  A2, pf ) ) == ERROR )
	               || ( ( fputc( ' ', pf ) ) == ERROR )
	               || ( ( fputc( '*', pf ) ) == ERROR )
	               || ( ( fputc( ' ', pf ) ) == ERROR ) )
                    {
	                return( ERROR );
                    }
                }
		if( s < 0 )
		{
	            if( ( fputc( '(', pf ) ) == ERROR )
                    {
	                return( ERROR );
                    }
		}
	        if( ( ( fputi(   D, pf ) ) == ERROR )
	           || ( ( fputc( '^', pf ) ) == ERROR )
	           || ( ( fputc( '(', pf ) ) == ERROR )
	           || ( ( fputc( '1', pf ) ) == ERROR )
	           || ( ( fputc( '/', pf ) ) == ERROR )
	           || ( ( fputc( '2', pf ) ) == ERROR )
	           || ( ( fputc( ')', pf ) ) == ERROR ) )
                {
	            return( ERROR );
                }
		if( s < 0 )
		{
	            if( ( fputc( ')', pf ) ) == ERROR )
                    {
	                return( ERROR );
                    }
		}
	        return( 0 );
	    }
        }
	else
	{
	    /***  a ist in Q  ***/
	    a1 = lthird( a );
    
	    A1 = itor( a1 );
	    A1 = rquot( A1, itor( aN ) );
	}

	if( ( fputr( A1, pf ) ) == ERROR )
        {
	    return( ERROR );
        }
	return( 0 );
    }

    if( ( fputc( '0', pf ) ) == ERROR )
    {
	return( ERROR );
    }

    return( 0 );
}
