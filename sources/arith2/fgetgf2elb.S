/*M
.SH NAME
fgetgf2elb - get Galois-field with characteristic 2 element, bit

.SH SYNOPSIS
.nf
#include<_arith2.h>

gf2el fgetgf2elb(G,pf)  
obj G; 
FILE *pf; 


.SH DESCRIPTION
fgetgf2elb() returns the element of GF(2^n) read in bitwise notation
from the file *pf, or ERROR in case an error occurs.
The sequence of zeroes and ones read from the input file
is interpreted as the coefficients of a polynomial in Z/2Z.
For example the string 100101 represents the polynomial x^5 + x^2 + 1.
The result is a univariate polynomial over Z/2Z of degree <n
in special bit notation which is reduced modulo G.

.PP
.TP 4
.B G
is an irreducible, monic, univariate polynomial 
over Z/2Z of degree n >= 1 in the special
bit representation. G can be interpreted as a
generating polynomial of GF(2^n).
M*/
/*H
	Version 1       24.10.1995	U.Schneiders
   DATE fgetgf2elb :    951201
H*/

#include <_arith2.h>

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
	init(c,cS,cSS,aS);

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
	init(a1,b1,A);

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

gf2el fgetgf2elb(G,pf)
obj G;
FILE *pf;
{
	single  c=fgetcs(pf);
	bind(G);

	if ( !isdigit(c) || (c-'0') > 1 ) 
	{	errmsgio( "fgetgf2elb", "EA015" );
		return( ERROR );
	}

        /***    Null    ***/
	while ( c=='0' )  c = getc( pf );
	if ( !isdigit(c) )  
	{	ungetc( c,pf );
		return( 0 );
	}

	else
        /***    nicht Null    ***/
	{
		single  m, n=0, i=0, z=0;
		gf2el N;
		list  L;
		init(N,L);
		L = _0; N = 0;
		do 
		{	if( (c-'0') > 1 )
			{	errmsgio( "fgetbits", "EA015" );
				return( ERROR );
			}
			z++;
			n = 2*n + c-'0';
			if( ++i == BLOG2 ) L = lcomp( n,L ),  n=i=0;
		} while ( isdigit( c=getc(pf) ) );

		ungetc( c,pf );
		L = linv(L);
		while ( L!=_0 )  
                {       N = ip2prod( N,BLOG2 );
                        m = lfirst( L ),  L = lred( L );
                        N = isum( N,m );
                }
                if ( N!=0 )  N = ip2prod( N, i );
                N = isum( N,n );

		z--;
		if( isatom(N) )  N = list2( z, N);
		else		 N = linv(N), N = lcomp( z, N);

	        N = udpm2togf2s1(N,G); 
		return(N);
	}
}
