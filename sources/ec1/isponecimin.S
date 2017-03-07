/*M
.SH NAME
isponecimin - is point on elliptic curve with integer coefficients, minimal model

.SH SYNOPSIS
.nf
#include<_ec1.h>

single isponecimin(E1, P1)
list E1, P1(x, y, z );
int x, y, z ;

.SH DESCRIPTION
isponecimin returns 1, if the point P lies on the minimal model representing the elliptic curve E/Q,
and 0 else.
.TP 4
.B P1 
defines for z != 0 the point P = (x/z^2, y/z^3 ),
    and for z = 0 the point  at infinity 
of the elliptic curve E/Q.
.TP 4
.B E1
defines the elliptic curve E, as descripted in the documentation of 'ecrinit'.
  
.SH SEE ALSO
ecrinit
M*/

/*H
	Version 1	17.12.1992	Josef Gebel (neues Konzept)
   DATE isponecimin   : 930531
H*/	

#include <_ec1.h>

single isponecimin( E, P )
list E, P;
{
    int z;
    rat x, y, rs, ls;
    bind( E, P );

    if( lthird( P ) == 0 )
    {
	/*   P ist der unendlich ferne Punkt   */
	return( 1 );
    }
    
    /**bind( E, P ); **/

    init( z );
    init( x, y, rs, ls );

    z = lthird( P );
    z = iprod( z, lthird( P ) );
    
    if( lfirst( P ) )
    {
        x = list2( lfirst( P ), z );
    }
    else
    {
        x = 0;
    }

    if( lsecond( P ) )
    {
        z = iprod( z, lthird( P ) );
        y = list2( lsecond( P ), z );
    }
    else
    {
        y = 0;
    }

    /*   ls = linke  Seite = y^2 + a1 x y + a3 y      */
    z  = ecimina1( E );
    ls = rprod(  x, itor( z ) );
    z  = ecimina3( E );
    ls = rsum ( ls, itor( z ) );
    ls = rsum ( ls, y );
    ls = rprod( ls, y );

    /*   rs = rechte Seite = x^3 + a2 x^2 + a4 x + a6    */
    z  = ecimina2( E );
    rs = rsum (  x, itor( z ) );
    rs = rprod( rs, x );
    z  = ecimina4( E );
    rs = rsum ( rs, itor( z ) );
    rs = rprod( rs, x );
    z  = ecimina6( E );
    rs = rsum ( rs, itor( z ) );

    if( rdif( rs, ls ) )
    {
	/*   linke Seite != rechte Seite   */
        return( 0 );
    }

    /*   else: linke Seite == rechte Seite   */
    return( 1 );
}   
