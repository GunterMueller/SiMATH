/*M
.SH NAME
qnfinv - quadratic number field element inverse element

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel qnfinv( D, b )  
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
qnfinv returns the multiplicativley inverse element of b, or ERROR if b = 0.

.SH SEE ALSO
fputnfel

M*/
                                                                   
/*H
	Version 1       24.05.1993      Josef Gebel
   DATE qnfinv        : 931130
H*/

#include <_arith2.h>

nfel qnfinv( D, a )
int D;
nfel a;
{
    bind( D, a );

    if( !a ) 
    {
        return( ERROR );
    }
    else
    {
        int Na;

        init( Na );
            
        Na = lfirst( a );
		
        if( lsecond( a ) )
        {   
	    /***  a in Q(D^(1/2))\Q: a = a1/Na + a2/Na * D^(1/2) ***/
	    /***   1     a1 * Na - a2 * Na * D^(1/2)             ***/
	    /***  --- = -----------------------------            ***/
	    /***   a        a1^2 - a2^2 * D                      ***/

            int a1, a2, b2, Nb;
            init( a1, a2, b2, Nb );

	    a1 = lfourth( a );
	    a2 = lthird ( a );

	    Nb = iprod( a2, a2 );
	    Nb = iprod(  D, Nb );
	    b2 = iprod( a1, a1 );
	    Nb = idif ( b2, Nb );

	    b2 = ineg( iprod( a2, Na ) );
	    
	    return( qnfminrep( D, list4( Nb, 1, b2, iprod( a1, Na ) ) ) );
        }
        else
        {   
	    /***  a in Q: a = a1/Na   ***/
	    /***  1/a = Na/a1         ***/

	    return( qnfminrep( D, list3( lthird( a ), 0, Na ) ) );
        }
    }
}
