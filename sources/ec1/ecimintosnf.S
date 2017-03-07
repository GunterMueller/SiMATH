/*M
.SH NAME
ecimintosnf - elliptic curve with integer coefficients, minimal model to short normal form

.SH SYNOPSIS
.nf
#include<_ec1.h>

list ecimintosnf(E1)
list E1;

.SH DESCRIPTION
ecimintosnf returns a list:
.PP
   L = ( a4, a6, BTms )
   int a4, a6;
   list BTms(r, s, t, u);
   rat r, s, t, u;
.PP
where
 a4, a6                                                                       
are the coefficients of the elliptic curve E/Q, represented in short Weierstrass normal form, and
 BTms                                                                         
is the bi-rational transformation, that transforms the minimal model to the model in short normal form.
                                      
If E1 does not contain a4, a6 or BTms, they will be added to E1.
.TP 4                                                                           
.B E1
defines the elliptic curve E/Q, as descripted in the documentation of 'ecrinit'.

                                                                           
.SH SEE ALSO
ecrinit
M*/

/*H
	Version 1	17.12.1992	Josef Gebel (neues Konzept)
   DATE ecimintosnf   : 930531
H*/	

#include <_ec1.h>

list ecimintosnf( E )
list E;
{
    int a1, a3, A4, A6;
    list BT;

    bind( E );
    
    init( a1, a3, A4, A6 );
    init( BT );
        
    a1 = ecimina1( E );
    a3 = ecimina3( E );

    if( !a1  &&  !ecimina2( E )  &&  !a3 )
    {
	/*   minimales Modell ist schon in kurzer WNF   */

        A4 = ecimina4( E );
        A6 = ecimina6( E );
	BT = list4( 0, 0, 0, itor( 1 ) );
    }
    else
    {
        rat r, s, t, u, h1, h2, h3;
    
        init( r, s, t, u, h1, h2, h3 );

        /*   Berechnung der Koeffizienten    */
        A4 = iprod( eciminc4( E ), -27 );
        A6 = iprod( eciminc6( E ), -54 );
        
        /*   Berechnung der Transformation   */
        h1 = itor( a1);
        h2 = itor( eciminb2( E ) );
        h3 = list2( -1, 12 );
        r  = rprod( h2, h3 );
        h3 = list2( -1, 2 );
        s  = rprod( h1, h3 );
        t  = itor ( a3 );
        t  = rprod(  t, h3 );
        h3 = list2(  1, 24 );
        h3 = rprod( h1, h3 );
        h3 = rprod( h2, h3 );
        t  = rsum (  t, h3 );
        u  = list2(  1, 6 );

        BT = list4( r, s, t, u );
    }

    return( list3( A4, A6, BT ) );
}   
