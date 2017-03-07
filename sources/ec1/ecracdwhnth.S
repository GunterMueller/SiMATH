/*M
.SH NAME
ecracdwhnth - curve over the rational numbers, actual model, difference between Weil height and Neron-Tate height

.SH SYNOPSIS
.nf
#include<_ec1.h>

floating ecracdwhnth(E) 
list E;

.SH DESCRIPTION
ecracdwhnth() returns an upper bound D for the difference between
the Weil height d and the Neron-Tate height h on the 
actual model of the elliptic curve E/Q,
i.e. d(P) < h(P) + D for all P in E(Q).
If the bound D is not yet contained in the list E it will be computed and stored in E.

.PP
.TP 4
.B E
is a list containing the data of an elliptic curve E/Q over the rational numbers.

.SH REFERENCES
J.H. Silverman, "The Difference between the Weil Height and the Canonical Height on Elliptic Curves",
Math. Comp. Vol 55, No. 192, pp 723-743, 1990.

.SH SEE ALSO
ecrinit
M*/

/*H
	Version 1	22.12.1994      Josef Gebel             
   DATE ecracdwhnth   : 
H*/

#include<_ec1.h>

floating ecracdwhnth( E )
list E;
{
    bind( E );
            
    if( ( lfourth( lfirst( E ) ) == _0 )
    ||  ( lthird( lfourth( lfirst( E ) ) ) == 0 ) )
    {
	/*   Abweichung zwischen Weil- und           */
	/*   Neron-Tate-Hoehe noch nicht berechnet   */
            
        list      F, L, M;
        rat       D, b2, j, hr;
        floating  res, hfl;

        init( F, L, M );
        init( D, b2, j, hr );
        init( res, hfl );

        D = ecracdisc( E );

        /************************************************************/
        /*                                                          */
        /*  Sei P ein Punkt auf dem urspruenglichen Modell von E/Q  */
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
    
        b2 = ecracb2( E );
        j  = ecrjinv( E );
 
        hr  = rabs( D );
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
            hr  = rabs( b2 );
            hr  = rquot( hr, itor( 6 ) );
            hfl = fllog( rtofl( hr ) );
            res = flsum( res, hfl );
        }
 
        res = flsum( res, Cfltofl( 1.946 ) );

        F = ecracfdisc( E );

	L = lfirst( E );
	M = list3( D, F, res );
	leset ( L, 4, M );
	leset ( E, 1, L );

        return( res );
    }

    return( lthird( lfourth( lfirst( E ) ) ) );
}   
