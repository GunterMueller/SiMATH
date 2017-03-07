/*M
.SH NAME
eciminnetapa - elliptic curve with integer coefficients, minimal model, Neron-Tate pairing

.SH SYNOPSIS
.nf
#include<_ec1.h>

floating eciminnetapa(E1, P1, Q1)  
list E1, P1, Q1;

.SH DESCRIPTION
.TP 4
.B E1
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.
.TP 4
.B P1
= ( xP yP zP )   int xP, yP, zP;                                               
 defines the point P on the minimal model ( of                                  
 restricted typ; i.e. a1', a3' = 0 or 1,                                        
 a2' = -1, 0, 1.) of the elliptic curve E/Q.
.TP 4
.B Q1
analog to P1.
.PP
eciminnetapa computes the Neron-Tate pairing
.IP
f = [ h( P + Q ) - h( P ) - h( Q ) ] / 2
  = [ h( P + Q ) - h( P - Q ) ] / 4
.PP
of the points P and Q with an error smaller than 10^{-NTH_EPS} ( s. _ec1.h ).
.TP 4
.B h()
is the Neron-Tate height ( s. 'eciminnetahe').

.SH SEE ALSO
 ecrinit
 eciminnetahe

M*/

/*H
	Version 1	12.11.1992	Josef Gebel
	Version 2	28.12.1992	Doku neu und Parameter LC an 
					erste (statt an dritte) Stelle.
					PS
	Version 3	22.01.1993	Anpassung an neues Konzept.
					Ersetzung von 
					[ h(P+Q) - h(P) - h(Q) ] / 2
					durch [ h(P+Q ) + h(P-Q) ]/4
					ECINETAPA --> ECIMINNETAPA.  JG
	Version 4	19.10.1994	Dokumentaion geaendert. MP	
   DATE eciminnetapa  : 921130.930115.930531.941201
H*/

#include<_ec1.h>

floating eciminnetapa( E, P, Q )
list E, P, Q;
{
        bind( E, P, Q );
    if( ispecrpai( P )  ||  ispecrpai( Q ) )
    {
	/*  P = ( 0 : 1 : 0 ) oder Q = ( 0 : 1 : 0 )   */
	/*                      ==> erg = 0            */

        return( 0 );
    }
    else
    {
	single    i;
        floating  erg;
  
        /**bind( E, P, Q ); **/
        init( erg );
    
        if( !icomp( lfirst( P ), lfirst( Q ) ) 
        &&  !icomp( lthird( P ), lthird( Q ) ) )
        {
            /*   P = +/- Q:  P = +Q ==> erg = + h( P )     */
            /*               P = -Q ==> erg = - h( P )     */
    
            erg = eciminnetahe( E, P );
    
            if( icomp( lsecond( P ), lsecond( Q ) ) )
	    {
                /*   P = -Q ==> erg = - h( P )     */
	        flneg( erg );
            }
        }
        else
        {
	    floating  flh;
            list      R;
         
            init( flh );
            init( R );
            
            R   = eciminsum( E, P, Q );
            erg = eciminnetahe( E, R );
            R   = ecimindif( E, P, Q );
            flh = eciminnetahe( E, R );
            erg = fldif( erg, flh );
            erg = flquot( erg, itofl( 4 ) );
        }
        return( erg );
    }
}
