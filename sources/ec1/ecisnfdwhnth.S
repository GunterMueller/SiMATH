/*M
.SH NAME
ecisnfdwhnth - elliptic curve with integer coefficients, short normal form, difference between Weil height and Neron-Tate height

.SH SYNOPSIS
.nf
#include<_ec1.h>

floating ecisnfdwhnth(E1)  
list E1;

.SH DESCRIPTION
ecisnfdwhnth computes an upper bound, say d, of the difference between the Weil
height d(P) and the Neron-Tate hight h(P)  on the elliptic curve E, i.e.
.P
| h(P) - d(P) | <  d ,
.P
holds for any point P on the model in short normal form of E.
If E1 does not contain the bound d , d will be added to E1.
.TP 4
.B E1
is a list containing the data of the elliptic curve E, as descripted in the
documentation of 'ecrinit'.

.SH SEE ALSO
ecrinit
.P
J.H. Silvermann, " The difference between the Weil  Height and the Canonical Height on Elliptic Curves",
   Math. Comp. Vol 55, No. 192, pp 723-743, 1990.
.P
H.G. Zimmer, "On the Difference between the Weil Height and the Canonical Height",
   Math. Z. 147, pp 35-51, 1976.

M*/
	
/*H
	Version 1	22.09.1993      Josef Gebel
	Version 2	25.05.1994      Berechnung der Differenz auch 
                                        nach Zimmer. JG.
   DATE ecisnfdwhnth  : 930531.941201
H*/

#include <_ec1.h>

floating ecisnfdwhnth( E )
list E;
{
        bind( E );
    if( ( lfourth( lthird( E ) ) == _0 )
    ||  ( lthird( lfourth( lthird( E ) ) ) == 0 ) )
    {
	/*   Abweichung zwischen Weil- und           */
	/*   Neron-Tate-Hoehe noch nicht berechnet   */

        list      F, L, M;
        floating  sres, zres, hfl;
        int D;
           
        /**bind( E ); **/

        init( F, L, M );
        init( sres, zres, hfl );
        init( D );

        D = ecisnfdisc( E );

        /***   Abweichung nach Zimmer                 (Anfang)   ***/
        {
            int a, b;
            init( a, b );

            a = iabs( ecisnfa4( E ) );
            b = iabs( ecisnfa6( E ) );
    
            /***   my = (3/2) * log max{ |a|^(1/2), |b|^(1/3)     ***/
            /***      = max{ (3/4) * log+|a|, (1/2) * log+|b| }   ***/

            if( a )   
            {
                hfl = fllog( itofl( a ) );
                hfl = flquot( hfl, itofl( 4 ) );
                hfl = flprod( hfl, itofl( 3 ) );
            }
            else
            {
                hfl = 0;
            }

            if( b )   
            {
                zres = fllog( itofl( b ) );
                zres = flquot( zres, itofl( 2 ) );
            }
            else
            {
                zres = 0;
            }

            if( flcomp( hfl, zres ) > 0 )
            {
                zres = hfl;
            }

            hfl = fllog( itofl( 2 ) );
            hfl = flprod( hfl, itofl( 19 ) );
            hfl = flquot( hfl, itofl( 12 ) );
            zres = flsum( zres, hfl );

        }
        /***   Abweichung nach Zimmer                   (Ende)   ***/

        /***   Abweichung nach Silverman              (Anfang)   ***/
        {
            rat j, hr;
            init( hr, j );
    
            j = ecrjinv   ( E );
                
            /***********************************************************/
            /*                                                         */
            /*  Seien P ein Punkt auf                                  */
            /*    E: y^2 = x^3 + A * x + B  mit A, B in Z.             */
            /*  Mit den Festsetzungen                                  */
            /*     D = -16 * ( 4 * A^3 + 27 * B ),                     */
	    /*     j = -1728 * ( 4 * A )^3 / D =: j1 / j2,             */
            /*     h(j) = log(max{ |j1|, |j2| }),                      */
            /*     H1 = h(j) / 4 + log(|D|) / 6 + 1.946,               */
            /*  UND                                                    */
            /*     H2 = [h(j) + log(|D|)] / 6 + 2.14                   */
            /*  gilt fuer die Neron-Tate-Hoehe h und die Weil-Hoehe d  */
            /*     | h(P) - d(P) | <= max{ H1, H2 }.                   */
            /*                                                         */
            /***********************************************************/
     
            hr  = itor( iabs( D ) );
            sres = fllog( rtofl( hr ) );
    
            if( j )
            {
                hr  = rabs ( j );
                hfl = fllog( rtofl( hr ) );
                hfl = flprod( hfl, Cfltofl( 1.5 ) );
            }
            else 
            {
                hfl = 0;
            }
    
            sres = flsum( sres, hfl );
            sres = flquot( sres, itofl( 6 ) );
            sres = flsum( sres, Cfltofl( 1.946 ) );
        }
        /***   Abweichung nach Silverman               (Ende)   ***/

        if( flcomp( sres, zres ) > 0 )
        {
            hfl = zres;
        }
        else
        {
            hfl = sres;
        }

        F = ecisnffdisc( E );
	L = lthird( E );
	M = list3( D, F, hfl );

        leset ( L, 4, M );
	leset ( E, 3, L );

        return( hfl );
    }

    return( lthird( lfourth( lthird( E ) ) ) );
}   
