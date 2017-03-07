/*C
			calc_GF2bit( fkeller )

	"calculator Galois-field characteristic 2, bit representation".
	list calc_GF2bit(fkeller); list fkeller;
	L = calc_GF2bit( fkeller );

	fkeller ist eine Liste bestehend aus einem Galois-Feld Element
	in Charakteristik 2 in spezieller bit-Notation, d.h.
	fkeller = 0, 1 oder ( degr, zahl).
	fkeller wird reduziert modulo dem GF erzeugenden Polynom.
	L = ( fkeller aufgefasst ueber GF, 31 ).
	Laeuft calc_GF2bit fehlerhaft ab, so ist L = -BASIS.
	Der include-file <_calc.h> wird benoetigt.
C*/
/*H
	Version 1	24.10.1995	S.Schmitt/U.Schneiders
H*/
 
#include <_calc.h>

/*c
	udpm2togf2c2 ist ein Unterprogramm zu udpm2togf2el,
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

static obj udpm2togf2c2(a,b)
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

/*c
	udpm2togf2c1 ist ein Unterprogramm zu udpm2togf2el,
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

static obj udpm2togf2c1(a,b)
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
	b = udpm2togf2c2(b,b1);        /* b = b * x^i  in Z/2Z[X] */
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

list calc_GF2bit( fkeller )
list fkeller;
{
	list F;
	init(F);
	bind( fkeller );

	if( !gfsch )
	{       mistake( 260 );
		return( ERROR );
	} 
	if( gfchar!=2 )
	{       mistake( 257 );
		return( ERROR );
	} 

	if( !isatom( fkeller ) )  
	{       F = lfirst( varlist[gfsch].varwert );
		fkeller = udpm2togf2c1(fkeller,F);
	}
	fkeller = list2( fkeller, 31 );
	return( fkeller );
}
