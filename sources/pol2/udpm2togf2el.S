/*M
.SH NAME
udpm2togf2el - univariate dense polynomial over modular 2 to Galois-field with characteristic 2 element

.SH SYNOPSIS
.nf
#include<_pol2.h>

gf2el udpm2togf2el(G, P)  
obj G; 
pol P;

.SH DESCRIPTION
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb). 
.PP
Let n be the degree of G, then G can be seen as a generator of Gf(2^n)
( Galois-field with characteristic 2 ).
.TP 4
.B P
is an univariate polynomial in dense representation over Z/2Z.
.PP
udpm2togf2el returns the polynomial P as an element of the field Gf(2^n).
In order to achieve that, P will be represented in the special bit-representation (by udpm2tosb) and after that reduced modulo G. 

.SH SEE ALSO
udpm2tosb

M*/
    
/*H
	Version 1       10.03.1992	A.Stein 
   DATE udpm2togf2el  : 920331
H*/

#include <_pol2.h>

static obj udpm2togf2s1(obj,obj);
static obj udpm2togf2s2(obj,obj);

gf2el udpm2togf2el(G,P)
obj G;
pol P;
{
	gf2el a;
	bind(a,G,P);

	a = udpm2tosb(P);	
	return( udpm2togf2s1(a,G) );
}

/*c
	udpm2togf2s1 ist ein Unterprogramm zu udpm2togf2el,
	abgelegt als static modul.
	a, b sind Polynome aus Z/2Z[X], dargestellt in spezieller Bit-
	Notation (vgl. udpm2tosb). 
	Berechnet wird
		a % b  in Z/2Z[X].
	Das Ergebnis wird dann auch in der speziellen Bit-Darstellung
	zurueckgeliefert. 
    VORSICHT: a wird dabei veraendert !!
c*/
/*H
	Version 1    	 06.03.1992	A.Stein
H*/

static obj udpm2togf2s1(a,b)
obj a, b;
{
	if ( !a || ( lfirst(a) < lfirst(b) ) ) return( a );
   {
	single na, nb, n1, i, f, g, u, d;
	obj a1, b1;
	list A;

	bind(a,b,b1);
	init(A);

	na = lfirst(a);
	nb = lfirst(b); 

    /*	b wird unter c geschoben, d.h. b := b * x^(nq)	*/
	
	i = na - nb;
	n1 = i / 30; 
	for( A=_0; n1--; A=lcomp(0,A) );
	i %= 30;
	b1 = list2( i, (1<<i) );
	b = udpm2togf2s2(b,b1);        /* b = b * x^i  in Z/2Z[X] */
	lsfirst(b,na);
	a1 = llast(b);
	lsred(a1,A); 

   /*  Vorbereitung der Haupt-Schleife   */
	
	n1 = (nb/30) + 1;
	a = lred(a); 

   /*  explizite Division mit Rest in Z/2Z[X]   */

	while( na >= nb ) { 
		i = lfirst(b) - na; 

            /* b(neu) wird nach rechts unter das neue a geschoben */

		for( b=lred(b); i--; ) {
			u = 0;
                    	if( lfirst(b) == 1 ) {
				b = lred(b);
	     		   	u = 1;
			}
			b1 = b;
			do {    
				f = lfirst(b1);
				d = ( f & 1 ) ? (1) : (0);
				f >>= 1;
				if( u ) f ^= (1<<29); 
				lsfirst(b1,f);
				u = d; 
				b1 = lred(b1);
			}
			while( b1 != _0 );
		}                               
		b = lcomp(na,b);   

	    /* Addition (Subtraktion) der Komponenten   */ 

		a1 = a; 
		b1 = lred(b);
		for( i=n1; i--; ) {
			f = lfirst(b1) ^ lfirst(a1);
			lsfirst(a1,f);
			a1 = lred(a1); 
			b1 = lred(b1);
		}
		if( b1 != _0 && (f=lfirst(b1)) ) {
			f ^= lfirst(a1);
			lsfirst(a1,f); 
		}

	    /* Ermitteln des Grades von a(neu)  */
 
		na = na - (na%30);
		for( ; a != _0 && !(f=lfirst(a)); a = lred(a), na-=30 );
		if( a == _0 ) return( 0 );
		else for( f>>=1; f; f>>=1, na++ );
	}
	return( lcomp(na,a) );
   }
}

/*c
	udpm2togf2s2 ist ein Unterprogramm zu udpm2togf2el,
	abgelegt als static modul.
	a, b sind Polynome aus Z/2Z[X], dargestellt in spezieller Bit-
	Notation (vgl. udpm2tosb).
	Es wird dann das volle Produkt von a und b in Z/2Z[X] 
	berechnet (ohne Reduktion). Das Ergebnis wird in spezieller
	Bit-Notation zurueckgeliefert.
c*/
/*H
	Version 1    	 06.03.1992	A.Stein
H*/

static obj udpm2togf2s2(a,b)
obj a, b;
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
