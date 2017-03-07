/*M
.SH NAME
eciminntheps - elliptic curve with integer coefficients, minimal model, set NTH_EPS

.SH SYNOPSIS
.nf
#include<_ec1.h>

floating eciminntheps(E1, d)  
list E1; single d;

.SH DESCRIPTION
.TP 4
.B E1
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.
.PP
eciminntheps computes the number of iteration steps, 'eciminlhaav' needs to approach the local Neron-Tate height of a point at the archimedean value of Q with an error of the magnitude O( 4^[-d] ).
eciminntheps writes the result to NTH_EPS, and returns the old NTH_EPS.
E1 will be changed.

.SH SEE ALSO
 ecrinit
 eciminntlhaav

 J.H. Silverman: Math. of Comp., 51, 1988, p.339-350.


M*/

/*H
	Version 1       22.02.1993      Josef Gebel
	Version 2	18.10.1993	Warnungen des Apollo-Compilers
					beseitigt.  PS
   DATE eciminntheps  : 930531.931130
H*/

#include <_ec1.h>

floating eciminntheps( E, d ) 
list E;
single d;
{
    single n, Nnth, NTH_EPS_ALT;
    int max, hi, b2m, b4m, b6m, b8m, b2s, b4s, b6s, b8s;
    floating hf;
    list L, Lnth;
    
    bind( E );

    init( L, Lnth );
    init( max, hi, b2m, b4m, b6m, b8m, b2s, b4s, b6s, b8s );
    init( hf );
 
    /*   max = max{ 4, |b2|, 2 * |b4|, 2 * |b6|, |b8| }     */

    L = lfourth( E );
    Lnth = lsixth( L );

    max = 4;
	
    b8m = eciminb8( E );
    hi  = iabs( hi );
    if( icomp( hi, max ) > 0 )
    {
	max = hi;
    }
    	
    b6m = eciminb6( E );
    hi  = iabs( hi );
    if( icomp( hi, max ) > 0 )
    {
	max = hi;
    }
	
    b4m = eciminb4( E );
    hi  = iabs( hi );
    if( icomp( hi, max ) > 0 )
    {
	max = hi;
    }
    	
    b2m = eciminb2( E );
    hi  = iabs( hi );
    if( icomp( hi, max ) > 0 )
    {
	max = hi;
    }

    if( Lnth == _0 )
    {
	/*   Lnth ist noch nicht berechnet   */
    
        NTH_EPS_ALT = NTH_EPS;
	b2s = idif ( b2m,  12 );

	b4s = idif ( b4m, b2m );
	b4s = isum ( b4s,   6 );
	
	hi  = idif ( b6m, b4m );
	b6s = idif (  hi, b4m );
	b6s = isum ( b6s, b2m );
	b6s = idif ( b6s,   4 );

	b8s = isprod(  hi,   3 );
	b8s = idif ( b8m, b8s );
	b8s = idif ( b8s, b2m );
	b8s = isum ( b8s,   3 );

    }
    else
    {
        NTH_EPS_ALT = lsixth( Lnth );
	b2s = lsecond( Lnth );
	b4s = lthird ( Lnth );
	b6s = lfourth( Lnth );
	b8s = lfifth ( Lnth );
    }
    
    /*   Berechnung von Nnth              */
	
    n  = 3 + 10 * d;
    hf = fllog ( itofl( max ) );
    hf = flprod( hf, itofl( 8 ) );
    hf = flsum ( hf, itofl( n ) );
    hf = flquot( hf, itofl( 6 ) );

    Nnth = flfloor( hf ) + 1;

    Lnth = list6( Nnth, b2s, b4s, b6s, b8s, d );

    leset( L, 6, Lnth );
    leset( E, 4, L );

    return( NTH_EPS_ALT );
}   
