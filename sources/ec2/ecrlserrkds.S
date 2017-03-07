/*M
.SH NAME
ecrlserrkds - curve over the rational numbers, L-series, 'rank'-th derivative, special version"   

.SH SYNOPSIS
.nf
#include<_ec2.h>

single *ecrlserrkds(E, A, l)
list E;
single *A;
floating *l;

.SH DESCRIPTION
Let r be the rank of E/Q.
ecrlserrkds() approximates the value of the r-th derivative of the 
L-series L(E, s) at s = 1. 
If the value is not yet stored in E it will be computed and stored in E.
On success, the result is assigned to *l and l is returned,
otherwise NULL is returned.

.PP
.TP 4
.B E
is a list containing the data of an elliptic curve E/Q over the rational numbers.

.TP 4
.B A
is a pointer tn an array of singles.
A will contain the coefficients a_i of the L-series L(E, s) of E/Q
and is of the form A[0]=length of A;  A[i]=a_i for i = 1, ..., A[0].


.SH REFERENCES
J. Gebel and H.G. Zimmer, "Computing the Mordell-Weil group of an elliptic curve over Q", CRM Proc. & Lect. Notes, Vol. 4 (1994) 61-83.


.SH SEE ALSO
ecrinit
M*/
/*H
	Version 1	20.10.1995	Josef Gebel
   DATE ecrlserrkds   : 
H*/

#include <_ec2.h>

#define LC_BOUND 1000000

single *ecrlserrkds( E, A, l )
list     E;
single   *A;
floating *l;
{
        bind( E ); 
    if( ( lfourth( lfourth( E ) ) == _0 )
    ||  ( lthird( lfourth( lfourth( E ) ) ) == 0 ) )
    {
        single r, *ecrranks();
        /**bind( E );  **/
    
        if( ( A = ( single * ) ecrranks( E, A, &r ) ) == NULL )
        {
            return( NULL );
        }

        if( !( *l = lthird( lfourth( lfourth( E ) ) ) ) )
        {
            double dh;
            list   L1, L2;
           
            init( L1, L2 );
            *l = 0;
	    dh = 0.0;

            if( r )
            {
                int N;

                init( N );

	        N = ecrcond( E );
        
	        if( icomp( N, LC_BOUND ) > 0 )
	        {
                     A = ecrlserhdlc( E, A, r, &dh );
	        }
	        else
	        {
                    if( r > 1 )
                    {
                        A = ecrlserhdsc( E, A, r, &dh );
                    }
                    else
                    {
                        A = ecrlserfds( E, A, &dh );
                    }
	        }
            }
            else
            {
                 A = ecrlsers( E, A, &dh );
            }
     
            if( A == NULL )
            {
                return( NULL );
            }
        
            *l = Cfltofl( dh );
            
            L1 = lfourth( E );     
            L2 = lfourth( L1 );     
            leset( L2, 3,  *l );
            leset( L1, 4, L2 );
            leset( E , 4, L1 );
        }
    }
    return( A );
}
