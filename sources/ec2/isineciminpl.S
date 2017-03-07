/*M
.SH NAME
isineciminpl - is in list of points on elliptic curve with integer coefficients, minimal model

.SH SYNOPSIS
.nf
#include<_ec2.h>

single isineciminpl(E, RL, h, PL)  
list E, RL, PL; 
floating h;

.SH DESCRIPTION
.TP 4
.B E
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'. 
.TP 4
.B RL
= (x y z), is a list of three integers, defining a point, say R, on the minimal model of E/Q.
.TP 4
.B h
is the Neron Tate height of R.
.TP 4
.B PL
is a list in the shape
.IP
PL = ( P1 h1 P2 h2 ... Pr hr ), where 
.IP
Pi
= (xi yi zi) int xi, yi, zi; is a point on the minimal model of E/Q,
.IP
hi
is the Neron-Tate height of Pi, and
.IP
h1 <= h2 <= ... .
.PP
isineciminpl checks out whether the point R is admit to PL.
R is neither allowed to be a torsion point nor to be the sum of a torsion point (incl. (0 : 1 : 0)) and a point of PL, i.e. the Neron-Tate heigth of R is not allowed to be 0 or equal to the Neron-Tate height of a point of PL.
.PP
isineciminpl returns
.IP
 -3, if R = (0 : 1 : 0),
 -2, if R is a torsion point,
 -1, if -R is in PL,
  0, if R is not a torsion point and neither R+T 
     nor -R+T (for all torsion points T) is in PL,  
  1, if R is in PL,  
  2, if R+T or -R+T are in the list PL (for all 
     torsion points T),
  ERROR else. 

.SH SEE ALSO
ecrinit

M*/

/*H
	Version 1       12.11.1992      Josef Gebel
	Version 2       10.01.1993      aus 'ecrmaninalg' ausgelagert.
					Anpassung an neues Konzept. JG.
	Version 3       17.10.1995      ECIMINPCOMPMT --> ECIMINPCMT JG
   DATE isineciminpl  : 930531.951201
H*/

#include <_ec2.h>

single isineciminpl( E, P, h, PL )
list E, P, PL;
floating h;
{
    single k;
    
    list  Q, PL1;
    floating hf1, hf2;

    bind( h );
    bind( E, P, PL );

    if( !h )
    {
        if( lthird( P ) == 0 )
	{
            /*   P = ( O : 1 : 0 )                            */
	    return( -3 );  
        }
	
        /*   P = Torsionspunkt != ( O : 1 : 0 )       */
	return( -2 );  
    }

    if( PL == _0 )
    {
        /*   P != Torsionspunkt und Liste ist leer         */
	return( 0 );
    }

    init( Q, PL1 );
    init( hf1, hf2 );

    PL1 = PL;
    while( 1 ) 
    {
        Q   = lfirst ( PL1 );
	hf1 = lsecond( PL1 );

	hf2 = fldif( h, hf1 );

	if( flcomp( flabs( hf2 ), NTH_TOL ) <= 0 )
	{
	    /*   h ~ hf2 ==> +/- P + T moeglicherweise in PL   */

	    if( ( k = eciminpcmt( E, P, Q ) ) )
	    {
		return( k );
	    }
	}
	
	PL1 = lred2( PL1 );

	if( ( flsign( hf2 ) < 0 )  ||  ( PL1 == _0 ) )
	{
	    /*   h > hf1 ==> P noch nicht in PL, da alle    */
	    /*   folgenden Punkte in PL Hoehe > hf1 haben   */
            return( 0 );
	}
    }
}
