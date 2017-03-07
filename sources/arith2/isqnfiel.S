/*M
.SH NAME
isqnfiel - is quadratic number field element integral element?

.SH SYNOPSIS
.nf
#include<_arith2.h>

single isqnfiel( D, a )  
int D; 
nfel a; 

.SH DESCRIPTION
.TP 4
.B D
is a square free integer number, D != 0 or 1.
D defines the quadratic number field K (say), where K = Q(D^(1/2)).
.TP 4 
.B a
is an element of K, given in minimal representation (s. qnfminrep).
.PP
isqnfiel returns
.TP 4
1,
if a is an element in the ring of integers O_K of the field K, and
.TP 4
0,
else.

.SH SEE ALSO
qnfminrep

M*/
                    
/*H
	Version 1       24.05.1993      Josef Gebel
   DATE isqnfiel      : 931130
H*/

#include <_arith2.h>

single isqnfiel( D, a )
int D;
nfel a;
{
    bind( D, a );

    /***   Sei a = [a1 + a2 * D^(1/2)] / N in K_D = Q(D^(1/2))  ***/
    /***   mit a1, a2, N in Z, gcd( a1, a2, N ) = 1.            ***/
    /***   a liegt im Ganzheitsring O_D von K_D   <==>          ***/
    /***     / a = 0, N = 1 oder                                ***/
    /***     \ N = 2 und (a1 = a2 = 1 mod 2) und D = 1 mod 4.   ***/

    if( !a || ( lfirst( a ) == 1 ) )
    {
	/***    a = 0   oder   N = 1    ***/
        return( 1 );
    }
    if( lsecond( a ) && ( lfirst( a ) == 2 ) && ( mshom( 4, D ) == 1 ) )
    {
        /***   D == 1 mod 4  und  N = 2   ***/
	if( mshom( 2, lthird( a ) ) && mshom( 2, lfourth( a ) ) )
        {
            /***   a1 == a2 == 1 mod 2   ***/
            return( 1 );
        }
    }
    return( 0 );
}
