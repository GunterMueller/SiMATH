/*M
.SH NAME
gf2inv - Galois-field with characteristic 2 inverse

.SH SYNOPSIS
.nf
#include<_arith2.h>

gf2el gf2inv(G, b)  
obj G; 
gf2el b;
 
.SH DESCRIPTION
.TP 4
.B G
is an univariate, monic and irreducible polynomial over Z/2Z in special bit-representation (s.udpm2tosb).
.PP
Let n be the degree of G, then G can be seen as a generator of GF(2^n)
( Galois-field with characteristic 2 ).
.TP 4
.B b
is an elements of GF(2^n), represented as univariate polynomial over Z/2Z of degree < n in special bit-representation.
.PP
gf2inv returns the multiplicative inverse element of b (in GF(2^n)).

.SH SEE ALSO
udpm2tosb

M*/
                            
/*H
	Version 1       06.03.1992	A.Stein
	Version 2       08.10.1992	init statt bind.  AS
	Version 3    	24.08.1999	Marc Conrad (G2-Arithmetik)
   DATE gf2inv        : 920331.921130
H*/

#include <_arith2.h>
#include <_G2arith.h>
static obj gf2invsub1(obj a,obj b, obj *pr);
static obj gf2invsub2(obj a, obj b);
static obj gf2invsub3(obj a, obj b);

gf2el gf2inv(G,a)
obj G;
gf2el a;
{
	single e, f;
	obj q, r0, r1, r2, t0, t1, t2, t2h;
	bind(a,G);
	init(q,r0,r1,r2,t0,t1,t2);

        if( lfirst(G) <= G2maxdeg() ) { 
                unsigned long G2g[G2LAENGE]; 
                unsigned long G2a[G2LAENGE]; 
                gf2toG2(G,G2g); 
                gf2toG2(a,G2a); 
                G2inveq(G2g,G2a);
                return(G2togf2(G2a));
                }   

    /*  half-extended ggt(G,a) = s*G + t*a in Z/2Z[X]. Dabei ist 
	t = t(n) bei Abbruch des Euklidischen Alg.      */  
        
	r0 = lcopy(G); 
	r1 = lcopy(a);

    /* r0 = q * r1 + r2 in Z/2Z[X]  */

	q = gf2invsub1(r0,r1,&r2);     

    /*  Ist r2 = 0, so G = q1 * a. Da G irreduzibel, muss a = 1 sein.  */

 	if( !r2 ) return( a );
	t1 = list2(0,1);
	t2 = q;   
	r0 = r1; r1 = r2;
	q = gf2invsub1(r0,r1,&r2); 
 	while( r2 ) {
		t0 = t1; t1 = t2;

    	    /* t2 = q * t1 in Z/2Z[X]  */

		t2 = gf2invsub3(q,t1);    

	    /* Addition von t0 und t2	*/
		
		e = ( lfirst(t2) / 30 ) - ( lfirst(t0) / 30 );
		for( t2h = lred(t2); e--; t2h = lred(t2h) );
		t0 = lred(t0);
		while( t2h != _0 ) {
			f = lfirst(t2h) ^ lfirst(t0);
			lsfirst(t2h,f);
			t2h = lred(t2h);
			t0 = lred(t0);
		}

		r0 = r1; r1 = r2;
		q = gf2invsub1(r0,r1,&r2); 
	}
	return( gf2invsub2(t2,G) );
}
 
/*c
	gf2invsub1 ist ein Unterprogramm zu gf2inv,
	abgelegt als static modul.
	a, b sind Polynome aus Z/2Z[X], dargestellt in spezieller Bit-
	Notation (vgl. udpm2tosb).
	Berechnet werden: 
		q = a / b    in Z/2Z[X] und 
		*pr = a % b  in Z/2Z[X]. 
	Dann ist a = q * b + (*pr).
	q und *pr sind dann auch in der speziellen Bit-Darstellung. 
    VORSICHT: a wird dabei veraendert !!
c*/
/*H
	Version 1    	 06.03.1992	A.Stein
H*/

static obj gf2invsub1(a,b,pr)
obj a, b;
obj *pr;
{
	if ( !a || ( lfirst(a) < lfirst(b) ) ) { *pr = a ; return(0);}
   {
	single na, nb, nq, n1, fq, i, f, g, u, d;
	obj a1, q, q1, b1;
	list A;

	bind(a,b);
	init(q,A,b1);

	na = lfirst(a);
	nb = lfirst(b); 
	nq = na - nb;
	i = nq / 30;
	for( q=list1(0); i--; ) q = lcomp(0,q);

    /*	b wird unter c geschoben, d.h. b := b * x^(nq)	*/
	
	n1 = nq / 30; 
	for( A=_0; n1--; A=lcomp(0,A) );
	i = nq % 30;
	b1 = list2( i, (1<<i) );
	b = gf2invsub3(b,b1);     
	lsfirst(b,na);
	a1 = llast(b);
	lsred(a1,A); 
 
    /*  Vorbereitung der Haupt-Schleife   */
	
	n1 = (nb/30) + 1;
	a = lred(a); 
	i = nq % 30;
        g = ( 1 << i ); 
	fq = 0;
	q1 = q; 

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
                  	g >>= 1;
			if( !g ) {
				lsfirst(q1,fq); 
				q1 = lred(q1);
				fq = 0;
				g = ( 1 << 29 );
			}
		}                               
		b = lcomp(na,b);   
		fq ^= g;                           

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
		if( a == _0 ) { a = 0; break; }
		else for( f>>=1; f; f>>=1, na++ );
	}
	if( q1 != _0 ) lsfirst(q1,fq);
	*pr = ( a ) ? ( lcomp(na,a) ) : ( 0 );
	return( lcomp(nq,q) );
   }
}

/*c
	gf2invsub2 ist ein Unterprogramm zu gf2inv,
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

static obj gf2invsub2(a,b)
obj a, b;
{
	if ( !a || ( lfirst(a) < lfirst(b) ) ) return( a );
   {
	single na, nb, n1, i, f, g, u, d;
	obj a1, b1;
	list A;

	bind(a,b);
	init(A,b1);

	na = lfirst(a);
	nb = lfirst(b); 

    /*	b wird unter c geschoben, d.h. b := b * x^(nq)	*/
	
	i = na - nb;
	n1 = i / 30; 
	for( A=_0; n1--; A=lcomp(0,A) );
	i %= 30;
	b1 = list2( i, (1<<i) );
	b = gf2invsub3(b,b1);        /* b = b * x^i  in Z/2Z[X] */
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
	gf2invsub3 ist ein Unterprogramm zu gf2inv,
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

static obj gf2invsub3(a,b)
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
