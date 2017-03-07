/*M
.SH NAME
ecrbtlistp - elliptic curve over rational numbers, birational transformation of list of points                                                                      
.SH SYNOPSIS                                                                  
.nf                                                                           
#include<_ec1.h>

list ecrbtlistp(LP, BT1, mode )  
list LP, BT1; 
single mode;                                                                     
.SH DESCRIPTION

.TP 4
.B LP
 = ( P1 P2... Pn )
   list Pi,                  for mode = 0 ,
 = ( P1 h1 P2 h2 ... Pn hn)
   list Pi; floating hi;     for mode = 1.
.TP 4
.B Pi
 = ( xi yi zi )
   int xi, yi, zi;
   defines the point Pi on the elliptic curve E/Q.
.TP 4
.B hi 
 is the Neron-Tate height of the point Pi.
.TP 4
.B BT1
 = ( r s t u )
 rat r, s, t, u;        u != 0,
 defines the bi-rational transformation BT.
.PP
ecrbtlistp transforms all points of LP by BT, and returns them in a list like LP.                                                               
M*/ 

/*H
	Version 1	12.11.1992	Josef Gebel
	Version 2       11.01.1993      Abfrage im Fall modus != 0 geaendert. 
					Anpassung an neues Konzept JG
	Version 3       11.01.1993      Abfrage im Fall modus != 0 erneut 
                                        geaendert. JG.
   DATE ecrbtlistp    : 921130.930531.941201
H*/

#include <_ec1.h>

list ecrbtlistp( LP, BT, modus ) 
list LP, BT;
single modus;
{
    list L, P, Q;
    floating h;

    bind( LP, BT );
    init( L, P, Q );
    init( h );

    if( ( LP == _0 )  
    ||  ( !lfirst( BT ) && !lsecond( BT ) && !lthird( BT ) &&
	  !rcomp( itor( 1 ), lfourth( BT ) ) ) )
    {
	/*   Punktliste ist leer                            */
	/*   oder Transformation ist identische Abbildung   */
       return( LP );
    }

    L = _0;

    while( LP != _0 )
    {
	P  = lfirst( LP );
	LP = lred( LP );
	Q = ecrbtp( P, BT );
	L = lcomp( Q, L );
	if( modus )
	{
            h = lfirst( LP );
	    L = lcomp( h, L );
	    LP = lred( LP );
	}
    }

    return( linv( L ) );
}
