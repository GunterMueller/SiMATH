/*M
.SH NAME
ecrrperiod - curve over the rational numbers, real period

.SH SYNOPSIS
.nf
#include<_ec1.h>

floating ecrrperiod(E)
list E;

.SH DESCRIPTION
ecrrperiod() returns the real period w1
of the elliptic curve E/Q over the rational numbers.

If the real period w1 is not yet contained in the list E,
then w1 is computed with a precision of k decimal places where
.PP
    k = 9*(1-FL_EPS)~1 + (1-FL_EPS)*ln(2^30)/ln(10)

.TP 4
.B E
is a list containing the data of an elliptic curve E/Q over the rational numbers.


.SH NOTE
Both the result and the value of FL_EPS are stored in the list E.
If the result is not yet contained in E or if the result computed
using the current value of FL_EPS would be more precise than the
one already contained in E, the former result and the former value
of FL_EPS in E will be replaced. If a more precise value is already
contained in E, it is cut using fltofl() and then returned.

.SH REFERENCES
D.R. Grayson, "The Arithogeometric Mean", Arch. Math. 52, pp. 507-512 (1989)

.SH SEE ALSO
ecrinit, flinit, fltofl
M*/
/*H
	Version 1	12.11.1992	Josef Gebel
	Version 2	19.01.1993	Anpassung an neues Konzept.
					Keine Unterscheidung mehr
					zwischen kWNF und lWNF.  JG
	Version 3	24.10.1994	Fehler beseitigt (Faktor 2 im
                                        Fall Delta > 0 herausgenommen). JG.
	Version 4       03.12.1996      Computation of w_1 now with variable
                                        precision (depending on FL_EPS) JG.
   DATE ecrrperiod    : 921130.930531.941201.970101
H*/

#include<_ec1.h>

static floating agm( a, b, p )
floating a, b, p;
{
    floating c;

    init( c );
    bind( a, b, p );

    while( 1 )
    {
        c = flprod ( a, b );
        a = flsum  ( a, b );
        a = flsquot( a, 2 );
        b = flsqrt  ( c );

        c = flabs( fldif( a, b ) );

        if( flcomp( c, p ) < 0 )
        {
            return( a );
        }
    }

}

floating ecrrperiod( E )
list E;
{
    bind( E );

    if( ( lfifth( lfourth( E ) ) == _0 )                     
    ||  ( lfirst( lfifth( lfourth( E ) ) ) < FL_EPS ) )
    {
        /***   w_1 is either not yet computed or the precison   ***/
        /***   of that computation was not sufficiently large.  ***/

        single prec;
        floating a, b, c, d, e;
        complex  w;
        list     L, M;

        init( L, M, a, b, c, d, e, w );

        prec = 9 * ( FL_EPS - 1 );
        d = rtofl( rcons( 1, 10 ) );
        d = flsexp( d, prec );

        L = ecisnfrroots( E );
        e = lfirst( L );

        if( llength( L ) == 1 )
        {
            /***    E has only one real component    ***/

            a = flprod( e, itofl( 3 ) );
            b = itofl( ecisnfa4( E ) );
            c = flprod( a, e );
            b = flsum ( b, c );
            b = flsqrt( b );
            c = flsum ( b, b );
            a = flsum ( a, c );
            a = flsqrt( a );
            a = flsquot( a, 2 );
            b = flsqrt( b );
        }
        else
        {
            /***    E has two (disconnected) real components    ***/
            a = lsecond( L );
            b = lthird ( L );
            a = fldif( e, a );
            b = fldif( e, b );
            a = flsqrt( a );
            b = flsqrt( b );
            c = itofl( 2 );
        }

        c = agm( a, b, d );
        b = flPi();
        a = flquot( b, c );
        L = ecisnfbtmin( E );
        c = rtofl( lfourth(  L ) );
        a = flprod( a, c );
        M = lfourth( E );
   
        if( ( L = lfifth( M ) ) == _0 )
        {
            L = list6( FL_EPS, a, 0, 0, 0, 0 );
        }
        else
        {
            leset( L, 1, FL_EPS );
            leset( L, 2, a );
        }
        leset( M, 5, L );
        leset( E, 4, M );

        return( a );
    }
    return( fltofl( lsecond( lfifth( lfourth( E ) ) ) ) );
}
