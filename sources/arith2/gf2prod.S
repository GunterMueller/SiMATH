/*M
.SH NAME
gf2prod - Galois field with characteristic 2 product

.SH SYNOPSIS
.nf
#include<_arith2.h>

gf2el gf2prod(G,a,b)
obj   G;
gf2el a, b;

.SH DESCRIPTION
gf2prod returns the product of two elements a and b in GF(2^n).

.PP
.TP 4
.B G
is an irreducible monic polynomial in one variable over Z/2Z of degree n in the special bit representation, G is the generating polynomial of GF(2^n).
.TP 4
.B a, b
are elements of GF(2^n) represented by polynomials in one variable over Z/2Z of degree < n in special bit representation.  
M*/
/*H
        Version 1        04.03.1992     A.Stein
	Version 2        09.07.1998     A.Heiser
	Version 3        09.09.1999     Marc Conrad 
   DATE gf2prod        : 980709
H*/

#include <_arith2.h>
#include <_G2arith.h>
static obj gf2prodsub(gf2el a, gf2el b);

gf2el gf2prod(G,a,b)
obj G;
gf2el a, b;
{
    /*    Spezialfall : a*b = 0    */

        if ( !a || !b ) return(0);
   {
        single n, n1, k, i, f, d, u;
        obj c1, G1, G1h;
        gf2el c;
        list A;

        bind(G,a,b);
        init(G1,c,A);        

        n = lfirst(G);
	if(oequal(a,b)) { 
	  return(gf2squ(G,a));
        } else if( n <= G2maxdeg() ) { 
              unsigned long G2a[G2LAENGE];
              unsigned long G2b[G2LAENGE];
              unsigned long G2g[G2LAENGE];
              gf2toG2(a,G2a); 
              gf2toG2(b,G2b); 
              gf2toG2(G,G2g); 
              G2multeq(G2g,G2a,G2b);
              return( G2togf2(G2a) ); 
              } 
	else { 
          c = gf2prodsub(a,b);   /* c = a * b in Z/2Z[X]  */ 
          }
        k = lfirst(c);

    /*    Spezialfall : Grad(a*b) < n                   */
        if ( k < n ) return( c );

    /*  allgemeiner Fall : Grad(a*b) >= n               */
    /*  G wird unter c geschoben, d.h. G1 = G * x^(k-n) */

        i = k - n;
        n1 = i / 30; 
        for( A=_0; n1--; A=lcomp(0,A) );
        i %= 30;
        G1 = list2( i, (1<<i) );
        G1 = gf2prodsub(G,G1);
        lsfirst(G1,k);
        G1h = llast(G1);
        lsred(G1h,A); 

    /*  Reduktion durch explizite Addition ( == Subtraktion )   */

        n1 = (n/30) + 1;
        c = lred(c);
        while( k >= n ) {
                i = lfirst(G1) - k; 

           /* G1 ( bzw. G ) wird nach rechts unter das neue c geschoben */

                for( G1=lred(G1); i--; ) {
                        u = 0;
                        if( lfirst(G1) == 1 ) {
                                G1 = lred(G1);
                                u = 1;
                        }
                        G1h = G1;
                        do {    
                                f = lfirst(G1h);
                                d = ( f & 1 ) ? (1) : (0);
                                f >>= 1;
                                if( u ) f ^= (1<<29); 
                                lsfirst(G1h,f);
                                u = d; 
                                G1h = lred(G1h);
                        }
                        while( G1h != _0 );
                } 
                G1 = lcomp(k,G1);

         /* Addition (Subtraktion) der Komponenten   */
 
                c1 = c; 
                G1h = lred(G1);
                for( i=n1; i--; ) {
                        f = lfirst(G1h) ^ lfirst(c1);
                        lsfirst(c1,f);
                        c1 = lred(c1); 
                        G1h = lred(G1h);
                }
                if( G1h != _0 && ( f=lfirst(G1h) ) ) {
                        f ^= lfirst(c1);
                        lsfirst(c1,f); 
                }

           /* Ermitteln des Grades von a(neu)  */

                k = k - (k%30);
                for( ; c != _0 && !(f=lfirst(c)); c = lred(c), k-=30 );
                if( c == _0 ) return(0);
                else for( f>>=1; f; f>>=1, k++ );
        }
        return( lcomp(k,c) );
   }
}

/*c
        gf2prodsub ist ein Unterprogramm zu gf2prod,
        abgelegt als static modul.
        a und b sind Elemente aus GF(2^n), die als Polynome in 
        einer Variablen ueber Z/2Z vom Grad < n in spezieller 
        Bit-Notation (vgl. udpm2tosb) dargestellt werden.
        Es wird dann das volle Produkt von a und b in Z/2Z[X] 
        berechnet (ohne Reduktion). Das Ergebnis wird in spezieller
        Bit-Notation zurueckgeliefert.
c*/
/*H
        Version 1        04.03.1992     A.Stein
H*/

static obj gf2prodsub(a,b)
gf2el a, b;
{
    /*  a und b sind auf jeden Fall ungleich 0  */

        single ea, eb, ec, a1, b1, c1, d, u;
        obj c, cS, cSS, aS;
        bind(a,b);
        init(c);

        ea = lfirst(a); a = lred(a);
        eb = lfirst(b); b = lred(b);
        ec = ea + eb; 
        ea = ( ea / 30 ) + ( eb / 30 ) + 1;
        for( c=list1(0); ea--; c=lcomp(0,c) );
        for( cS=c; b!=_0; cS=lred(cS) )  {
                cSS = cS;
                aS = a; u = 0;
                b1 = lfirst(b);
                b = lred(b);
                if (b1) {
                        for( ; aS!=_0; cSS=lred(cSS) ) {
                                a1 = lfirst(aS); 
                                aS = lred(aS);
                                sxprod(a1,b1,&c1,&d);
                                c1 ^= u; u = d;
                                c1 ^= lfirst(cSS);
                                lsfirst(cSS,c1);
                        } 
                lsfirst(cSS,u);
                }
        }
        if ( !lfirst(c) ) c = lred(c);
        return( lcomp(ec,c) );
}

