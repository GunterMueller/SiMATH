/*M
.SH NAME
ecqnftoeci - elliptic curve over quadratic number field to elliptic curve with integral coefficients

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecqnftoeci( D, L )  
int D; 
list L;
  
.SH DESCRIPTION
.TP 4
.B D
is an integer number, D != 0 or 1, D square-free.   
.TP 4
.B L
= (a1, a2, a3, a4, a6), is a list, containing the coefficients of an elliptic curve, say E, over Q(D^(1/2)).
.PP
ecqnftoeci returns a list (a1', a2', a3', a4', a6'), where the ai' are elements of the ring of integers of Q(D^(1/2)) and the coefficients of an elliptic curve which is birationaly isomorphic to the curve E.
  
M*/
                 
/*H
	Version 1       14.06.1993      Josef Gebel
   DATE ecqnftoeci    : 931130
H*/

#include<_ec2.h>

static int getdencoeff(nfel,single,single);

list ecqnftoeci( D, L ) 
int D;
list L;
{
    single flag;
    nfel a1, a2, a3, a4, a6;
    int N, h;

    bind( D, L );

    init( a1, a2, a3, a4, a6 );
    init( N );

    if( mshom( 4, D ) == 1 )
    {
	flag = 1;
    }
    else
    {
	flag = 0;
    }

    N = 1;

    a1 = lfirst ( L );
    a2 = lsecond( L );
    a3 = lthird ( L );
    a4 = lfourth( L );
    a6 = lfifth ( L );
   
    if( !isqnfiel( D, a1 ) )
    {
        h = getdencoeff( a1, 1, flag );
	N = ilcm( N, h );
    }
    
    if( !isqnfiel( D, a2 ) )
    {
        h = getdencoeff( a2, 2, flag );
	N = ilcm( N, h );
    }
    
    if( !isqnfiel( D, a3 ) )
    {
        h = getdencoeff( a3, 3, flag );
	N = ilcm( N, h );
    }
   
    if( !isqnfiel( D, a4 ) )
    {
        h = getdencoeff( a4, 4, flag );
	N = ilcm( N, h );
    }
    
    if( !isqnfiel( D, a6 ) )
    {
        h = getdencoeff( a6, 6, flag );
	N = ilcm( N, h );
    }

    a1 = qnfiprod( D, a1, N );

    h  = iprod( N, N );      /***   h = N^2    ***/
    a2 = qnfiprod( D, a2, h );

    h  = iprod( h, N );      /***   h = N^3    ***/
    a3 = qnfiprod( D, a3, h );

    if( a4 )
    {
	N  = iprod( h, N );      /***   N = N^4    ***/
        a4 = qnfiprod( D, a4, N );
    }

    if( a6 )
    {
	h  = iprod( h, h );      /***   h = N^6    ***/
        a6 = qnfiprod( D, a6, h );
    }

    return( list5( a1, a2, a3, a4, a6 ) );
}

/*c
		    getdencoeff( a, i, f )

	"get denominator of coefficient"
	Quellbibliothek: srclib.ec2
	Include-Datei:   _ec2.h
	static int getdencoeff( a, i, f ) nfel a; single i, f;
	N = getdencoeff( a, i, f );
	a = ai ist der i-te Koeffizient einer elliptischen Kurve
	E ueber dem quadratischen Zahlkoerper Q(D^(1/2)).
	f = 1, falls D == 1 mod 4; 0 sonst.
	getdencoeff liefert eine naturliche Zahl N, fuer die gilt:
	    a * N^i in O_D, O_D = Ganzheitsring von Q(D^(1/2)),
	getdencoeff ist static zu ecqnftoeci. 
c*/

static int getdencoeff( a, i, f )
nfel a;
single i, f;
{
    int N;

    init( N );
    bind( a );

    N = lfirst( a );

    if( f )
    {
	if( lsecond( a ) )
	{
            if( mshom( 2, N ) == 0 )
	    {
		if( mshom( 2, lthird( a ) ) &&  mshom( 2, lfourth( a ) ) )
		{
		    N = iquot( N, 2 );
		}
	    }
	}
    }
    if( ( i != 1 ) && ( N != 1 ) )
    {
	list L;
	int p;
	single e;

	init( L, p );

	L = ifact( N );
	L = ifel ( L );
	N = 1;

	while( L != _0 )
	{
	    e = ( lsecond( L ) + i - 1 ) / i;
	    p = lfirst ( L );
           
            while( e )
	    {
		e--;
		N = iprod( N, p );
	    }

	    L = lred2( L );
	}
    }
    return( N );
}
