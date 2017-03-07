/*M
.SH NAME
gf2squAL - Galois-field with characteristic 2 square with arithmetic list

.SH SYNOPSIS
.nf
#include<_arith2.h>

gf2el gf2squAL(AL,a)  
list AL; 
gf2el a;

.SH DESCRIPTION
.TP 4
.B AL
= (G AL1) can be seen as an arithmetic list of GF(2^n), where n = lenght(AL1)+1 (s. gf2algen). 
.TP 4
.B a
is an elements of GF(2^n), represented as univariate polynomial over Z/2Z of degree < n in special bit-representation (s. udpm2tosb).
.PP
gf2squAL returns an element of GF(2^n), say c, where
.IP
c = a * a.
.SH NOTES
The origin function, computing the square of a GF(2^n) element is called gf2squ. Mostly, gf2squ is faster and needs much less memory space than gf2squAL.

.SH SEE ALSO
 udpm2tosb
 gf2algen
 gf2squ

M*/
                                   
/*H
	Version 1    	 06.03.1992	A.Stein
   DATE gf2squAL       : 920331
H*/

# include <_arith2.h>

static obj gf2squALsub(gf2el);

gf2el gf2squAL(AL,a)
list AL;
gf2el a;
{
	if ( !a ) return(0);
    {
	single l, k, n, c1, c2;
	gf2el c, ERG;
	obj G;
	list AL1;
	bind(AL,a);
	init(c,ERG,G,AL1);

	AL1 = lsecond(AL);
	n = llength(AL1) + 1;
	c = gf2squALsub(a);
	k = lfirst(c);

    /*    Spezialfall : Grad(a^2) < n    */
	if ( k < n ) return( c );

    /*    allgemeiner Fall : Grad(a^2) >= n    */ 
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
	else for( c1>>=1 ; c1 ; c1>>=1 , k++ );
	c = lcomp(k,c);
	return( gf2sum(G,c,ERG) );
   }
} 

/*c
	gf2squALsub ist ein Unterprogramm zu gf2squAL,
	abgelegt als static modul.
	a und b sind Elemente aus GF(2^n), die als Polynome in 
	einer Variablen ueber Z/2Z vom Grad < n in spezieller 
	Bit-Notation (vgl. udpm2tosb) dargestellt werden.
	Es wird dann das volle Produkt von a und b in Z/2Z[X] 
	berechnet (ohne Reduktion). Das Ergebnis wird in spezieller
	Bit-Notation zurueckgeliefert.
c*/
/*H
	Version 1    	 06.03.1992	A.Stein
H*/

static obj gf2squALsub(a)
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
