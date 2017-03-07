/*M
.SH NAME
ecimindivby2 - elliptic curve with integer coefficients, minimal model, division by 2 of a point

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecimindivby2(E, RL, h, PL, H)  
list E, RL, *PL;  
floating h, *H;
 
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
points on a list in the shape
.IP
*PL = ( P1 h1 P2 h2 ... Pr hr ), where
.IP
Pi
= (xi yi zi) int xi, yi, zi; is a point on the minimal model of E/Q,
.IP
hi
is the Neron-Tate height of Pi, and
.IP
h1 <= h2 <= ... .
.TP 4
.B H 
points on a non negative floating.
.PP
ecimindivby2 tries to divide the point R (modulo torsion) by 2, i.e. to find a point P in the point list *PL with
.IP
R + T = 2 * P = P + P   (T torsion point on E/Q).
.PP
By success, ecimindivby2 returns a list of three elements, defining that point P, else ecimindivby 2 returns the list (0).

.SH SEE ALSO
ecrinit

M*/
                   
/*H
	
	Version 1       12.11.1992      Josef Gebel
        Version 2       21.01.1993      Auslagerung aus 'ecrmaninalg' und
				 	Anpassung an neues Konzept.  JG
	Version 3       05.09.1993      Fall 'PL zu klein' verbessert.  JG
	Version 4	17.10.1995	ECIMINPCOMPMT --> ECIMINPCMT JG
   DATE ecimindivby2  : 930531.931130.951201
H*/

#include <_ec2.h>

list ecimindivby2( E, P, h, PL, H )
list E, P, *PL;
floating h, *H;
{
    list      Q, R, S, T, TG, PL1;
    floating  hf1, hf2, hf3;

    bind( E, P, *PL );
    bind( h, *H );
   
    init( Q, R, S, T, TG, PL1 );
    init( hf1, hf2, hf3 );

    hf1 = flquot( h, itofl( 4 ) );
    hf2 = ecimindwhnth( E );
    hf2 = flsum( hf1, hf2 );

    /*    Bisher nur Punkte mit Hoehe h( Q ) <= H berechnet.      */
    if( flcomp( hf2, *H ) > 0 )
    {
	/*   PL eventuell zu klein                                */
	if( flcomp( *H, itofl( 8 ) ) > 0 )
	{
	    if( flcomp( *H, itofl( 10 ) ) > 0 )
	    {
	        hf3 = flsum( *H, rtofl( rcons( 1, 4 ) ) );
	    }
	    else
	    {
	        hf3 = flsum( *H, rtofl( rcons( 1, 2 ) ) );
	    }
	}
	else
	{
	    hf3 = flsum( *H, itofl( 1 ) );
	}
	if( flcomp( hf3, hf2 ) < 0 )
	{
	   hf3 = hf2;
	}
	PL1 = _0;
	ecisnfpbwh( E, PL, H, hf3, 2, 0, &PL1 );
    }

    PL1 = *PL;

    while( PL1 != _0 )
    {
	hf2 = lsecond( PL1 );
	hf3 = fldif( hf2, hf1 );
	
	if( flcomp( flabs( hf3 ), NTH_TOL ) < 0 )
	{
	    R  = lfirst( PL1 );
	    S  = ecimindouble( E, R );
	    
	    if( eciminpcmt( E, P, S ) )
	    {
	        /*   R ist Kandidat fuer 2 * R = +/-P + T    */
		/*   S = T + P oder S = T - P                */
		/*              ==> T +/- P = 2 * (+/-) R    */

		return( list2( R, hf2 ) );
	    }

	}
	if( flcomp( hf3, NTH_TOL ) > 0 )
	{
	    /*   h / 4 > h( R ), wenn R der aktuelle Punkt in     */
	    /*   der Liste PL1 ist. Da PL1 nach aufsteigenden     */
	    /*   Werten h( R ) geordnet ist, kann kein Punkt R    */
	    /*   mit 2 R = P mehr in der reslichen Liste sein.    */
	    return( list1( 0 ) );
	}
	
	PL1 = lred2( PL1 );
    }
    
    return( list1( 0 ) );
}
