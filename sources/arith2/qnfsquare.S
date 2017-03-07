/*M
.SH NAME
qnfsquare - quadratic number field element square

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel qnfsquare( D, b )  
int D; 
nfel b;
 
.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
D defines the quadratic number field K (say), where K = Q(D^(1/2)).
.TP 4
.B b
is an element of K (for representation of number field elements s. fputnfel).
.PP
qnfsquare returns a number field element, say c, where
.IP
c = a * a.
 
.SH SEE ALSO
fputnfel

M*/
            
/*H
	Version 1       24.05.1993      Josef Gebel
   DATE qnfsquare     : 931130
H*/

#include <_arith2.h>

nfel qnfsquare( D, a )
int D;
nfel a;
{
    bind( D, a );

    if( !a ) 
    {
        return( 0 );
    }
    else
    {
        int a1, N;

        init( a1, N );
            
        N = lfirst( a );
	N = iprod( N, N );

        if( lsecond( a ) )
        {   
	    int a2, b1, b2;
	    init( a2, b1, b2 );

	    a1 = lfourth( a );
	    a2 = lthird ( a );
	    
	    b1 = iprod(  D, iprod( a2, a2 ) );
	    b1 = isum ( b1, iprod( a1, a1 ) );
	    b2 = iprod( a1, a2 );
	    
	    return( qnfminrep( D, list4( N, 1, isum ( b2, b2 ), b1 ) ) );
        }
        else
        {   
	    a1 = lthird( a );
	    
	    return( qnfminrep( D, list3( N, 0, iprod( a1, a1 ) ) ) );
        }
    }
}
