/*M
.SH NAME
qnfexp - quadratic number field element exponentiation

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel qnfexp( D, b, e )  
int D;
nfel b; 
single e; 
    
.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
D defines the quadratic number field K (say), where K = Q(D^(1/2)).  
.TP 4
.B b
is an element of K ( for representation of number field elements s. fputnfel ).
.TP 4
.B e
is an integer number.
.PP
qnfexp returns b raised to the power e, where
.PP
 0^0 = 1, 
 0^e = 0,         for e > 0, and
 b^e = (1/b)^|e|, for b != 0 and e < 0,
.PP
For b = 0 and e < 0, qnfexp returns ERROR.

.SH SEE ALSO
fputnfel

M*/
                          
/*H
	Version 1       24.05.1993      Josef Gebel
   DATE qnfexp        : 931130
H*/

#include <_arith2.h>

nfel qnfexp( D, a, e )
int D;
nfel a;
single e;
{
    bind( D, a );

    if( !a ) 
    {
	if( e )
	{
	    if( e > 0 )
	    {
                return( 0 );
	    }
	    return( ERROR );
	}
        return( list3( 1, 0, 1 ) );
    }
    if( !e || isqnfone( D, a ) ) 
    {
	/***  a != 0 und e = 0   oder   a = 1  ***/
	return( list3( 1, 0, 1 ) );
    }
    else
    {
	single f;
	nfel b;

	init( b );

	if( e < 0 )
	{
	    f = -e;
	}
	else
	{
	    f = e;
	}
	
	if( isqnfrat( D, a ) )
	{
	    /***  a ist in Q  ***/
            int i, j;

	    init( i, j );

            i = lthird( a );
            j = iexp( i, e );

	    if( isqnfint( D, a ) )
	    {
	        /***  a ist in Z  ***/
		b = list3( 1, 0, j );
	    }
	    else
	    {
	        /***  a ist in Q\Z  ***/
		int k;
		
		init( k );

		b = list3( 1, 0, j );
		i = lfirst( a );
		k = iexp( i, e );
		b = list3( k, 0, j );
	    }
	}
	else
	{
	    /***  a ist in Q(D^(1/2))\Q  ***/
	    nfel c;
	    init( c );
	  
	    b = list3( 1, 0, 1 );   /*   b = 1   */
	    c = a;

	    while( f )
	    {
	        if( f & 01 )
	        {
		    b = qnfprod( D, b, c );
	        }
	        f >>= 1;
                c = qnfsquare( D, c );
	    }
        }
	if( e < 0 )
	{
	    /***  b = a^(-e) --> (1/a)^(-e) = a^e  ***/
	    b = qnfinv( D, b );
	}
	return( b );
    }
}
