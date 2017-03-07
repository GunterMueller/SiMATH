/*M
.SH NAME
gf2squ - Galois-field with characteristic 2 square

.SH SYNOPSIS
.nf
#include<_arith2.h>

gf2el gf2squ(G,a)  
obj G; 
gf2el a;

.SH DESCRIPTION
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb).
.PP
Let n be the degree of G, then G can be seen as a generator of GF(2^n)
( Galois-field with characteristic 2 ).
.TP 4
.B a
is an elements of GF(2^n), represented as univariate polynomial over Z/2Z of degree < n in special bit-representation.
.PP
gf2squ returns an element of GF(2^n), say c, where
.IP
c = a * a.
.SH NOTES
There is a second function computing the square of a gf2el, namely gf2squAL, using an arithmetic list (s. gf2algen).
Mostly, gf2squ is faster and needs much less memory space than gf2squAL.

.SH SEE ALSO
 udpm2tosb
 gf2squAL
 gf2algen

M*/
                          
/*H
	Version 1    	 04.03.1992	A.Stein
	Version 2    	 24.08.1999	Marc Conrad (G2-Arithmetik)
   DATE gf2squ         : 920331
H*/

#include <_arith2.h>
#include <_G2arith.h>

static obj gf2squsub2(obj a, obj b);
static obj gf2squsub1(obj a);

gf2el gf2squ(G,a)
obj G;
gf2el a;
{
	/*    Spezialfall : a = 0    */
	if ( !a ) return(0);
   {
	single n, n1, k, i, f, d, u;
	obj c1, G1, G1h;
	gf2el c;
	list A;

	bind(G,a);
	init(G1,c,A);        

	n = lfirst(G);

        if( n <= G2maxdeg() ) { 
                unsigned long G2g[G2LAENGE]; 
                unsigned long G2a[G2LAENGE]; 
                gf2toG2(G,G2g); 
                gf2toG2(a,G2a); 
                G2squareeq(G2g,G2a);
                return(G2togf2(G2a));
                }   
	c = gf2squsub1(a);
	k = lfirst(c);

    /*    Spezialfall : Grad(a^2) < n			*/ 

	if ( k < n ) return( c );

    /*  allgemeiner Fall : Grad(a^2) >= n		*/
    /*	G wird unter c geschoben, d.h. G1 = G * x^(k-n)	*/
	
	i = k - n;	
	n1 = i / 30; 
	for( A=_0; n1--; A=lcomp(0,A) );
	i %= 30;
	G1 = list2( i, (1<<i) );
	G1 = gf2squsub2(G,G1);
	lsfirst(G1,k);
	G1h = llast(G1);
	lsred(G1h,A);

    /*	Reduktion durch explizite Addition ( == Subtraktion )	*/

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
		c1 = c; 
		G1h = lred(G1);
		for( i=n1; i--; ) {
			f = lfirst(G1h) ^ lfirst(c1);
			lsfirst(c1,f);
			c1 = lred(c1); 
			G1h = lred(G1h);
		}
		if( G1h != _0 && (f=lfirst(G1h)) ) {
			f ^= lfirst(c1);
			lsfirst(c1,f); 
		}
		k = k - (k%30);
		for( ; c != _0 && !(f=lfirst(c)); c = lred(c), k-=30 );
		if( c == _0 ) return(0);
		else for( f>>=1; f; f>>=1, k++ );
	}
	return( lcomp(k,c) );
   }
}


/*c
	gf2squsub1 ist ein Unterprogramm zu gf2squ,
	abgelegt als static modul.
	a ist ein Element aus GF(2^n), das als Polynome in 
	einer Variablen ueber Z/2Z vom Grad < n in spezieller 
	Bit-Notation (vgl. udpm2tosb) dargestellt wird.
	Es wird dann das volle Quadrat von a in Z/2Z[X] 
	berechnet (ohne Reduktion). Das Ergebnis wird in spezieller
	Bit-Notation zurueckgeliefert.
c*/
/*H
	Version 1    	 04.03.1992	A.Stein
H*/

static obj gf2squsub1(a)
gf2el a;
{
    /* 	a ist auf jeden Fall ungleich Null 	*/
 
	single e, f, c, d;
	obj a1;
	bind(a);
	init(a1);

	e = 2 * lfirst(a);
	a = lred(a);
	for( a1 = _0; a != _0; a = lred(a) ) {
		f = lfirst(a);	
		sxsqu(f,&c,&d);
		a1 = lcomp2(d,c,a1);
	} 
	a1 = linv(a1);
	if ( !lfirst(a1) ) a1 = lred(a1);
	return( lcomp(e,a1) );
}

/*c
	gf2squsub2 ist ein Unterprogramm zu gf2squ,
	abgelegt als static modul.
	a, b sind Polynome aus Z/2Z[X], die in spezieller Bit-
	Notation dargestellt werden.
	Es wird dann das volle Produkt von a und b in Z/2Z[X] 
	berechnet (ohne Reduktion). Das Ergebnis wird in spezieller
	Bit-Notation zurueckgeliefert.
c*/
/*H
	Version 1    	 04.03.1992	A.Stein
H*/

static obj gf2squsub2(a,b)
obj a, b;
{
    /*  a und b sind auf jeden Fall ungleich 0 */

	single ea, eb, ec, a1, b1, c1, d, u;
	obj c, cS, cSS, aS;
	bind(a,b,c);

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

