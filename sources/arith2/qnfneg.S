/*M
.SH NAME
qnfneg - quadratic number field element negation

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel qnfneg(D, a)  
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
qnfneg returns an element of K, say b, where
.IP
 b = -a (the additive inverse element of a).

.SH SEE ALSO
fputnfel

M*/
      
/*H
	Version 1       22.05.1993      Josef Gebel
	Version 2	08.11.1994	Dokumentation korrigiert. MP
   DATE qnfneg        : 931130.941201
H*/

#include <_arith2.h>

nfel qnfneg( D, a )
int D;
nfel a;
{
    /*** 1.Fall: a = 0 ***/
    if( !a )
    {
        return( 0 );
    }

    /*** 2.Fall: a != 0 ***/
    
    else
    {
        int a1; 

        bind( D, a );
        init( a1 );
    
        /*** Darstellung fuer a = [a1 + a2 D^(1/2)] / aN  ***/
        /***    ( aN  1  a2  a1 ) falls a2 != 0           ***/
        /***    ( aN  0  a1 )     falls a2 == 0           ***/

        if( lsecond( a ) )
        {
            int a2; 
            init( a2 );

            a1 = ineg( lfourth( a ) );
            a2 = ineg( lthird( a ) );

	    return( list4( lfirst( a ), 1, a2, a1 ) );
        }
        else
        {
            a1 = ineg( lthird( a ) );
	    return( list3( lfirst( a ), 0, a1 ) );
        }
    }
}
