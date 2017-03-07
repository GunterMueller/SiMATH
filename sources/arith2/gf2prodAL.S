/*M
.SH NAME
gf2prodAL - Galois-field with characteristic 2 product with arithmetic list

.SH SYNOPSIS
.nf
#include<_arith2.h>

gf2el gf2prodAL(AL, a, b)  
list AL; 
gf2el a, b;

.SH DESCRIPTION
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(2^n), where n = lenght(AL1)+1 (s. gf2algen).
.TP 4
.B a, b
are elements of GF(2^n), represented as univariate polynomials over Z/2Z of degree < n in special bit-representation (s.udpm2tosb).
.PP
gf2prodAL returns an element of GF(2^n), say c, where
.IP
c = a * b.

.SH NOTES
The origin function, computing the product of two GF(2^n) elements is called gf2prod. Mostley, gf2prod is faster and needs much less memory space than gf2prodAL.

.SH SEE ALSO
 udpm2tosb
 gf2algen
 gf2prod

M*/
                            
/*H
	Version 1    	 04.03.1992	A.Stein
   DATE gf2prodAL      : 920331
H*/

# include <_arith2.h>

static obj gf2prodALsu(gf2el,gf2el);

gf2el gf2prodAL(AL,a,b)
list AL;
gf2el a, b;
{
    /*    Spezialfall : a*b = 0    */
	if ( !a || !b ) return(0);
    {
	single l, k, n, c1, c2;
	gf2el c, ERG;
	obj G;
	list AL1;
	bind(AL,a,b);
	init(c,ERG,G,AL1);

	G = lfirst(AL);
	AL = lred(AL);
	AL1 = lfirst(AL);
	AL = lred(AL);
	n = llength(AL1) + 1;
	c = gf2prodALsu(a,b);
	k = lfirst(c);

    /*	Spezialfall : Grad(a*b) < n    */

	
if ( k < n ) return( c );

    /*	allgemeiner Fall : Grad(a*b) >= n    */ 
    /*	Reduktion mit Hilfe der Basis	*/

	c = lred(c);
	for( l=2*n-2; l>k; l-- ) AL1 = lred(AL1);
	for( l %= 30; AL1 != _0; l = 29 ) {
		c1 = lfirst(c); c = lred(c);
		c2 = (1 << l);
		for( ; c2; c2>>=1 ) {
			if( c1 & c2 ) ERG = gf2sum(G,ERG,lfirst(AL1));
			AL1 = lred(AL1);
			if( AL1 == _0 ) break;
		}
	} 
	c1 %= c2;
	k = n - (n%30);
	if( c1 ) c = lcomp(c1,c);
	else for( k-=30; c != _0 && !(c1=lfirst(c)); k-=30 ) c = lred(c);
	if( c == _0 ) return( ERG );
	else for( c1>>=1 ; c1; c1>>=1, k++ );
	c = lcomp(k,c);
	return( gf2sum(G,c,ERG) );
   }
}  

/*c
	gf2prodALsu ist ein Unterprogramm zu gf2prodAL,
	abgelegt als static modul.
	a und b sind Elemente aus GF(2^n), die als Polynome in 
	einer Variablen ueber Z/2Z vom Grad < n in spezieller 
	Bit-Notation (vgl. udpm2tosb) dargestellt werden.
	Es wird dann das volle Produkt von a und b in Z/2Z[X] 
	berechnet (ohne Reduktion). Das Ergebnis wird in spezieller
	Bit-Notation zurueckgeliefert.
c*/
/*H
	Version 1    	 04.03.1992	A.Stein
H*/

static obj gf2prodALsu(a,b)
gf2el a, b;
{
    /*	a und b sind auf jeden Fall ungleich 0	*/

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
