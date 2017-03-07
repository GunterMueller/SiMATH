/*M
.SH NAME
iqrem_2 - integer quotient and remainder, old version

.SH SYNOPSIS
.nf
#include<_arith1.h>

int iqrem_2(A,B,pQ,pR)
int A,B,*pQ,*pR;

.SH DESCRIPTION
iqrem_2()
calculates the integers *pQ = A / B and *pR = A - (*pQ) * B
for B!=0 and returns 0.
As opposed to iqrem(), iqrem_2() uses no memory apart
from SIMATH lists.
M*/

/*H
	Version  1      11.11.1991	Marc Conrad (altes iqrem)
   DATE iqrem_2       : 911215.9203__
H*/

/* Im Gegensatz zur neuen schnellen Version iqrem wird hier kein */
/* Speicherplatz ausserhalb der gc-Listenverwaltung benutzt.     */

# include <_arith1.h>

int iqrem_2 ( A, B, pQ, pR )
int  A, B, *pQ, *pR;
{
    int l1, l2;
/***    Sonderfaelle    ***/
    if ( isatom(B) )  return(isqrem(A,B,pQ,pR));
    if ( isatom(A) || (l1=llength(A)) < (l2=llength(B)) )  {
	    *pQ = 0,  *pR = A;
	    return( 0 );
    }
/***    allgemeiner Fall    ***/
    {
	register i;
	single  a,a0,a1,a2, b,b0,b1, c0,c1,c2, d, q,r, s1,s2,u;
	list  A1,A2,A3, Alf,Blf, H, Q,R;
	init(A1); init(Q);
	init(A2);
	bind(A); bind(B);
    /***    Vorzeichen und Normalisieren    ***/
	s1 = isign( A );
	b = lfirst( llast(B) );
	s2 = ssign( b );
	d = BASIS / (sabs(b)+1);
	A = isprod( A, s1*d );
	B = isprod( B, s2*d );
    /***    Aufteilung des Dividenden A    ***/
	A1 = A;
	A2 = Q = _0;
	for  ( i=l1-l2 ; i-- ; A1 = lred(A1) )
		A2 = lcomp( lfirst(A1), A2 );
    /***    hoechste Komponenten des Divisors B    ***/
	Blf = lreduct( B,l2-2 );
	b0 = lfirst( Blf ),  b1 = lsecond( Blf );
    /***    Schleife fuer komponentenweisen Aufbau des Quotienten    ***/
	do {
	    /***    hoechste Komponenten des aktuellen Dividenden A1    ***/
		Alf = lreduct( A1,l2-2 );
		a0 = lfirst( Alf ),  a1 = lsecond( Alf );
		if ( (Alf=lred2(Alf)) == _0 )  a2 = 0;
		else  a2 = lfirst( Alf );
	    /***    q als angenaeherte Komponente des Quotienten    ***/
		if (a2 == b1)  q = BASIS-1;
		else  sqrem( a2,a1,b1, &q,&r );
		do {    sprod( b0,q, &c1,&c0 );
			sprod( b1,q, &c2,&u );
			c1 += u;
			if ( c1>=BASIS )  c1 -= BASIS, c2++;
			if ( (u=a2-c2) == 0 )
				if ( (u=a1-c1) == 0 )  u = a0-c0;
			q--;
		}
		while ( u<0 );
		q++;
		do {
	    /***    A1 - q*B    ***/
			Alf = A1,  Blf = B;
			A3 = _0,  u = 0;
			for ( i=l2 ; i-- ; A3 = lcomp(a,A3) )  {
				b = lfirst( Blf ),  Blf = lred( Blf );
				sprod( b,q, &c2,&c1 );
				a = lfirst( Alf ),  Alf = lred( Alf );
				a-=u,  a-=c1,  u=c2;
				while ( a<0 )  a += BASIS,  u++;
			}
			if  ( Alf==_0 )  a=0;
			else  a = lfirst( Alf );
			a -= u;
	    /***    ggf. q korrigieren    ***/
			q--;
		}
		while ( a<0 );
	    /***    Komponente fuer Q und neuer Dividend    ***/
		q++;
		A1 = linv( A3 );
		if ( Q!=_0 || q!=0 )  Q = lcomp( q,Q );
		if ( i = A2!=_0 )  {
			A1 = lcomp( lfirst(A2), A1 );
			A2 = lred( A2 );
		}
	    /***    Schleifenende    ***/
	}
	while ( i );
    /***    Aufbereitung von Quotient und Rest    ***/
	if  ( Q==_0 )  Q = 0;
	else if ( lred(Q) == _0 )  Q = lfirst(Q);
	for ( H=0, Alf=A1 ; Alf!=_0 ; Alf = lred(Alf) )
		if ( lfirst(Alf) != 0 )  H = Alf;
	if  ( H==0 )  R = 0;
	else {  lsred( H,_0 );
		if ( lred(A1) != _0 )  R = A1;
		else  R = lfirst( A1 );
	}
    /***    Vorzeichen und Normalisieren    ***/
	if ( s1*s2 != 1 )  Q = ineg( Q );
	*pQ = Q;
	isqrem( R,s1*d, pR,&H );
    }
    return( 0 );
}
