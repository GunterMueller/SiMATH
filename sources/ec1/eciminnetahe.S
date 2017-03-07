/*M
.SH NAME
eciminnetahe - elliptic curve with integer coefficients, minimal model, Neron-Tate height

.SH SYNOPSIS
.nf
#include<_ec1.h>

floating eciminnetahe(E1, P1)  
list E1, P1;

.SH DESCRIPTION
.TP 4
.B E1
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.
.TP 4
.B P1
= ( x y z )   int x, y, z;                                                      
 defines the point P on the minimal model ( of                                  
 restricted typ; i.e. a1', a3' = 0 or 1,                                        
 a2' = -1, 0, 1.) of the elliptic curve E/Q.
.PP
eciminnetahe computes the Neron-Tate height of the point P with an error smaller than 10^{-NTH_EPS} ( s. <_ec1.h> and 'eciminntheps').
                                 
.SH SEE ALSO
 ecrinit
 eciminntheps

 J.H. Silverman: Math. of Comp., 51, 1988, p.339-358.

M*/

/*H
        Version 1       19.02.1992      Joachim Stein 
	Version 2       05.10.1992      Abfrage auf Torsionspunkt 
					eingebaut.  J.St.
        Version 3       23.12.1992      Anpassung an neues Konzept.
					Abfrage auf Torsionspunkt 
					geaendert,
					Ersetzung: f := 2 * f.
					ERCNETAHE -> ECIMINNETAHE  JG
        Version 4       12.04.1994      p = 3 beim Test auf Torsion
                                        ausgeschlossen. JG.
   DATE eciminnetahe  : 920331.921130.930531.941201
H*/

#include <_ec1.h>

floating eciminnetahe( E, P )
list E, P;
{
    floating f, g;
	bind(E,P);
	init(f,g);

    if( ispecrpai( P ) )
    {
	/*   P = unendlich ferner Punkt ==> h( P ) = 0   */
	return( 0 );
    }

    /**bind( E, P );
    init( f, g ); **/

    /*   Berechnung der archimedischen lokalen Hoehe       */
    f = eciminlhaav( E, P );

    /*   Berechnung der Summe aller                        */
    /*   nichtarchimedischer lokaler Hoehen                */
    g  = eciminlhnaav( E, P );

    f  = flsum( f, g );

    /*   Test, ob P Torsionspunkt ist.                     */
    if( flcomp( f, NTH_TOL ) < 0 )
    {
	single t, a4, a6, p;
	int D;
	list Q;

	init( D );
	init( Q );


	D = ecimindisc( E );

	/*   t ist die Nummer der aktuellen Primzahl p in der    */
        /*   (globalen) Liste LIST_SP, die die ersten 167        */
        /*   Primzahlen enthaelt.                                */
            
	t = 2;

	while( 1 )
	{
	    p = LIST_SP[t];
            t++;

            if( mshom( p, D ) != 0 )
            {
                /*   E hat gute Reduktion modulo p.    */
		/*   ==> #E(Fp) ist Vielfaches der     */
		/*       Ordnung der Torsionsgruppe.   */
     
                a4 = mshom( p, ecisnfa4( E ) );
                a6 = mshom( p, ecisnfa6( E ) );
                t = ecmspsnfnp( p, a4, a6 );
		break;
	    }
	}
	    
	Q = eciminmul( E, P, t );   /*  Q = t * P   */
	if( ispecrpai( Q ) )
	{
	    /*   P Torsionspunkt   */
	    return( 0 );
	}
    }

    f = flsum( f, f );

    return( f );
} 
