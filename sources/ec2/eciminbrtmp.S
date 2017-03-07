/*M
.SH NAME
eciminbrtmp - elliptic curve with integer coefficients, minimal model, bad reduction type modulo prime

.SH SYNOPSIS
.nf
#include<_ec2.h>

list eciminbrtmp(E, p, n)  
list E; 
int p; 
single n;

.SH DESCRIPTION
.TP 4
.B E
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.        
.TP 4
.B p 
is a prime number, p > 3.
.TP 4
.B n
is the largest natural number with p^n divides the discriminant of the minimal model of the elliptic curve E/Q.
.PP
eciminbrtmp returns a list, say L, with
.PP
L = (exp rtyp cp )  single exp, rtype cp; where
.IP
exp
is the exponent of the (local) conductor,
.IP 
rtyp
is the reduction typ (s. tab. in ecimintate),
.IP 
cp
is the c_p value (s. ecimintate).
.PP
In case of an error, eciminbrtmp returns the list (-1).
   
.SH SEE ALSO
 ecrinit
 ecimintate 

M*/

/*H
	Version 1	19.01.1993	Josef Gebel (neues Konzept,
					eciminbrtmp ersetzt ECIBRT)
   DATE eciminbrtmp   :	930531.9512__
H*/

#include<_ec2.h>

list eciminbrtmp( E, p, n )
list   E;
int    p;
single n;
{
    single exp, rtyp, c_p, e4, e6;
    int    h1, h2, A4, A6;

    bind( E );
    bind( p );
    
    init( h1, h2, A4, A6 );

    h1 = eciminc4( E );
    A4 = ecisnfa4( E );
    A6 = ecisnfa6( E );

    if( mihom( p, h1 ) != 0 )
    {
	/*   Multiplikative Reduktion mod p                        */
	/*   REDUKTIONSTYP Bn oder In                              */
	/*   Sei js = Jacobi-Symbol( -2 * A4 * A6, p ).            */
	/*          /  n, falls js == +1                           */
	/*   c_p = <   1, falls js == -1 und n ungerade            */
	/*          \  2, falls js == -1 und n   gerade            */

	exp  = 1;
        rtyp = (-1) * n;

	h2 = iprod( A4, A6 );
	h1 = iprod( h2, -2 );

	if( ijacsym( h1, p ) == 1 )
	{
	    c_p = n;
        }
	else
	{
	    if( ( n % 2 ) == 1 )
	    {
	       c_p = 1;
            }
	    else
	    {
	       c_p = 2;
            }
        }

	return( list3( exp, rtyp, c_p ) );
    }

    /*   Ab hier additive Reduktion mod p                          */
	
    if( n == 2 )
    {
	/*   REDUKTIONSTYP C1 oder II                              */

	exp  = 2;
	rtyp = 1;
        c_p  = 1;

	return( list3( exp, rtyp, c_p ) );
    }
    
    if( n == 3 )
    {
	/*   REDUKTIONSTYP C2 oder III                             */

	exp  = 2;
	rtyp = 2;
        c_p  = 2;

	return( list3( exp, rtyp, c_p ) );
    }

    if( n == 4 )
    {
	/*   REDUKTIONSTYP C3 oder IV                              */

	exp  = 2;
	rtyp = 3;

	h1 = iquot( A6, p * p );

	if( ijacsym( h1, p ) == 1 )
	{
	    c_p = 3;
        }
	else
	{
	    c_p = 1;
        }

	return( list3( exp, rtyp, c_p ) );
    }

    if( n == 6 )
    {
	/*   REDUKTIONSTYP C4 oder I0*                             */
	/*   c_p = 1 + Anzahl der Nullstellen von P(T) in F_p      */
        /*       = 1 + { 0, 1 oder 3 }                             */
        
	pol    P;
        list   L;

	init( P );
        init( L );

	exp  = 2;
	rtyp = 5;

	h1 = iprod(  p,  p );
	h2 = iprod(  p, h1 );
	A4 = iquot( A4, h1 );
	A6 = iquot( A6, h2 );
	h1 = mihom(  p, A4 );
	h2 = mihom(  p, A6 );

	P = _0;

	if( h2 != 0 ) 
	{
	    P = lcomp2( 0, h2, P );
	}
	if( h1 != 0 ) 
	{
	    P = lcomp2( 1, h1, P );
	}
	P = lcomp2( 3, 1, P );

        L = upmscfacts( p, P );

	if( llength( L ) == 2 )
	{
	    c_p = 1;
        }
	else if( llength( L ) == 4 )
	{
	    c_p = 2;
        }
	else
	{
	    c_p = 4;
	}

	return( list3( exp, rtyp, c_p ) );
    }

    /*   Berechnung der p-Ordnung e4 von A4                        */

    if( A4  &&  A6 )
    {
        e4  = iavalint( p, A4 );
        e6  = iavalint( p, A6 );
        A4 = ecisnfa4( E );
        A6 = ecisnfa6( E );
    
        if( ( e4 == 2 )  &&  ( e6 == 3 ) )
        {
	    /*   REDUKTIONSTYP C5,v oder Iv*                           */
	    /*   Seien j1 = j * p^v  mit  v = n - 6, A4* = A4 / p^2,   */
	    /*   A6* = A6 / p^3 sowie h = (-1)^([p+1]/2) A4* A6*.      */
	    /*          / 4, falls n  gerade und j1  ein Quadrat mod p */
	    /*          | 2, falls n  gerade und j1 kein Quadrat mod p */
	    /*   c_p = <                                               */
	    /*          | 4, falls n ungerade und h  ein Quadrat mod p */
	    /*          \ 2, falls n ungerade und h kein Quadrat mod p */
	
            rat    j;
            init( j );

	    exp  = 2;
	    rtyp = 4 + n;  /*   = 10 + v                               */
	    j = ecrjinv( E );

	    h1 = rnum( j );
	    h2 = rden( j );
	    for( e4 = 0; e4 < n - 6; e4++ )
	    {
	        h2 = iquot( h2, p );
	    }

	    if( h2 == 0 )
	    {
	       return( list1( -1 ) );
	    }
	
	    h2 = miinv( p, h2 );

	    h1 = iprod( h1, h2 );
	    /*   h1 = ( j * p^v ) mod p                               */
	    /*       = { Zaehler(j) * [Nenner(j) * p^6 ]^[-1] } mod p  */

	    if( ( n % 2 ) == 0 )
	    {
	        if( ijacsym( h1, p ) == 1 )
	        {
	            c_p = 4;
	        }
	        else
	        {
	            c_p = 2;
	        }
	    }
	    else
	    {
	        if( mshom( 4, p ) == 1 )
	        {
	            h2 = -2;
	        }
	        else
	        {
	            h2 = 2;
	        }
     
                h2 = miprod( p, h2, h1 );
                h2 = miprod( p, h2, A4 );
                h2 = miprod( p, h2, A6 );
     
	        if( ijacsym( h2, p ) == 1 )
	        {
	            c_p = 4;
	        }
	        else
	        {
	            c_p = 2;
	        }
            }
    	
	    return( list3( exp, rtyp, c_p ) );
        }
    }

    if( n == 8 )
    {
	/*   REDUKTIONSTYP C6 oder IV*                             */

	exp  = 2;
	rtyp = 6;

	h2 = iprod( p, p );
	h2 = iprod( h2, h2 );
	h1 = iquot( A6, h2 );

	if( ijacsym( h1, p ) == 1 )
	{
	    c_p = 3;
        }
	else
	{
	    c_p = 1;
        }

	return( list3( exp, rtyp, c_p ) );
    }
    
    if( n == 9 )
    {
	/*   REDUKTIONSTYP C7 oder III*                            */

	exp  = 2;
	rtyp = 7;
	c_p  = 2;

	return( list3( exp, rtyp, c_p ) );
    }

    if( n == 10 )
    {
	/*   REDUKTIONSTYP C8 oder II*                             */

	exp  = 2;
	rtyp = 8;
	c_p  = 1;

	return( list3( exp, rtyp, c_p ) );
    }

    /*   Fehlerhafter Durchlauf                                    */
    return( list1( -1 ) );
}
