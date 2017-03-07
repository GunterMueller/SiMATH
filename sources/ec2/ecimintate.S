/*M
.SH NAME
ecimintate - elliptic curve with integer coefficients, minimal model, Tate's algorithm
                                        
.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecimintate(E, p, n)  
list E; 
single p, n; 
   
.SH DESCRIPTION
.TP 4
.B E
is a list containing the data of the elliptic curve E/Q, as descripted in the
documentation of 'ecrinit'.   
.TP 4
.B p
is a prime number, dividing the discriminant of the minimal model of the curve E, p < BASIS.
.TP 4
.B n
is the largest integer number, for which p^n divides the discriminant of the minimal model of the elliptic curve E/Q, n < BASIS.
.PP
ecimintate computes with help of  Tate's algorithm
.IP
 the reduction type of the curve E modulo p,
 the exponent of the conductor of E at p,
 the c_p value of E modulo p.
.PP
ecimintate returns a list of three elements (exp rtyp c_p), where
.PP
 exp  is the exponent of the conductor,
 rtyp is the reduction typ according the table below,
 c_p  = #E(Q)/E0(Q), where
      E0(Q) = {P in E(Q) | P = (0 : 1 : 0) mod p}
.PP
or the list (-1) in case of an error occurs.
.IP
 | rtyp   | Kodaira  | Neron  |  c_p-Wert   |
 |--------|----------|--------|-------------|
 | -n < 0 |    In    |   Bn   |  1, 2 or n  |
 |--------|----------|--------|-------------|
 |    1   |    II    |   C1   |      1      |
 |--------|----------|--------|-------------|
 |    2   |   III    |   C2   |      2      |
 |--------|----------|--------|-------------|
 |    3   |    IV    |   C3   |    1 or 3   |
 |--------|----------|--------|-------------|
 |    5   |    I*0   |   C4   |   1, 2, 4   |
 |--------|----------|--------|-------------|
 | 10 + v | I*v, v>0 |  C5,v  |    2 or 4   |
 |--------|----------|--------|-------------|
 |    6   |    IV*   |   C6   |    1 or 3   |
 |--------|----------|--------|-------------|
 |    7   |   III*   |   C7   |      2      |
 |--------|----------|--------|-------------|
 |    8   |    II*   |   C8   |      1      |
 --------------------------------------------

.SH SEE ALSO
 ecrinit
 Literature: J.T.Tate, 
             Algorithm for finding the type of a singular 
             fiber in an elliptic pencil. 
             Modular functions in one variable IV. Antwerp 
             1972. 
             Lect. Notes Math. 476, 33-52 ( 1975 ).
             H.Cohen,
             A Course in Computaional Number Theory 
             Graduate Texts in Mathematics 138, Springer 
             Verlag, p. 400-403. 
M*/
                     
/*H
	Version 1       05.04.1990      Michael Pfeifer
	Version 2	04.12.1990	Fuer p auch int-Werte zugelassen. 
					MP
	Version 3       20.08.1991      '_ARITH3.h' statt 'POL2.h' 
					eingebunden (nur aus Gruenden der
					Einheitl.).  MP
	Version 4       28.08.1991      von 'ARITH3 nach 'EC2.  PS
	Version 5       12.11.1992      zusaetzlich Berechnung des 
					c_p-Werts, 'nofdrts' gestrichen. 
					Josef Gebel
	Version 6	20.11.1992	TATEALG -> ECITATEALG.  PS
	Version 7	20.11.1992	Anpassung an neues Konzept. 
					ECITATEALG -> ECIMINTATEALG.
					(ECITATEALG weiter vorhanden) JG.
	Version 8	11.02.1994	Verbesserung (H. Cohens Version
                                        des Tate-Algorithmus) JG
	Version 9	21.12.1994	Fehler beseitigt: single-Multiplikation
                                        durch 'int'-Multiplikation ersetzt. JG.
        Version 10      10.11.1995      ECIMINTATEALG --> ECIMIMTATE  JG
        Version 11      12.02.1996      Fehler beseitigt. JG.
   DATE ecimintate       : 901120.910715.910915.9203__.921130.930531.9311__.951201.960201
H*/

#include<_ec2.h>

static list transform_eq( a1, a2, a3, a4, a6, r, s, t )
int a1, a2, a3, a4, a6;
single r, s, t;
{
    int b1, b2, b3, b4, b6;

    bind( a1, a2, a3, a4, a6 );
    init( b1, b2, b3, b4, b6 );

    b6 = iprod( a1,  r );
    b6 = isum ( b6,  t );
    b6 = isum ( b6, a3 );
    b6 = iprod( b6,  t );
    b4 = isum ( a2,  r );
    b4 = iprod( b4,  r );
    b4 = isum ( b4, a4 );
    b4 = iprod( b4,  r );
    b6 = idif ( b4, b6 );
    b6 = isum ( b6, a6 );

    b4 = isprod(  r,  3 );
    b4 = isprod( b4,  r );
    b3 = isprod(  s,  t );
    b3 = isprod( b3,  2 );
    b4 = idif  ( b4, b3 );
    b3 = isprod( r, s );
    b3 = isum( b3, t );
    b3 = iprod( b3, a1 );
    b4 = idif ( b4, b3 );
    b3 = isprod( a2, 2 );
    b3 = isprod( b3, r );
    b4 = isum ( b4, b3 );
    b3 = iprod( a3,  s );
    b4 = idif ( b4, b3 );
    b4 = isum ( b4, a4 );

    b3 = isum (  t,  t );
    b2 = iprod( a1,  r );
    b3 = isum ( b3, b2 );
    b3 = isum ( b3, a3 );

    b2 = isprod( s, s );
    b1 = isprod( r, 3 );
    b2 = idif ( b1, b2 );
    b1 = iprod( a1,  s );
    b2 = idif ( b2, b1 );
    b2 = isum ( b2, a2 );

    b1 = isum ( a1, s );
    b1 = isum ( b1, s );

    return( list5( b1, b2, b3, b4, b6 ) );
}

/*c
                findrootsmpd2

	"find roots of modular polynomial with degree 2"
        static list findrootsmpd2( p, a, b, c ) single p, a, b, c;
        L = findrootsmpd2( p, a, b, c );
        findrootsmpd2( p, a, b, c ) ueberprueft, ob die Wurzeln
        des Polynoms P(X) = a * X^2 + b * X + c modulo p in F_p liegen.
        Falls ja, so werden diese berechnet.
        Rueckgabe: ( 0 ),       falls P(X) irreduzibel ueber F_p ist
                   ( 1  x ),    falls P(X) = (X-x)^2 ist
                   ( 2  x  y ), falls P(X) = (X-x) * (X-y), x != y, ist
                   ( - 1 )      sonst.
c*/

static list findrootsmpd2( p, a, b, c )
single p;
int a, b, c;
{
    single u, v, w;

    bind( a, b, c );


    u = mihom( p, a );
    if( !u )
    {
        /***   P(X) ist nicht vom Grad 2   ***/
        return( list1( -1 ) );
    }

    /***   Transformation  a * X^2 + b * X + c --->      ***/
    /***          X^2 + b * a^(-1) * X + c * a^(-1)      ***/
    u = msinv ( p, u );
    v = mihom ( p, b );
    v = miprod( p, v, u );
    w = mihom ( p, c );
    w = miprod( p, w, u );
    
    if( p == 2 )
    {
        if( v )
        {
            /***   P(X) modulo 2 hat zwei verschiedene Nulstellen  ***/
            
            if( w )
            {
                /***   Beide Nullstellen liegen nicht in F_2.      ***/
                
                return( list1( 0 ) );
            }
            /***   Beide Nullstellen liegen   ***/
            /***   in F_2.                    ***/
                
            return( list3( 2, 0, 1 ) );
        }
        /***   P(X) modulo 2 hat eine doppelte Nulstelle      ***/
            
        return( list2( 1, w ) );
    }
    else
    {
        /***   P(X) = ( X - x ) * ( x - y )  mit      ***/
        /***          v      ___          v      ___  ***/
        /***   x = - --- + \/ d  , y = - --- - \/ d   ***/
        /***          2                   2           ***/
        /***               v^2                        ***/
        /***   und   d =  ----- - w                   ***/
        /***                4                         ***/
         
        u = msprod( p, v, v );
        w = msprod( p, w, mshom( p, 4 ) );
        u = msdif( p, u, w );
        /***   u = 4 * d Quadrat <==> d Quadrat   ***/

        if( u )
        {
            /***   P(X) hat 2 verschiedene        ***/
            /***   Nullstellen modulo p           ***/
 
            if( ijacsym( u, p ) == 1 )
            {
                /***   u ist Quadrat in F_p ==>   ***/
                /***   x in F_p und y in F_p      ***/

                u = mipsqrt( p, u );
                w = msdif ( p, u, v );
                u = mssum ( p, u, v );
                u = msneg ( p, u );
                v = msinv ( p, 2 );
                u = msprod( p, u, v );
                w = msprod( p, u, v );

                return( list3( 2, u, w ) );
            }
            /***   x und y liegen nicht in F_p    ***/

            return( list1( 0 ) );
        }
        /***   P(X) hat eine doppelte         ***/
        /***   Nullstelle x1 = - v/2 mod p    ***/
  
        u = msquot( p, v, 2 );
        u = msneg ( p, u );

        return( list2( 1, u ) );
    }
}

list ecimintate( E, p, n )
list E;
single p, n;
{
    single c, q, r, s, t;
    int a1, a2, a3, a4, a6, b2, b4, b6, b8, hi;
    list ( L );

    init( a1, a2, a3, a4, a6, b2, b4, b6, b8, hi );
    init( L );

    bind( E );

    a1 = ecimina1( E );
    a2 = ecimina2( E );
    a3 = ecimina3( E );
    a4 = ecimina4( E );
    a6 = ecimina6( E );
    b2 = eciminb2( E );
    b4 = eciminb4( E );
    b6 = eciminb6( E );

    c = mihom( p, b2 );

    if( c )
    {
        if( p == 2 )
        {
            r = mihom( 2, a3 );
            t = ( mihom( 2, a4 ) + r ) % 2;
        }
        else
        {
            t  = mihom( 3, a3 );
            r  = mihom( 3, b2 );
            r *= mihom( 3, b4 );
            r %= 3;
            if( r )
            {
                r = 3 - r;
                t += mihom( 3, a1 );
                t %= 3;
            }
        }
    }
    else
    {
        if( p == 2 )
        {
            r = mihom( 2, a4 );
            t = mihom( 2, a6 );

            if( r )
            {
                t += mihom( 2, a2 );
                t += mihom( 2, a4 );
                t++;
                t %= 2;
            }
        }
        else
        {
            if( mihom( 3, b2 ) )
            {
                r = mihom( 3, b2 );
                s = mihom( 3, b4 );
                r *= s;
                r %= 3;
            }
            else
            { 
                r = mihom( 3, b6 );
            }
            t = mihom( 3, a3 );
            r %= 3;
            if( r )
            {
                r = 3 - r;
                t += ( r * mihom( 3, a1 ) );
                t %= 3;
            }
        }
    }

    if( r || t )
    {
        L = transform_eq( a1, a2, a3, a4, a6, r, 0, t );

        a1 = lfirst ( L );
        a2 = lsecond( L );
        a3 = lthird ( L );
        a4 = lfourth( L );
        a6 = lfifth ( L );
    }

    hi = eciminc4( E );

    if( mihom( p, hi ) )
    {
        /***   Typ I_n, n > 0  (multiplikative Reduktion)     ***/
        r = mihom( p, a1 );
        s = mihom( p, ineg( a2 ) );

        L = findrootsmpd2( p, 1, r, s );

        if( lfirst( L ) )
        {
            /***   X^2 + a1 X - a2 hat Nullstellen in F_p     ***/

            c = n;
        }
        else
        {
            /***   X^2 + a1 X - a2 keine Nullstellen in F_p   ***/
            
            c = igcd( 2, n );
        }

        r = -n;
        return( list3( 1, r, c ) );
    }

    /***   Ab hier hat E/Q additive Reduktion modulo p        ***/

    q = p * p;

    if( mihom( q, a6 ) )
    {
        /***   Typ II                                         ***/
        return( list3( n, 1, 1 ) );
    }

    b8 = eciminb8( E );
    if( r )
    {
        hi = 3 * r;
        hi = isum ( hi, b2 );
        hi = iprod( hi,  r );
        hi = isum ( hi, isprod( b4, 3 ) );
        hi = iprod( hi,  r );
        hi = isum ( hi, isprod( b6, 3 ) );
        hi = iprod( hi,  r );
        b8 = isum ( hi, b8 );
    }

    q *= p;

    if( mihom( q, b8 ) )
    {
        /***   Typ III                                        ***/
        return( list3( n - 1, 2, 2 ) );
    }

    if( r )
    {
        hi = 4 * r;
        hi = isum ( hi, b2 );
        hi = iprod( hi,  r );
        hi = isum ( hi, isprod( b4, 2 ) );
        hi = iprod( hi,  r );
        b6 = isum ( hi, b6 );
    }

    if( mihom( q, b6 ) )
    {
        /***   Typ IV                                         ***/
        b2 = iquot( a3, p );
        q = p * p;
        b6 = iquot( a6, q );
        b6 = ineg ( b6 );

        L = findrootsmpd2( p, 1, b2, b6 );

        /***   f(X) := X^2 + a3/p * X - a6/p^2                ***/
        /***   c_p = 1 + #{ Nullstellen von f(X) in F_p }     ***/
                        
        c = lfirst( L ) + 1;

        return( list3( n - 2, 3, c ) );
    }

    if( p == 2 )
    {
        s  = mihom(  2, a2 );
        hi = iquot( a6,  4 );
        t  = mihom(  2, hi ) * 2;
    }
    else
    {
        s = 2 * ineg( a1 );
        t = 2 * ineg( a3 );
    }

    if( s || t )
    {
        L = transform_eq( a1, a2, a3, a4, a6, 0, s, t );
	 
        a1 = lfirst ( L );
        a2 = lsecond( L );
        a3 = lthird ( L );
        a4 = lfourth( L );
        a6 = lfifth ( L );
    }
    {
        /***   Hier gilt: p | a2, p^2 | a4, p^3 | a6          ***/

        pol   P, Q;
        single a2m, a4m, a6m;

        init( P, Q );
    
        b2 = iquot( a2, p );
        b4 = iquot( a4, p * p );
        b6 = iquot( a6, q );

        a2m = mihom( p, b2 );
        a4m = mihom( p, b4 );
        a6m = mihom( p, b6 );

        /***   c := Anzahl der verschiedenen Nullstellen von  ***/
        /***   f(X) :=  X^3 + b2 X^2 + b4 X + b6 modulo p     ***/

        P = _0;

        if( a6m ) 
        {
            P = lcomp2( 0, a6m, P );
        }
        if( a4m ) 
        {
            P = lcomp2( 1, a4m, P );
        }
        if( a2m ) 
        {
            P = lcomp2( 2, a2m, P );
        }
        P = lcomp2( 3, 1, P );
  
        Q = upmsgsd( p, P );
        L = upmscfacts( p, P );
        c = lfirst( Q );

        if( c == 3 )
        {
            /***   Typ I*0                                    ***/
            /***   c_p = 1 + #{ Nullstellen von f(X) in F_p } ***/

            r = llength( L );

            if( r == 2 )
            {
                /***   f(X) irreduzibel ueber F_p  ==>        ***/
                /***   f(X) hat keine Nullstelle in F_p.      ***/
                c = 1;
            }
            else if( r == 4 )
            {
                /***   f(X) besteht aus zwei ueber F_p        ***/
                /***   irreduziblen Faktoren  ==>             ***/
                /***   f(X) hat 1 Nullstelle in F_p.          ***/
                c = 2;
            }
            else   /***   r == 6   ***/
            {
                /***   f(X) besteht aus drei ueber F_p        ***/
                /***   irreduziblen Faktoren  ==>             ***/
                /***   f(X) hat 3 Nullstellen in F_p.         ***/
                c = 4;
            }
            return( list3( n - 4, 5, c ) );
        }

        /***   f(X) hat eine mehrfache Nullstelle ==>         ***/
        /***   f(X) = (X + a)^ 3     oder                     ***/
        /***   f(X) = (X + a)^2 * (X + b) mit b != a mod p    ***/

        if( lsecond( L ) == 1 )
        {
            /***  L = ( X + b, 1, X + a, 2 )              ***/
            /***  Darstellung von X + a: ( 1  1  0  a )   ***/

            P = lthird ( L );
            r = lfourth( P );
        }
        else
        {
            /***  L = ( X+a  3 ) oder L = ( X+a  2  X+b  1 )  ***/
            /***  Darstellung von X+a: ( 1  1 ), falls a = 0; ***/
            /*** ( 1  1  0  a ) sonst.                        ***/

            P = lfirst( L );
            if( llength( P ) == 2 )
            {
                r = 0;
            }
            else
            {
                r = ( p - lfourth( P ) ) % p;
            }
        }

        if( r )
        {
            r *= p;

            L = transform_eq( a1, a2, a3, a4, a6, r, 0, 0 );
     
            a1 = lfirst ( L );
            a2 = lsecond( L );
            a3 = lthird ( L );
            a4 = lfourth( L );
            a6 = lfifth ( L );
        }

        if( c == 2 )
        {
            /***   Typ I*v  ( v > 0 )                         ***/
            /***   f(X) hat eine doppete Nullstelle           ***/
            /***   Berechnung von v                           ***/
     
            single v;

            v = 1;
            q = p * p;

            while( v < n )
            {
                hi = iprod( q, q );

                b2 = iquot( a3,  q );
                b6 = iquot( a6, hi );
                b6 = ineg ( b6 );

                /***   f(X) = X^2 + a3/q * X - a6/q^2          ***/

                L = findrootsmpd2( p, 1, b2, b6 );

                c = lfirst( L );
 
                if( c == 1 )
                {
                    /***   f(X) hat eine doppelte Nulstelle    ***/
                    t = lsecond( L );
                }
                else       /***   p == 3   ***/
                {
                    /***   f(X) hat 2 verschiedene Nulstellen  ***/
                    /***      ==>  Berchnung von v beendet     ***/
                    /***   c_p = 2 + #{ Nullst. von f in F_p } ***/
                        
                    c += 2;
                    r = n - 4 - v;
                    s = 10 + v;

                    return( list3( r, s, c ) );
                }

                /***   f(X) = ( X - c )^2                     ***/

                if( t )
                {
                    t *= q;
                    L = transform_eq( a1, a2, a3, a4, a6, 0, 0, t );
        
                    a1 = lfirst ( L );
                    a2 = lsecond( L );
                    a3 = lthird ( L );
                    a4 = lfourth( L );
                    a6 = lfifth ( L );
                }
  
                v++;

                b2 = iquot( a2,  p );
                hi = iprod(  p,  q );
                b4 = iquot( a4, hi );
                hi = iprod( hi,  q );
                b6 = iquot( a6, hi );

                /***   f(X) = (a2 * X^2 + a4/q * X + a6/q^2)/p ***/

                L = findrootsmpd2( p, b2, b4, b6 );
                c = lfirst( L );

                if( c == -1 )
                {
                    /***   f(X) nicht vom Grad 2               ***/
                    return( list1( 1 ) );
                }
                else if( c == 1 )
                {
                    /***   f(X) hat 1 doppelte Nulstelle       ***/
                    r = lsecond( L );
                }
                else 
                {
                    /***   f(X) hat 2 verschiedene Nulstellen  ***/
                    /***      ==>  Berchnung von v beendet     ***/
                    /***   c_p = 2 + #{ Nullst. von f in F_p } ***/
                        
                    c += 2;
                    r = n - 4 - v;
                    s = 10 + v;

                    return( list3( r, s, c ) );
                }

                if( r )
                {
                    r *= q;
                    L = transform_eq( a1, a2, a3, a4, a6, r, 0, 0 );
        
                    a1 = lfirst ( L );
                    a2 = lsecond( L );
                    a3 = lthird ( L );
                    a4 = lfourth( L );
                    a6 = lfifth ( L );
                }
  
                v++;
                q *= p;

            }   /***   Ende der while-Schleife                ***/

            return( list1( 2 ) );
        }

        /***   f(X) hat eine dreifache Nullstelle             ***/
        /***   Es gilt: p^2 | a3, p^4 | a6                    ***/

        q = p * p;
        b2 = iquot( a3, q ); 
        r = q * q;
        b6 = iquot( a6, r ); 
        b6 = ineg ( b6 ); 

        /***   f(X) = X^2 + a3/p^2 * X - a6/p^4               ***/

        L = findrootsmpd2( p, 1, b2, b6 );
        c = lfirst( L );

        if( c == 1 )
        {
            /***   f(X) hat eine doppelte Nullstelle          ***/

            t = lsecond( L );
        }
        else
        {
            /***   Typ IV*                                    ***/
            /***   c_p = 1 + #{ Nullstellen von f in F_p }    ***/
                        
            c++;
         
            return( list3( n - 6, 6, c ) );
        }

        if( t )
        {
            t *= q;
            L = transform_eq( a1, a2, a3, a4, a6, 0, 0, t );
 
            a1 = lfirst ( L );
            a2 = lsecond( L );
            a3 = lthird ( L );
            a4 = lfourth( L );
            a6 = lfifth ( L );
        }

        s = mihom( r, a4 );
        if( s )
        {
            /***   Typ III*                                   ***/
            /***   p^4 teilt nicht a4                         ***/
    
            t = n - 7;
            return( list3( t, 7, 2 ) );
        }

        hi = iprod( r, q );
        if( mihom( hi, a6 ) )
        {
            /***   Typ II*                                    ***/
            /***   p^6 teilt nicht a6                         ***/

            t = n - 8;
            return( list3( t, 8, 1 ) );
        }

        /***  p^i teilt a_i fuer alle i = 1, 2, 3, 4, 6       ***/
        /***  Gleichung fuer E/Q war nicht minimal modulo p   ***/
        /***  Widerspruch zur Voraussetzung E global minimal  ***/

        return( list1( 3 ) );
    }
}
