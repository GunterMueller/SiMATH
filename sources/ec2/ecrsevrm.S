/*M
.SH NAME
ecrsevrm - curve over the rational numbers, smallest eigenvalue of the regulator-matrix

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecrsevrm(E)
list (E);

.SH DESCRIPTION
ecrsevrm() calculates the smallest eigenvalue lambda1 of the regulator matrix of E.
If lambda1 is already contained in the list E this value will be used.
If lambda1 is not yet contained in the list E the characteristic polynomial Chi of
the regulator matrix A of E/Q will be computed and will be stored into E.
ecrsevrm() returns the list (0),  if rank(E/Q)=0 and the list
(lambda1 Chi), if rank(E/Q)>0 and Chi and lambda1 could be
computed successfully. If an error occurred during the computation
0 will be returned.

.PP
.TP 4
.B E
is a list containing the data of an elliptic curve E/Q over the rational numbers.

.SH SEE ALSO
ecrinit,  ecrregmat
M*/
/*H
	Version 1	21.02.1994	Josef Gebel
	Version 2	10.06.1995	Computation of roots of characteristic 
                                        polynomial with UDPRF. JG
	Version 3	07.10.1996	Error fixed. JG.
	Version 4	07.12.1996	Case r = 1 improved. JG.
   DATE ecrsevrm      : 951201.970101
H*/

#include <_ec2.h>

list ecrsevrm( E )
list E;
{
    list     L, M;
    pol      chi;
    floating lambda;

    init( L, M );
    init( lambda );
    init( chi );

    bind( E );

    if( ( llength( lfourth( lfourth( E ) ) ) < 6 )
    ||  !lsixth( lfourth( lfourth( E ) ) ) )
    {
        if( ( chi = ecrcharpol( E ) ) )
        {
            single   n;
            list N;
 
            init( N );
            /***   rank( E/Q ) > 0   ***/
 
            if( n = lfirst( chi ) )
            {
                if( n == 1 )
                {
                    lambda = lthird( chi );
		    lambda = flneg(lambda);
                }
                else
                {
    
                    /***   computation of l_1 by Newton's algorithm    ***/
                    n = udprf( 0, chi, 1, &L );
    
                    switch( n )
                    {
                        case  0: printf(" ERROR in 'ecrsecrm'");
                                 printf(" (characteristic\n");
                                 printf(" polynomial = ");
                                 if( chi )
                                 {
                                     printf("1\n");
                                 }
                                 else
                                 {
                                     printf("0\n");
                                 }
                                 return( 0 );
                        case  1: printf(" Degree of the");
                                 printf(" characteristic polynomial = ");
                                 printf("%d > 50 = MAX_DEG\n", lfirst( chi ) );
                                 return( 0 );
                        case  2: printf(" Maximal number of iterations");
                                 printf(" is ecceeded\n Increase");
                                 printf(" global variable ITERMAX\n" );
                                 return( 0 );
                        case  3: break;
                        default: printf(" ERROR in 'udprf' ");
                                 printf(" (called from 'ecrsecrm'\n");
                                 return( 0 );
                    }
        
                    M = lfirst( L );
        
                    if( M == _0 )
                    {
                        return( 0 );
                    }
 
                    lambda = lfirst( M );
                }
                L = lfourth( E );
                M = lfourth( L );
                N = lcinv( M );
                N = lcomp2( lambda, chi, N ); 
                N = linv( N );
    
                leset( L, 4, N );
                leset( E, 4, L );
                    
                return( list2( lambda, chi ) );
            }
            return( 0 );
        }
        return( list1( 0 ) );
    }

    L = lfourth( E );
    M = lfourth( L );
    chi = lsixth( M );
    lambda = lsixth( lred( M ) );
    return( list2( lambda, chi ) );
}
