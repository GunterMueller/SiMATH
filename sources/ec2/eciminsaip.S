/*M
.SH NAME
eciminsaip - elliptic curve over the rational numbers, minimal model, search for all integral points 

.SH SYNOPSIS
.nf
#include<_ec2.h>

list eciminsaip(E)  
list E;
 
.SH DESCRIPTION
.TP 4
.B E
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.   
.PP
eciminsaip computes a list, say L, where
.IP
L = ( P1  L1  ...  Pk  Lk ); list P1,L1,...,Pk,Lk;
.PP
with all integral points P1, ..., Pk on the minimal model of
E/Q and their linear combination with respect to the torsion
group and the basis contained in the list E.  

eciminsaip returns 
.IP
 _0,  if there are no integral points on the 
      minimal model of E/Q,
  L,  if there are integral points on the minimal 
      model of E/Q and
 (0), if an error occurs.

.SH NOTES
eciminsaip uses the global double variable _H_BOUND (default
_H_BOUND = 0.0).  If _H_BOUND is positive then the height in
the search for points (in 'ecisnfpbwh') will be limited by
_H_BOUND. If _H_BOUND = 0.0 then the search is not limited.
For most applications _H_BOUND = 11.0 is sufficient.

.SH EXAMPLES
 L1 = ( 0  1   2 ): P1 =  O + 1 * B1 + 2 * B2
 L2 = ( 1  0  -1 ): P2 = T1 - 1 * B2, where
.PP
 ( T0 = O, T1, ..., Tt ) is the tosion subgroup, 
 rank(E/Q) = 2           and 
 ( B1, B2 )              is the basis of the 
                         minimal model of E.
              
.SH SEE ALSO
 ecrinit
 Literature: J. Gebel, A. Pethoe and H. G. Zimmer:
            "Computing Integral Points on Elliptic Curves" 
             Acta arithmetica 68, 171-192 (1994).

M*/
                               
/*H
	Version 1       22.02.1994      Josef Gebel
   DATE eciminsaip    :	941201
H*/

#include <_ec2.h> 

list eciminsaip( E )
list E;
{
    list L;

    init( L );

    /***   The transformation of each integral point on the minimal        ***/
    /***   model (contained in the list E) to the short model (contained)  ***/ 
    /***   is an integral point on this short model: Thus we have to find  ***/ 
    /***   all integral points on the short model, tranform them to the    ***/ 
    /***   minimal model and test if they are integral or not.             ***/ 

    /***   Computation of the integral points on the shaort model          ***/
    L = ecisnfsaip( E );
 
    if( L == _0 )
    {
        /***   No integral points on the short model ==>                   ***/
        /***   no integral points on the minimal model                     ***/
        return( _0 );
    }
 
    if( lfirst( L ) )
    {
        /***   Integral points on the short model could be                 ***/
        /***   computed successfully                                       ***/
        list B, M, N, P;

        init( B, M, N, P );

        B = ecisnfbtmin( E );
        M = _0;

        while( L != _0 )
        {
            /***   Test, if the transformed points are still integral      ***/
            P = lfirst ( L );
            N = lsecond( L );

            P = ecrbtp( P, B );
            if( lthird( P ) == 1 )
            {
                /***   Transformed point is integral                       ***/
                M = lcomp2( N, P, M );
            }

            L = lred2( L );
        }
        return( linv( M ) );
    }
 
    return( L );
}
