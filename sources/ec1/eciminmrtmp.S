/*M
.SH NAME
eciminmrtmp - elliptic curve with integer coefficients, minimal model, multiplicative reduction type modulo prime

.SH SYNOPSIS
.nf
#include<_ec1.h>

single eciminmrtmp(E1, p)  
list E1; int p;

.SH DESCRIPTION
.TP 4
.B E1
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.
.TP 4
.B p 
is a prime number. E/Q has a multiplicativ reduction with regard to p.
.PP
eciminmrtmp returns:
.TP 4
-1, 
 if the multiplicativ reduction at p is split,
.TP 4
 1, 
 if the multiplicativ reduction at p is non-split,
.PP 
ERROR, in case of an error occurs. 

.SH SEE ALSO
ecrinit

J. H. Silverman: The Arithmetic of Elliptic Curves
 
M*/

/*H
	Version 1       16.04.1991      Michael Pfeifer
	Version 2       27.08.1991      von 'arith1 nach 'ec1.  PS
	Version 3	02.04.1992	ECRMRTMP --> ECIMRTMP.
					Dokumentation angepasst. MP
	Version 4	12.11.1992	Neu geschrieben.  Josef Gebel.
	Version 5	14.12.1992	mpsqrt statt misqrt.  PS
	Version 6	12.01.1993	ECIMRTMP --> ECIMINMRTMP.
					Anpassung an neues Konzept. JG
   DATE eciminmrtmp   : 910715.910915.920331.921130.930115.930531
H*/

#include<_ec1.h>

single eciminmrtmp( E, p )
list E;
int p;
{
    int a2, a3, b2, c4, c6, r4, h1, h2, h3;

    bind( E );
    bind( p );

    init( a2, a3, b2, c4, c6, r4, h1, h2, h3 );

    a2 = mihom( p, ecimina2( E ) );
    a3 = mihom( p, ecimina3( E ) );
      
    if( icomp( p, 2 ) == 0 )
    {
	if( mshom( 2, misum( 2, a2, a3 ) ) == 0 )
	{
	    /*   nichtzerfallende multiplikative Reduktion modulo 2    */
	    return( 1 );
	}
	else
	{
	    /*   zerfallende multiplikative Reduktion modulo 2         */
	    return( -1 );
	}
    }

    b2 = mihom( p, eciminb2( E ) );

    if( icomp( p, 3 ) == 0 )
    {
	if( mshom( 3, b2 ) == 1 )
	{
	    /*  nichtzerfallende multiplikative Reduktion modulo 3     */
	    return( 1 );
	}
	else
	{
	    /*  zerfallende multiplikative Reduktion modulo 3          */
	    return( -1 );
	}
    }

    /*   Ab hier gilt p >= 5. Dann existiert eine kurze WNF            */
    /*      Y^2 = X^3 - 27 c4 X + 54 c6   mod p.                       */
    /*   Fuer den singulaeren Punkt P = (x, y) gilt mit                */
    /*      F( X, Y) = Y^2 - X^3 + 27 c4 X - 54 c6   mod p             */
    /*   0 = [(df)/(dX)](x, y) = -3 x^2 + 27 c4                        */
    /*     = [(df)/(dY)](x, y) = 2 y ,                                 */
    /*   d.h. x = 3 r4, wobei r4 eine der beiden Quadratwurzeln von    */
    /*   c4 modulo p ist.                                              */

    c4 = mihom( p, eciminc4( E ) );
    c6 = mihom( p, eciminc6( E ) );

    r4 = mpsqrt( p, c4 );

    /*   r4 ist eine der beiden Wurzeln mod p von c4.                  */
    /*   Test, ob r4 die richtige Wurzel ist:                          */
    /*   Dann muss wegen (df)/(dY) = 2 Y = 0 (==> Y = 0) gelten:       */
    /*     (3 r4)^3 - 27 c4 (3 r4) - 54 c6 = 0 mod p                   */
    /*   bzw.                                                          */
    /*     (-3 r4)^3 - 27 c4 (-3 r4) - 54 c6 = 0 mod p,                */
    /*   also                                                          */
    /*     -54 c6 +/- [ (3 r4)^3 - 27 c4 (3 r4) ] = 0 mod p.           */

    h1 = miprod( p, c4, 3 );
    h2 = miprod( p, r4, r4 );
    h2 = midif( p, h2, h1 );
    h2 = miprod( p, h2, 27 );
    h2 = miprod( p, h2, r4 );

    /*   h2 = (3 r4)^3 - 27 c4 (3 r4) = 27 r4 (r4^2 - 3 c4)            */

    h3 = miprod( p, c6, 54 );
    h1 = mineg( p, h3 );

    /*   h1 = -54 c6                                                   */

    h3 = misum( p, h1, h2 );

    if( mihom( p, h3 ) != 0 ) 
    {

	/*   r4 war die falsche Wurzel: Teste -r4                      */
    
        h3 = midif( p, h1, h2 );
        if( mihom( p, h3 ) != 0 )
        {
	    /*   Weder (r4, y)  noch (-r4, y)  liegen auf E: Fehler!   */
            return( ERROR );
        }

	r4 = mineg( p, r4 );
    }
    
    return( ijacsym( r4, p) );
}
