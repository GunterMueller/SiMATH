/*M
.SH NAME
ecimindwhnth - elliptic curve with integer coefficients, minimal model, difference between Weil height and Neron-Tate height

.SH SYNOPSIS
.nf
#include<_ec1.h>

floating ecimindwhnth(E1)
list E1;

.SH DESCRIPTION
ecimindwhnth computes an upper bound, say d, of the difference between the Weil height and the Neron-Tate hight on the elliptic curve E, i.e.
.P
d(P) < h(P) + d ,
.P
holds for any point P on the minimal model of E/Q.
If E1 does not contain the bound d , d will be added to E1.
.TP 4
.B E1
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.The model representing E is of restricted typ (i.e. a1', a3' = 0 or 1, a2' = -1, 0, 1).

.SH SEE ALSO
ecrinit
.P
J.H. Silverman, "The Difference between the Weil Height and the Canonical Height on Elliptic Curves" 
Math. Comp. Vol 55, No. 192, pp 723-743, 1990.
 
M*/
 
/*H
	Version 1	22.06.1992      Josef Gebel             
	Version 2	25.01.1993      Anpassung an neues Konzept. JG
	Version 3	18.10.1993	Warnungen des Apollo-Compilers
					beseitigt.  PS
	Version 4	22.10.1994      Fall 'kurze WNF' durch Modul
                                        'ecisnfdwhnth' ersetzt. J.G.
   DATE ecimindwhnth  : 921130.930531.931130.941201
H*/

#include<_ec1.h>

floating ecimindwhnth( E )
list E;
{
    bind( E );
            
    if( ( lfourth( lsecond( E ) ) == _0 )
    ||  ( lthird( lfourth( lsecond( E ) ) ) == 0 ) )
    {
	/*   Abweichung zwischen Weil- und           */
	/*   Neron-Tate-Hoehe noch nicht berechnet   */
            
        list      F, L, M;
        int       D;
        floating  res;

        init( F, L, M );
        init( D );
        init( res );

        D = ecimindisc( E );

        if( ecimina1( E ) || ecimina2( E ) || ecimina3( E ) )
        {
            int       b2;
            floating  hfl;
            rat       j, hr;
            
            init( hr, j );
            init( b2 );
            init( hfl );
            
            /************************************************************/
            /*                                                          */
            /*  Sei P ein Punkt auf dem minimalen Modell von E/Q        */
            /*  Mit den Festsetzungen                                   */
            /*            d(D) + log+(|j|)      1 /       |b2|        \ */
            /*     H(E) = -----------------  +  - | log+( ---- ) + a  | */
            /*                 12               2 \        12         / */
            /*  und                                                     */
            /*          /  0,     falls b2 = 0                          */
            /*     a = <                                                */
            /*          \  log 2  sonst                                 */
            /*  sowie                                                   */
            /*     log+( x ) = log( max{ |x| , 1 } )                    */
            /*  gilt dann fuer die Neron-Tate-Hoehe h                   */
            /*  und die Weil-Hoehe d                                    */
            /*                                 d(j)                     */
            /*      d(P)  <=  h(P) + 1.946 + ------ + 2 * H(E)          */
            /*                                  12                      */
            /*                                                          */
            /************************************************************/
        
            b2 = eciminb2  ( E );
            j  = ecrjinv   ( E );
    
            hr  = itor( iabs( D ) );
            res = fllog( rtofl( hr ) );
    
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
    
            res = flsum( res, hfl );
            res = flquot( res, itofl( 6 ) );
     
 	    if( b2 )
            {
                hr  = itor( iabs( b2 ) );
                hr  = rquot( hr, itor( 6 ) );
                hfl = fllog( rtofl( hr ) );
                res = flsum( res, hfl );
            }
     
            res = flsum( res, Cfltofl( 1.946 ) );
        }
        else
        {
            /***   E ist in kurzer WNF gegeben                   ***/

            res = ecisnfdwhnth( E );
        }

        F = eciminfdisc( E );

	L = lsecond( E );
	M = list3( D, F, res );
	leset ( L, 4, M );
	leset ( E, 2, L );

        return( res );
    }

    return( lthird( lfourth( lsecond( E ) ) ) );
}   
