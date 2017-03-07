/*M
.SH NAME
qnfminrep - quadratic number field element minimal representation

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel qnfminrep( D, a )  
int D; 
nfel a;
 
.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
D defines the quadratic number field K (say), where K = Q(D^(1/2)).
.TP 4
.B a
is an element of K (for representation of number field elements s. fputnfel). 
.PP
a has one of the following representations:
.PP
            0, for a = 0,
    (aN 0 a1), for a = a1/aN in Q without {0}, or
 (aN 1 a2 a1), for a = a1/aN + (a2/aN) * D^(1/2) 
               in K without Q,
 int aN, a1, a2;
.PP
qnfminrep returns the minimal representation of a, i.e. the accordant representation from above with 
.PP
 aN > 0  and
 g.c.d(aN, a1) = 1, g.c.d(aN, a2, a1) = 1 respectively. 

.SH SEE ALSO
fputnfel

M*/
                          
/*H
	Version 1       22.05.1993      Josef Gebel
   DATE qnfminrep     : 931130
H*/

#include <_arith2.h>

nfel qnfminrep( D, a )
int D;
nfel a;
{
    bind( D, a );

    /*** 1.Fall: a = 0 ***/
    if( !a )
    {
        return( 0 );
    }

    /*** 2.Fall: a != 0 ***/
    else
    { 
	int aN, a1, g;
        init( aN, a1, g );
   
        aN = lfirst( a ); 
        if( lsecond( a ) )
        {
	    /*** a = [a1 + a2 D^(1/2)] / aN  ***/
	    int a2;
	    init( a2 );

            a1 = lfourth( a );
            a2 = lthird( a );
	    
	    if( a2 )
	    {
		/***   Ab hier: a in Q(D^(1/2))\Q   ***/
	        if( isign( aN ) < 0 )
	        {
		    a1 = ineg( a1 );
		    a2 = ineg( a2 );
                    aN = ineg( aN );
	        }

	        g = igcd( a1, aN );
    
	        if( g != 1 )
		{
	            g = igcd(  g, a2 );

	            if( g != 1 )
		    {
	                a1 = iquot( a1, g );
	                a2 = iquot( a2, g );
	                aN = iquot( aN, g );
		    }
		}

	        return( list4( aN, 1, a2, a1 ) );
            }
        }
	else
	{
            a1 = lthird( a );
	}
	
	/***   Ab hier: a in Q    ***/

	if( !a1 )
	{
            /*** a = 0 ***/
            return( 0 );
	}

	if( isign( aN ) < 0 )
	{
            a1 = ineg( a1 );
            aN = ineg( aN );
	}
	
	g = igcd( a1, aN );

	if( g != 1 )
	{
	    a1 = iquot( a1, g );
	    aN = iquot( aN, g );
        }

	return( list3( aN, 0, a1 ) );
    }
}
