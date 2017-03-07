/*M
.SH NAME
ecqnflcond - elliptic curve over quadratic number field, local conductor

.SH SYNOPSIS
.nf
#include<_ec2.h>

list ecqnflcond(E, p)
list E;
int p;

.SH DESCRIPTION
If the conductor of the elliptic curve E is not yet computed,
ecqnflcond() computes the local conductor Np (together with its
factorization into prime ideals, the c_P-values, and the Neron- 
and Kodaira-symbols). Np is the maximum of the ideals I which 
divide the conductor and satisfies gcd(I,(p)) != (1).
.PP
ecqnflcond() returns (-1), if something went wrong. Otherwise, it
returns a list (Np FNp). Np is the local conductor, which is
represented as an ideal (see qnfidprod). If E has good reduction at
all primes which lie over p, then FNp is the empty list.
Otherwise, FNp is a list of the form
.PP
( P  e  pi  z  r  c ) list P; single e, z, r, c; nfel pi; \   \   \  
(or ( P1  e1  pi1  z1  r1  c1  P2  e2  pi2  z2  r2  c2 ),
            if (p) = P1 * P2 with P1 | Np and P2 | Np.)
.PP
P is a prime ideal which lies over p and divides Np with exponent e.
pi is the corresponding prime element, z is 0, 1 or 2, if the prime ideal P 
divides an inert, ramified or split prime number in Q. r is the 
reductiontype of E mod p and c is the c_P-value .
.PP 
The value of E is changed.

.PP
.TP 4
.B E
is a list containing all information about the elliptic curve defined over the
quadratic number field K (see 'ecqnfinit').
.TP 4
.B p
is a prime number.

.SH SEE ALSO
ecqnfcond, ecqnftatealg.
M*/
/*H
	Version 1       21.07.1993      Josef Gebel und Claude Grasser
	Version 2       21.07.1993      Fall `Diskriminante = Einheit im
                                        Zahlkoerper" abgefangen JG
	Version 3       21.03.1996      Fehler beseitigt. JG
   DATE: ecqnflcond   :	941201.9512__.960501
H*/	

#include <_ec2.h>

static list ecqnfieltv(int,list);
static list cPvalue(int,list,nfel,list,nfel,single,single);
static issquaremodP(int,list,nfel,single,nfel);
static list qnfpol3nr(int,list,nfel,single,nfel,nfel,nfel);

list ecqnflcond( E, p )
list E;
int p;
{
    single  n, z, h, k;
    int     D, q;
    list    Np, P, FDE, FNp, L, LC, LTV;
    nfel    DE, pi;

    init( D, q );
    init( Np, P, FDE, FNp, L, LC, LTV );
    init( DE, pi );

    bind( E, p );

    D = ecqnfflddisc( E );

    Np = qnfidone( D );
    FNp = _0;

    if( lsecond( lfourth( E ) ) == _0 )
    {
	/*   Der Fuehrer ist noch nicht berechnet   */

	/*   Berechnung eines Modells von E/K mit Koeffizienten  */
	/*   a_i im Ganzheitsring von K, der dazugehoerigen      */
	/*   Tate'schen Werte b2, b4, b6, b8, c4 und der         */
	/*   Diskriminante DE von E/K mit deren Faktorisierung   */
	/*   in Primideale FDE.                                  */

	LC  = ecqnftoeci( D, lfirst( lfirst( E ) ) );
	L   = ecqnfieltv( D, LC );
	LTV = lfirst ( L );    /*   Tate'sche Werte b_i und c_j  */
	DE  = lsecond( L );    /*   Diskriminante DE von E/K     */
	FDE = qnfpifact( D, DE );   

        if( lfirst( FDE ) == 1 )
        {
            return( list2( Np, FNp ) );
        }
        while( FDE != _0 )
        {
	    /*   Das Primideal P teilt DE genau n-mal            */
            P  = lfirst ( FDE );   /*   Primideal                */
            n  = lsecond( FDE );   /*   Potenz des Primideals    */
	    pi = lthird ( FDE );   /*   Ortsuniformisierende     */
	    z  = lfourth( FDE );   /*   Zerlegungsgesetz         */
	    if( z )
	    {
		/*  p zerlegt / verzweigt: P = ( 1  p*s  x  s )  */
		q = lsecond( P );
		q = isquot( q, lfourth( P ) );
	    }
	    else
	    {
		/*  p traege: P = ( p  s  x  s )                 */
		q = lfirst( P );
	    }
	    /*   P setzt die Primzahl p auf K fort.              */

            k = icomp( p, q );
         
            if( k < 0 )
            {
                /***   q > p ==> fertig!   ***/
                break;
            }
            else if( !k )
            {
                /*   p = q: P setzt p fort                       */

	        if( ( p < 5 ) || ( n > 12 ) )
	        {
                    L = ecqnftatealg( D, LC, LTV, P, pi, z, n );
	        }
	        else
	        {
                    L = cPvalue( D, LTV, DE, P, pi, z, n );
	        }
    
                h = llength( L );

	        if( h == 5 )
	        {
		    /*   E/K modulo P nicht minimal: L enthaelt  */
		    /*   Koeffizienten a1',...,a6' eines Modells */
		    /*   fuer E/K, dessen Diskriminante DE'      */
		    /*   eines um 12 geringeren vP-Wert hat.     */
		    /*   Wiederhole den Tate-Algorithmus so lan- */
		    /*   ge, bis die Diskriminante minimal ist.  */

		    list L1, LC1, LTV1, FDE1;
		    nfel DE1;

		    init(  L1, LC1, LTV1, FDE1, DE1 );
    
		    LC1 = L;   
		    /*   L enthaelt die neuen Koeffizienten von E/K  */
    
		    while( h == 5 )
		    {
	                LC1  = ecqnftoeci( D, LC1 );
	                L1   = ecqnfieltv( D, LC1 );
	                LTV1 = lfirst ( L1 ); 
	                DE1  = lsecond( L1 );
	                FDE1 = qnfpifact( D, DE1 );   
		        n = 0;

		        while( FDE1 != _0 )
		        {
                            L1 = lfirst( FDE1 );
			    if( !qnfidcomp( D, P, L1 ) )
			    {
			        if( !qnfelcomp( D, pi, lthird( FDE1 ) ) )
			        {
				    /*   n = Potenz von P in DE1     */
				    n = lsecond( FDE1 );
				    break;
			        }
			    }
			    FDE1 = lred4( FDE1 );
		        }
		        if( n )
		        {
                            L1 = ecqnftatealg( D, LC1, LTV1, P, pi, z, n );
    
			    h = llength( L1 );
    
			    if( h == 5 )
			    {
			        /*   Neues Modell war immer noch     */
			        /*   nicht minimal modulo P ==>      */
			        /*   Wiederhole Tatealgorithmus      */
			        /*   mit den neuen Koeffizienten     */
			        /*   aus L1.                         */
			        LC1 = L1;
		            }
			    else
			    {
			        L = lcopy( L1 );
			    }
		        }
		        else
		        {
			    /*   P teilt nicht die Minimal-          */
			    /*   diskriminante von E/K (bzgl. P)     */
			    /*   E/K hat gute Reduktion mod P.       */
			    h = 0;
		        }	
	            }
	        }
	        /*   Hier ist h != 5:                                */
	        /*       h = 0: E/K hat gute Reduktion modulo P,     */
	        /*           1: Fehler im Tate-Algorithmus oder      */
	        /*           3: E/K hat schlechte Reduktion mod P    */
	        /*              und Tate-Algorithmus erfolgreich.    */
            
	        if( h == 1 )
                {
	            /*    Fehler im Programm 'ecqnftatealg'  */
                    return( list1( -1 ) );
                }
	        if( h )
	        {
		    /*   h = 3 <==> Tate-Algorithmus erfolgreich     */
		    /*   und E/K hat schlechte Reduktion mod P.      */

                    h = lfirst ( L );
                    n = lsecond( L );
                    k = lthird ( L );
   
	            Np  = qnfidprod( D, Np, qnfidexp( D, P, h ) );
                    FNp = lcomp6( k, n, z, pi, h, P, FNp );
    
	        }
            }
	    FDE = lred4( FDE );
        }
    }
    else
    {
	FDE = ecqnfpifcond( E );   
	LC  = ecqnflistcP( E );   
        LC  = lred( LC );
	LTV = ecqnflistrt( E );   

        if( lfirst( FDE ) == 1 )
        {
            return( list2( Np, FNp ) );
        }
        while( FDE != _0 )
        {
            P = lfirst ( FDE );  /*   Primideal                */
	    z = lfourth( FDE );  /*   Zerlegungsgesetz         */

	    if( z )
	    {
		/*  p zerlegt / verzweigt: P = ( 1  p*s  x  s )  */
		q = lsecond( P );
		q = isquot( q, lfourth( P ) );
	    }
	    else
	    {
		/*  p traege: P = ( p  s  x  s )                 */
		q = lfirst( P );
	    }
            k = icomp( p, q );
           
            if( k < 0 )
            {
                /***   q > p ==> fertig!   ***/
                break;
            }
            else if( !k )
            {
                /***   q == p  ***/
      
                h  = lsecond( FDE );
	        pi = lthird ( FDE );
                n  = lsecond( LTV );
                k  = lfirst ( LC  );

	        Np  = qnfidprod( D, Np, qnfidexp( D, P, h ) );
                FNp = lcomp6( k, n, z, pi, h, P, FNp );
            }
   
            FDE = lred4( FDE );
            if( FDE == _0 ) 
            {
                break;
            }
            LTV = lred2( LTV );

            LC = lred( LC );
        }
    }
    
    FNp = linv( FNp );
    return( list2( Np, FNp ) );
}   


/*c
		    ecqnfieltv( D, LC )

	"elliptic curve over quadratic number field, integral element,
	 Tate's values"
	static list ecqnfieltv( D, LC )  int D; list LC;
	LTV = ecqnfieltv( D, LC );
	ecqnfieltv ist static zu ecqnfcond.
	Dabei ist D aus Z\{0,1} quadratfrei und
	     LC = ( a1  a2  a3  a4  a6 )  nfel a1, a2, a3, a4, a6;
	eine Liste mit den (in K = Q(D^(1/2))) ganzen Koeffizienten der
	elliptischen Kurve E/K. 
	ecqnfieltv berechnet die Tate'schen Groessen b2, b4, b6, b8, 
	c4 , c6 und die Diskriminante DE der elliptischen Kurve E/K.
	Rueckgabe: ( ( b2  b4  b6  b8  c4  c6 )  DE ).
c*/
/*cS
        ecqnfieltv ruft auf: qnfexp, qnfiprod, qnfprod, qnfsquare, 
		qnfsum
	Macros: lfifth, lfirst, lfourth, list2, list6, lsecond, lthird,
		qnfdif
Sc*/

static list ecqnfieltv( D, LC ) 
int  D; 
list LC;
{
    nfel a1, a2, a3, a4, a6, b2, b4, b6, b8, c4, c6, DE, h;
 
    bind( D, LC );
    init( a1, a2, a3, a4, a6, b2, b4, b6, b8, c4, c6, DE, h );

    a1 = lfirst ( LC );
    a2 = lsecond( LC );
    a3 = lthird ( LC );
    a4 = lfourth( LC );
    a6 = lfifth ( LC );

    b2 = qnfsquare( D, a1 );
    h  = qnfiprod ( D, a2, 4 );
    b2 = qnfsum   ( D, b2, h );

    b4 = qnfprod ( D, a1, a3 );
    h  = qnfiprod( D, a4,  2 );
    b4 = qnfsum  ( D, b4,  h );

    b6 = qnfsquare( D, a3 );
    h  = qnfiprod ( D, a6, 4 );
    b6 = qnfsum   ( D, b6, h );
    
    b8 = qnfsquare( D, a1 );
    b8 = qnfprod  ( D, b8, a6 );
    h  = qnfprod  ( D, a1, a3 );
    h  = qnfprod  ( D,  h, a4 );
    b8 = qnfdif   ( D, b8,  h );
    h  = qnfprod  ( D, a2, a6 );
    h  = qnfiprod ( D,  h,  4 );
    b8 = qnfsum   ( D, b8,  h );
    h  = qnfsquare( D, a3 );
    h  = qnfprod  ( D,  h, a2 );
    b8 = qnfsum   ( D, b8,  h );
    h  = qnfsquare( D, a4 );
    b8 = qnfdif   ( D, b8,  h );
    
    c4 = qnfiprod ( D, b4, 24 );
    h  = qnfsquare( D, b2 );
    c4 = qnfdif   ( D, h, c4 );

    c6 = qnfiprod ( D, b4,  36 );
    h  = qnfsquare( D, b2 );
    c6 = qnfdif   ( D, c6,   h );
    c6 = qnfprod  ( D, c6,  b2 );
    h  = qnfiprod ( D, b6, 216 );
    c6 = qnfdif   ( D, c6,   h );
    
    DE = qnfiprod ( D, b4,  9 );
    DE = qnfprod  ( D, b6, DE );
    h  = qnfprod  ( D, b2, b8 );
    DE = qnfdif   ( D, DE,  h );
    DE = qnfprod  ( D, DE, b2 );
    h  = qnfsquare( D, b6 );
    h  = qnfiprod ( D,  h, 27 );
    DE = qnfdif   ( D, DE,  h );
    h  = qnfexp   ( D, b4,  3 );
    h  = qnfiprod ( D,  h,  8 );
    DE = qnfdif   ( D, DE,  h );

    return( list2( list6( b2, b4, b6, b8, c4, c6 ), DE ) );
}


/*c
			cPvalue( D, LTV, DE, P, pi, z, n )

	"elliptic curve over quadratic number field, c_P-value"
	static list cPvalue( D, LTV, DE, P, pi, z, n ) 
	     int D; list LTV, P; nfel DE, pi; single z, n;
	L = cPvalue( D, LT, P, pi, z, n );
	cPvalue ist static zu ecqnfcond.
	Es muss gelten:
	  - D ist aus Z\{0,1} quadratfrei,
          - LTV ist eine Liste mit den Tate'schen Groessen b2,
	    b4, b6, b8, c4 und c6 der elliptischen Kurve E/K,
	    K = Q(D^(1/2)) (siehe ecqnfinit).
          - DE ist die Diskriminante von E/K,
          - P ist ein Primideal, das eine Primzahl p > 3 auf 
	    K = Q(D^(1/2)) fortsezt. Zur Darstellung von Primidealen
	    s. Dokumentation von 'qnfielpifact.S'.
	  - pi ist eine zu P gehoerige Ortsuniformisierende
	  - z gibt das Zerlegungsgesetz von p in K angibt. z = 1, 2 
	    oder 3, falls p traege, verzweigt bzw. zerlegt ist.
          - P^n ist die hoechste P-Potenz, die in DE aufgeht.
	Rueckgabe:
	  - bei fehlerhaftem Lauf die einelementige Liste ( -1 )
          - bei erfolgreichem Lauf die dreielementige Liste 
	          ( exp  rtyp  cP )  single exp, rtyp, cP;
	    mit dem Exponenten 'exp' des (lokalen) Fuehrers, 
            dem Reduktionstyp 'rtyp' gemaess der Tabelle in der
	    Dokumentation zu ecqnftatealg und dem c_p-Wert 
	    cP = #[E(K)/E_0(K)] (s.a. ecqnftatealg).
c*/
/*cS
        cPvalue ruft auf: ecqnfacc4, ecqnfacc6, ecqnfjinv, 
		issquaremodP, qnfiprod, qnfpihom, qnfpiord, 
		qnfpol3nr, qnfexp, qnfprod, qnfsquare, qnfsum
	Macros: ecqnfdmod4, ecqnfflddisc, lfirst, list1, list3, lsecond,
		lthird, m4hom, qnfquot,
Sc*/

static list cPvalue( D, LTV, DE, P, pi, z, n )
int    D;
list   LTV, P;
nfel   DE, pi;
single z, n;
{
    single exp, rtyp, c_p, k;
    nfel   h1, h2, A4, A6;
    int    m;

    bind( D, LTV, DE, P, pi );
    
    init( h1, h2, A4, A6, m );

    h1 = lfifth( LTV );
    k = qnfpiord( D, P, pi, z, h1 );
    
    A4 = qnfiprod( D, h1, -27 );

    h2 = lsixth( LTV );
    A6 = qnfiprod( D, h2, -54 );

    if( !( k % 4 ) && ( k != ERROR ) )
    {
	/*   Falls E/K nicht minimal bzgl. P ist, so gilt fuer     */
	/*   ein bzgl. P minimales Modell E'/K mit c4':            */
	/*       v_P( c4 ) = 4 * k + v_P( c4' ), k in N            */

	/*   Multiplikative Reduktion mod P                        */
	/*   REDUKTIONSTYP Bn bzw. In                              */
	/*   Sei js = Jacobi-Symbol( -2 * A4 * A6, p ).            */
	/*          /  n, falls js == +1                           */
	/*   c_p = <   1, falls js == -1 und n ungerade            */
	/*          \  2, falls js == -1 und n   gerade            */

	exp  = 1;
        rtyp = (-1) * n;

	h2 = qnfprod ( D, A4, A6 );
	h1 = qnfiprod( D, h2, -2 );

	if( ( n > 2 ) && issquaremodP( D, P, pi, z, h1 ) )
	{
	    /*   -2 A4 A6 ist Quadrat modulo P   */
	    c_p = n;
	}
	else
	{
	    /*   -2 A4 A6 kein Quadrat modulo P   */
	    if( n % 2 )
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
	/*   REDUKTIONSTYP C1 bzw. II                              */
	/*   c_p = 1.                                              */

	exp  = 2;
	rtyp = 1;
	c_p  = 1;

	return( list3( exp, rtyp, c_p ) );
    }

    if( n == 3 )
    {
	/*   REDUKTIONSTYP C2 bzw. III                             */
	/*   c_p = 2.                                              */

	exp  = 2;
	rtyp = 2;
        c_p  = 2;

	return( list3( exp, rtyp, c_p ) );
    }

    if( n == 4 )
    {
	/*   REDUKTIONSTYP C3 bzw. IV                              */
	/*   c_p = 3, falls A6/(pi^2) Quadrat modulo P             */
        /*       = 1 sonst                                         */

	exp  = 2;
	rtyp = 3;

	h1 = qnfsquare( D, pi );
	h2 = qnfquot( D, A6, h1 );

	if( issquaremodP( D, P, pi, z, h2 ) )
	{
	    /*   A6 / (pi^2) ist Quadrat modulo P   */
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
	/*   REDUKTIONSTYP C4 bzw. I0*                             */
	/*   Seien d4 = A4/pi^2 und d6 = A6/pi^3 sowie             */
	/*             P(T) = T^3 + d4 * T + d6                    */
	/*   c_p = 1 + Anzahl der Nullstellen von P(T) in O_P      */
        /*       = 1 + { 0, 1 oder 3 }                             */
        
        list   L;

        init( L );

	exp  = 2;
	rtyp = 5;

	h1 = qnfprod ( D, pi, pi );
	h2 = qnfprod ( D, pi, h1 );
	A4 = qnfquot ( D, A4, h1 );
	A6 = qnfquot ( D, A6, h2 );
	h1 = qnfpihom( D, P, pi, z, A4 );
	h2 = qnfpihom( D, P, pi, z, A6 );

        L = qnfpol3nr( D, P, pi, z, 0, h1, h2 );

	c_p = 1 + lfirst( L );

	return( list3( exp, rtyp, c_p ) );
    }

    /*   Berechnung der p-Ordnung k von A4                         */

    if( n > ( 3 * k ) ) /*   <==>  v_P( j ) < 0                    */
    {

	/*   REDUKTIONSTYP C5,v bzw. Iv*                           */
	/*   Seien j1 = j * p^v  mit  v = n - 6                    */
	/*   bzw.  d4 = A4 / pi^2,  d6 = A6 / pi^3,                */
	/*         h  =  2 * d4 * d6, falls #K_P = 1 mod 4         */
	/*         h  = -2 * d4 * d6 sonst.                        */
	/*          / 4, falls n  gerade und j1  ein Quadrat mod P */
	/*          | 2, falls n  gerade und j1 kein Quadrat mod P */
	/*   c_P = <                                               */
	/*          | 4, falls n ungerade und h  ein Quadrat mod P */
	/*          \ 2, falls n ungerade und h kein Quadrat mod P */

	exp  = 2;
	rtyp = 4 + n;

	h2 = lfifth( LTV );
	h1 = qnfexp  ( D, h2, 3 );      /*   h1 = c4^3 / D    */
	h1 = qnfquot ( D, h1, DE );     /*   (j-Invariante)   */
	      
	h2 = qnfiprod( D, h1, lfirst( h1 ) );
	h2 = qnfiprod( D, h2, lfirst( h1 ) );

	k  = qnfpiord( D, P, pi, z, h2 );
	h1 = qnfexp( D, pi, k );
	h2 = qnfquot( D, h2, h1 );

	/*  h2 = Zaehler(j1) * Nenner(j1)  */

	if( n % 2 )
	{
	    /*    n ungerade   */
	    int p;
	    init ( p );

	    if( z )
	    {
		/*   p zerlegt oder verzweigt   */
		p = lsecond( P );
	    }
	    else
	    {
		/*   p traege   */
		p = lfirst( P );
	    }

	    h1 = qnfprod( D, pi, pi );
	    A4 = qnfquot( D, A4, h1 );      /*    d4    */
	    m  = lfirst( A4 );
	    A4 = qnfiprod( D, A4, m );
	    A4 = qnfiprod( D, A4, m );

	    h1 = qnfprod( D, pi, h1 );
	    A6 = qnfquot( D, A6, h1 );      /*    d6    */
	    m  = lfirst( A6 );
	    A6 = qnfiprod( D, A6, m );
	    A6 = qnfiprod( D, A6, m );

	    h1 = qnfprod( D, A4, A6 );

	    if( !z || ( m4hom( p ) == 1 ) )
	    {
	        h1 = qnfiprod( D, h1, -2 );
	    }
	    else
	    {
	        h1 = qnfiprod( D, h1,  2 );
	    }
	    h2 = qnfprod( D, h1, h2 );
	    /*   h2 = h * Zaehler(j1) * Nenner(j1)   */
	}

	if( issquaremodP( D, P, pi, z, h2 ) )
	{
	    c_p = 4;
	}
	else
	{
	    c_p = 2;
	}
	
	return( list3( exp, rtyp, c_p ) );
    }

    if( n == 8 )
    {
	/*   REDUKTIONSTYP C6 bzw. IV*                             */

	exp  = 2;
	rtyp = 6;

	h2 = qnfprod( D, pi, pi );
	h2 = qnfprod( D, h2, h2 );
	h1 = qnfquot( D, A6, h2 );

	if( issquaremodP( D, P, pi, z, h1 ) )
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
	/*   REDUKTIONSTYP C7 bzw. III*                            */

	exp  = 2;
	rtyp = 7;
	c_p  = 2;

	return( list3( exp, rtyp, c_p ) );
    }

    if( n == 10 )
    {
	/*   REDUKTIONSTYP C8 bzw. II*                             */

	exp  = 2;
	rtyp = 8;
	c_p  = 1;

	return( list3( exp, rtyp, c_p ) );
    }

    /*   Fehlerhafter Durchlauf                                    */
    return( list1( -1 ) );
}

/*c
	                issquaremodP( D, P, pi, z, a )

	"is quadratic number field element square modulo P"
        static issquaremodP( D, P, pi, z, a ) int D; list P; nfel a;
	s = issquaremodP( D, P, pi, z, a );
	Dabei muss gelten:
	   - D ist aus Z\{0,1} quadratfrei
	   - P ist ein Primideal in Q(D^(1/2))
	   - a ist ein ganzes Element in Q(D^(1/2))
	Rueckgabe:
	  - 1, falls b^2 - a == 0 mod P fuer ein b in O_D
	  - 0 sonst.
        issquaremodP ist static zu ecqnfcond.
c*/
/*cS
        issquaremodP ruft auf: ijacsym, isqnfppihom0, isquot, qnfpihom,
		qnfsquare, qnfsysrmodpi  
	Macros: lfirst, lfourth, list3, list4, lsecond, m4hom, qnfdif
Sc*/

static issquaremodP( D, P, pi, z, a )
int    D;
list   P;
nfel   pi, a;
single z;
{
    bind( D, P, pi, a  );

    if( z )
    {
	/*   p zerlegt oder verzweigt: a mod P in Z, da       */
	/*   { 0, 1, ..., p - 1 } Restsystem modulo P ist.    */
	/*   Es gilt: a ist Quadrat modulo P <==>             */
	/*             (a mod P) Quadrat modulo p (in Z).     */

	int  p, b;
	nfel c;
	
	init( p, b, c );

	/*   p zerlegt oder verzweigt: P = ( 1, p*s, x, s )   */
	p = lsecond( P );
	p = isquot( p, lfourth( P ) );

	c = qnfpihom( D, P, pi, z, a );
	if( c )
	{
	    /*   c stellt die ganze Zahl b != 0 dar:    */
	    /*      ==>  c = ( 1, 0, b )                */
	    
	    b = lthird( c );
	}
	else
	{
	    /*   c = 0   */
	    b = 0;
	}
	return( ijacsym( b, p ) );
    }
    else
    {
	/*   p traege  */
        list L;
        int  u, v, x, y;
        nfel b, c, d, e;
    
        init( L, u, v, x, y );
        init( b, c, d, e );

        L = qnfsysrmodpi( D, P, pi, z, 1 );
		
        u = lfirst ( L );
        v = lsecond( L );
    
        if( v )
        {
	    init( b );
    
            if( m4hom( D ) == 1 )
            {
                /*    Ganzheitsbasis: 1 und d = [1+D^(1/2)]/2     */
                d = list4( 2, 1, 1, 1 );
            }
            else
            {
                /*    Ganzheitsbasis: 1 und d = D^(1/2)           */
                d = list4( 1, 1, 1, 0 );
            }
        }

        b = qnfpihom( D, P, pi, z, a );

        for( x = 0; x <= u; x++ )
        {
	    if( x )
	    {
	        c = list3( 1, 0, x );
	    }
	    else
	    {
	        c = 0;
	    }
    
	    for( y = 0; y <= v; y++ )
	    {
	        e = qnfsquare( D, c );
	        e = qnfdif( D, b, e);
	        if( isqnfppihom0( D, P, 1, pi, z, e ) )
                {
		    return( 1 );
	        }
                c = qnfsum( D, c, d );
	    }
        }
        return( 0 );
    }
}

/*c
			qnfpol3nr( D, P, pi, z, a, b, c )

        "quadratic number field polynomial of degree 3, number of roots"
        static list qnfpol3nr( D, P, a, b, c ) int D; list P; nfel a,b,c;
        L = qnfpol3nr( D, P, pi, z, a, b, c );
        qnfpol3nr ist static zu ecqnfcond.
	Dabei gilt: D, P, pi, z wie in Dokumentation von cPvalue.
	a, b, c sind Elemente aus K, die bzgl P ganz sind, d.h.
	v_P-Wert groesser oder gleich Null haben. 
	Sei h mit 0 <= h <= 3 die Anzahl der verschiedenen Nullstellen 
	des Polynoms f(X) = X^3 + a * X^2 + b * X + c im algebraischen
	Abschluss von O_P, und seien x1,..., xh diese Nullstellen:
		     F(X) = (X-x1) * (x-x2) * (X-x3).
        Rueckgabe: 
	  ( 3, x1, x2, x3 ) falls h = 3 ist und x1, x2, x3 in O_P liegen,
          ( 3, x1 ) nfel x1; falls h = 3 ist und x1 in O_P und x2,
	         x3 nicht in O_P liegen,,
          ( 3 ), falls h = 3 ist und keines der xi in O_P liegt,
          ( 2, x1, x2 ) nfel x1, x2; falls h = 2 ist und x1 ( = x3)    
		 doppelte und x2 einfache Nullstelle von f(X) in O_P,
          ( 1, x1 ), falls h = 1 ist und x1 = x2 = x3 3-fache Nullstelle
		 von f(X) in O_P ist.
        Dabei sind x1, x2 bzw. x3 vom Typ nfel.
c*/
/*cS
        qnfpol3nr ruft auf: isint, isqnfppihom0, lcomp, qnfiprod,
	       qnfprod, qnfsum, qnfsysrmodpi
        Macros: lfirst, list1, list2, list3, list4, lsecond
Sc*/

static list qnfpol3nr( D, P, pi, z, a, b, c )
int D;
list P;
single z;
nfel pi, a, b, c;
{
    single h, i, j, x, y;
    list   L;
    nfel   x1, x2, x3;
    nfel omega;

    init( L );
    init( x1, x2, x3 );
    init( omega );
    bind( D, P, pi, a, b, c );

    L = qnfsysrmodpi( D, P, pi, z, 1 );

    x = lfirst ( L );
    y = lsecond( L );

    h  = 0;

    L = _0;

    if( m4hom( D ) == 1 ) omega = list4( 2, 1, 1, 1 );
    else omega = list4( 1, 1, 1, 0 );

    for( i = 0; i <= x; i++ )
    {
	x1 = list3( 1, 0, i );
        for( j = 0; j <= y; j++ )
        {
	    x2 = qnfsum ( D, x1,  a );
	    x2 = qnfprod( D, x2, x1 );
	    x2 = qnfsum ( D, x2,  b );
	    x2 = qnfprod( D, x2, x1 );
	    x2 = qnfsum ( D, x2,  c );

	    if( isqnfppihom0( D, P, 1, pi, z, x2 ) )
	    {
		/*   x1 Nullstelle   */
		h++;

		x2 = qnfiprod( D,  a,  2 );
		x3 = qnfiprod( D, x1,  3 );
	        x2 = qnfsum  ( D, x2, x3 );
	        x2 = qnfprod ( D, x2, x1 );
	        x2 = qnfsum  ( D, x2,  b );
	        if( isqnfppihom0( D, P, 1, pi, z, x2 ) )
	        {
		    /*   x1 mehrfache Nullstelle   */

		    x2 = qnfiprod( D, x1, 3 );
	            x2 = qnfsum  ( D, x2, a );
	            if( isqnfppihom0( D, P, 1, pi, z, x2 ) )
	            {
		        /*   x1 dreifache Nullstelle   */
			return( list2( 1, x1 ) );
	            }
		    else
		    {
		        /*   x1 doppelte Nullstelle   */
			if( L != _0 )
			{
			    L = lcomp( x1, L );
			    L = lcomp( 2, L );
			    return( L );
			}
			else
			{
			    L = lcomp( x1, L );
			    L = lcomp( 2, L );
			}
		    }
	        }
		else
		{
		    /*   x1 einfache Nullstelle   */

		    if( ( L != _0 ) && ( isint( lfirst( L ) ) ) 
		    &&  ( lfirst( L ) == 2 ) )
		    {
			return( list3( 2, lsecond( L ), x1 ) );
		    }
		    else
		    {
			L = lcomp( x1, L );
		    }
		}
	        if( h == 3 )
		{
		    return( lcomp( 3, L ) );
		}
	    }
	    x1 = qnfsum( D, x1, omega);
	}
    }
    if( h )
    {
	return( lcomp( 3, L ) );
    }
    return( list1( 3 ) );
}
