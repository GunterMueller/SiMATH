/*M
.SH NAME
ecrbtco - elliptic curve over rational numbers, birational transformation of coefficients

.SH SYNOPSIS
.nf
#include<_ec1.h>

list ecrbtco(E1, BT1)  
list E1, BT1;

.SH DESCRIPTION
The elliptic curve E will be birationaly transformed by BT.                     
                                                                                
ecrbtco returns a list                                                         
.P                                                                              
	L = (a1' a2' a3' a4' a6')
.P 
	rat a1', a2', a3', a4', a6' ,   where                                
.P                                                                              
a1', ... ,a4', a6' are the coefficients of the transformed curve, given in Weierstrass normal form.
.TP 4
.B L1 = ( a1 a2 a3 a4 a6 )  rat a1, a2, a3, a4, a6;
is a list, containing the coefficients a1, ... a4, a6 of the elliptic curve E/Q, given in Weierstrass normal form.
.TP 4
.B BT1 = ( r s t u )  rat r, s, t, u 
is a list, defining the birational transformation BT, by
.P
        x = u^2*x' + r,                                                         
        y = u^3*y' + u^2*s*x' + t.                                              
.P
where u must not be 0.
       
.SH SEE ALSO
J.H. Silverman: The arithmetic of elliptic curves, p.49.

M*/

/*H
	Version 1       17.10.1989      Michael Pfeifer
	Version 2       27.08.1991      von 'arith1 nach 'ec1.  PS
	Version 3       01.04.1993      Eingabeparameter geaendert, Anpassung
	                                an das neue Konzept. JG
   DATE ecrbtco       : 900315.9011__.910915.930531
H*/

#include <_ec1.h>

list ecrbtco( LC, BT )
list LC, BT;
{
    rat a1, a2, a3, a4, a6, r, s, t, u;
    rat a1s, a2s, a3s, a4s, a6s, h1, h2;
    
    bind( LC, BT );
    init( a1, a2, a3, a4, a6, r, s, t, u );
    init( a1s, a2s, a3s, a4s, a6s, h1, h2 );
    
    a1 = lfirst ( LC );
    a2 = lsecond( LC );
    a3 = lthird ( LC );
    a4 = lfourth( LC );
    a6 = lfifth ( LC );
    	
    r = lfirst ( BT );
    s = lsecond( BT );
    t = lthird ( BT );
    u = lfourth( BT );
    
    h2 = u;
    
    /*   Berechnung von a1' ( hier a1s )                            */
    
    a1s = a1;
    h1 = itor( 2 );
    h1 = rprod( h1, s );
    a1s = rsum( a1s, h1 );
    a1s = rquot( a1s, h2 );
    
    /*   Berechnung von a2' ( hier a2s )                           */
    
    h2 = rprod( h2, u );
    a2s = a2;
    h1 = rprod( s, a1 );
    a2s = rdif( a2s, h1 );
    h1 = itor( 3 );
    h1 = rprod( h1, r );
    a2s = rsum( a2s, h1 );
    h1 = rprod( s, s );
    a2s = rdif( a2s, h1 );
    a2s = rquot( a2s, h2 );
    
    /*   Berechnung von a3' ( hier a3s )                            */
    
    h2 = rprod( h2, u );
    a3s = a3;
    h1 = rprod( r, a1 );
    a3s = rsum( a3s, h1 );
    h1 = itor( 2 );
    h1 = rprod( h1, t );
    a3s = rsum( a3s, h1 );
    a3s = rquot( a3s, h2 );
    
    /*   Berechnung von a4' ( hier a4s )                            */
    
    h2 = rprod( h2, u );
    a4s = a4;
    h1 = rprod( s, a3 );
    a4s = rdif( a4s, h1 );
    h1 = itor( 2 );
    h1 = rprod( h1, r );
    h1 = rprod( h1, a2 );
    a4s = rsum( a4s, h1 );
    h1 = rprod( r, s );
    h1 = rsum( h1, t );
    h1 = rprod( h1, a1 );
    a4s = rdif( a4s, h1 );
    h1 = itor( 3 );
    h1 = rprod( h1, r );
    h1 = rprod( h1, r );
    a4s = rsum( a4s, h1 );
    h1 = itor( 2 );
    h1 = rprod( h1, s );
    h1 = rprod( h1, t );
    a4s = rdif( a4s, h1 );
    a4s = rquot( a4s, h2 );
    
    /*   Berechnung von a6' ( hier a6s )                            */
    
    h2 = rprod( h2, u );
    h2 = rprod( h2, u );
    a6s = a6;
    h1 = rprod( r, a4 );
    a6s = rsum( a6s, h1 );
    h1 = rprod( r, r );
    h1 = rprod( h1, a2 );
    a6s = rsum( a6s, h1 );
    h1 = rprod( r, r );
    h1 = rprod( h1, r );
    a6s = rsum( a6s, h1 );
    h1 = rprod( t, a3 );
    a6s = rdif( a6s, h1 );
    h1 = rprod( t, t );
    a6s = rdif( a6s, h1 );
    h1 = rprod( t, r );
    h1 = rprod( h1, a1 );
    a6s = rdif( a6s, h1 );
    a6s = rquot( a6s, h2 );
    
    return( list5( a1s, a2s, a3s, a4s, a6s ) );
}
