/*M
.SH NAME
ecrcharpol - elliptic curve over the rational numbers, characteristic polynomial of regulator matrix
.SH SYNOPSIS
.nf
#include<_ec2.h>

pol ecrcharpol(E)  
list E;
  
.SH DESCRIPTION
.TP 4
.B E
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.     
.PP
ecrcharpol computes the characteristic polynomial X_A of the regulator matrix A of E (s. ecrregmat), and returns
 0,     if rank( E/Q ) = 0,  
 X_A,   if rank( E/Q ) > 0 and X_A successfully computed, 
 ( 0 )  otherwise.  
 
.SH SEE ALSO
 ecrinit
 ecrregmat

M*/
        
/*H
	Version 1	21.02.1994	Josef Gebel
   DATE ecrcharpol    : 941201
H*/

#include <_ec2.h>

static matrix makechpolmat(matrix,single);
static pol flpolprods(pol,pol);
static pol flpolnegs(pol);
static pol flpolsums(pol,pol,single);
static pol detmapolfl(matrix,single);

/*******************************************************************/
/***              s t a t i c   f u n c t i o n s                ***/
/***                    ( B e g i n n i n g )                    ***/
/*******************************************************************/

/*c
       static matrix makechpolmat( M, n ) matrix M; single n;
       A = makechpolmat( M, n );
       M is an (n x n) - matrix of floatings.
       Return: Matrix of the characteristic polynomial A = I * x - M,
               where I = n-dimensional unit matrix.
c*/

static matrix makechpolmat( M, n )
matrix M;
single n;
{
    single   i, j;
    floating f;
    pol      p;
    list     K, L;
    matrix   A, B;

    bind( M );

    init( f );
    init( p );
    init( K, L );
    init( A, B );

    B = M;
    A = maconszero( n, n );

    for( i = 1; i <= n; i++ )
    {
        L = lfirst( B );
        B = lred( B );

        for( j = 1; j <= n; j++ )
        {
            f = lfirst( L );
            L = lred( L );
            if( i == j )
            {
                /***   f is on the diagonale  ==> a_ii --> X - a_ii ***/

		if(f) 
		{
			f = flneg(f);
                	p = list4( 1, itofl( 1 ), 0, f );
		}
		else    p = list2( 1, itofl( 1 ) );
            }
            else if( f )
            {
		f = flneg(f);
                p = list2( 0, f );
            }
            else
            {
                p = 0;
            }
            masetel( A, i, j, p );
        }
    }       
    return( A );
}
/***  End of makechpolmat ************************************************/

/*c
       static pol flpolprods( p, q ) pol p, q;
       r = flpolprods( p, q );
       p, q are polynomials of floatings.
       Return: r = p * q
c*/

static pol flpolprods( p, q )
pol p, q;
{
    bind( p, q );

    if( p && q )
    {
        single   i;
        pol      r, s, t;
        floating e, f, g, h;
    
        init( r, s, t );
        init( e, f, g, h );
   
        if( lfirst( q ) )
        {
            e = lsecond( q );
            f = lfourth( q );
        }
        else
        {
            e = 0;
            f = lsecond( q );
        }
    
        r = p;
        s = _0;
        t = _0;
    
        while( r != _0 )
        {
            i = lfirst ( r );
            g = lsecond( r );
            h = flprod( g, f );
            s = lcomp2( h, i, s );
            if( e )
            {
                h = flprod( g, e );
                t = lcomp2( h, i + 1, t );
            }
            r = lred2( r );
        }
        s = linv( s );
    
        if( e )
        {
            t = lcomp2( 0, 0, t );
            t = linv( t );
            s = flpolsums( s, t, 0 );
        }
     
        return( s );   
    }
    return( 0 );   
}
/***  End of flpolprods **************************************************/

/*c
       static pol flpolnegs( p ) pol p;
       q = flpolnegs( p );
       p is a polynomial of floatings.
       Return: q = -p
c*/

static pol flpolnegs( p )
pol p;
{
    bind( p );

    if( p )
    {
        single   i;
        pol      q, r;
        floating f;

        init( q, r );
        init( f );

        q = p;
        r = _0;
  
        while( q != _0 )
        {
            i = lfirst ( q );
            f = lsecond( q );
            r = lcomp2( flneg( f ), i, r );
            q = lred2( q );
        }
        return( linv( r ) );
    }
    return( 0 );
}
/***  End of flpolnegs ***************************************************/

/*c
       static pol flpolsums( p, q, modus ) pol p, q; single modus;
       r = flpolsums( p, q, modus );
       p, q are polynomials of floatings.
       Return: r = p + q, if modus = 0,
               r = p - q  otherwise.
c*/

static pol flpolsums( p, q, modus )
pol p, q;
single modus;
{

    bind( p, q );

    if( p && q )
    {
        /***   p und q sind beide nicht das Nullpolynom  ***/
        single   i, j;
        pol      r, s, t;
        floating f, g;
    
        init( r, s, t );
        init( f, g );
    
        r = p;
        s = q;
        t = _0;
    
        i = lfirst( p );
        j = lfirst( q );
    
        while( i > j )
        { 
            f = lsecond( r );
            t = lcomp2( f, i, t );
            i--;
            r = lred2( r );
        }
    
        while( j > i )
        { 
            f = lsecond( s );
            if( modus )
            {
                f = flneg( f );
            }
            t = lcomp2( f, j, t );
            j--;
            s = lred2( s );
        }
    
        while( i >= 0 )
        {
            f = lsecond( r );
            g = lsecond( s );

            if( modus )
            {
                f = fldif( f, g );
            }
            else
            {
                f = flsum( f, g );
            }

            t = lcomp2( f, i, t );
            i--;
            r = lred2( r );
            s = lred2( s );
        }

        t = linv( t );
    
        while( 1 )
        {
            if( lsecond( t ) )
            {
                break;
            }
            else if( lfirst( t ) )
            {
                t = lred2( t );
            }
            else
            {
                return( 0 );
            }
        }
    
        return( t );
    }
    else if( p )
    {
        /***   q = 0   ***/
        return( p );
    }
    else if( modus )
    {
        /***   p = 0  und  modus = 1  ***/
        return( flpolnegs( q ) );
    }
    /***   p = 0  und  modus = 0  ***/
    return( q );
}
/***  End of flpolsums ***************************************************/

/*c
       static pol detmapolfl( M, n ) matrix M; single n;
       p = detmapolfl( M, n );
       M is (n x n) - matrix of polynomials of floatings (of degree 1
       on the diagonale, of degree 0 otherwise).
       Return: p = det( M ).
c*/

static pol detmapolfl( M, n )
matrix M;
single n;
{
    single i, j;
    pol    p, q, r, s;
    matrix N;

    bind( M );
        
    init( p, q, r, s );
    init( N );

    if( n == 1 )
    {
        return( lfirst( lfirst( M ) ) );
    }
    if( n == 2 )
    {
        p = maselel( M, 1, 1 );
        q = maselel( M, 2, 2 );
        p = flpolprods( p, q );

        r = maselel( M, 1, 2 );
        s = maselel( M, 2, 1 );
        r = flpolprods( r, s );

        p = flpolsums( p, r, 1 );

        return( p );
    }

    i = 1;
    p = 0;

    while( i <= n )
    {
        N = lcopy( M );
        q = madel1rc( &N, 1, i );
        r = detmapolfl( N, n - 1 );
        
        i++;
        q = flpolprods( r, q );
        p = flpolsums( p, q, i % 2 );
    }
    return( p );
}
/***  End of detmapolfl **************************************************/

/*******************************************************************/
/***              s t a t i c   f u n c t i o n s                ***/
/***                          ( E n d )                          ***/
/*******************************************************************/

pol ecrcharpol( E )
list E;
{
    single r;

    bind( E );

    if( r = ecrrank( E ) )
    {
        /***   Rang( E/Q ) > 0   ***/
        matrix A, B;
        pol chi;

        init( A, B );
        init( chi );

        A = ecrregmat( E );
        if( !A )
        {
            return( list1( 0 ) );
        }
        B = makechpolmat( A, r );
  
        chi = detmapolfl( B, r );

	chi = ptodp(1,chi);

        return( chi );
    }
    return( 0 );
}
