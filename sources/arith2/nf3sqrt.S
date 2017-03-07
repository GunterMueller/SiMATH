/*M
.SH NAME
nf3sqrt - number field of degree 3 square root

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel nf3sqrt(F, el)  
pol F; 
nfel el;

.SH DESCRIPTION
.TP 4
.B F
is an irreducible, monic and univariate polynomial in dense representation over Z of degree 3. F generates a number field, say K.
.TP 4
.B el
is an element of K (for representation of number field elements s. nfneg). 
.PP
For el beeing a square in K, nf3sqrt returns the square root of el, else nfsqrt returns the empty list.

.SH SEE ALSO
nfneg

M*/                  

/*H
	Version 1	20.08.1991	Th. Weis
   DATE nf3sqrt       : 921130
H*/

#include <_arith2.h>

nfel nf3sqrt(F,el)
pol  F;
nfel el;
{
/*
 * Deklaration, Binden & Initialisieren - Anfang
 */
  pol chP;
  rat N;

  bind(F,el);
  init(chP,N);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * el = 0  - Anfang
 */
  if ( el == 0 ) return(0);
/*
 * el = 0  - Ende
 * Berechnung des charakteristischen Polynoms von el( != 0 )
 * chP = x^3 - S*x^2 - Q*x - N   - Anfang
 */
  chP = nf3chpol(F,el);
  chP = ptodp(1,chP);
/*
 * Berechnung des charakteristischen Polynoms - Ende
 * Berechnung der Koeffizienten des charakteristischen
 * Polynoms der Wurzel, falls sie existiert  - Anfang
 */
  N = rneg(lfifth(chP));
/*
 * Berechnung von n & 1.Test, ob el ein Quadrat in k ist - Anfang
 */
  if ( rsign(N) == 1 )
  {
    /* Deklaration */
    int nz,nn;
    rat n,nq;
    /* Deklaration - Ende */
    /* Initialisierung */
    init(nz,nn,n,nq);
    /* Initialisierung - Ende */

    nz = isqrt(lfirst(N)); nn = isqrt(lsecond(N));
    n = list2(nz,nn);      nq = rexp(n,2);

    if ( rdif(N,nq) == 0 )
/*
 * Brechnung von n & 1. Test - Ende
 */
    {
/*
 * Berechnung von s & 2. Test, ob el ein Quadrat in k ist - Anfang
 */
      /* Deklaration */
      single i,l,exp;
      rat    S,Sq,Q,s;
      rat    cf[5];
      pol    Ps;
      list   PsFL,HL; 
      /* Deklaration - Ende */
      /* Initialisierung */
      init(S,Sq,Q,s);
      init(cf[0..4]);
      init(Ps,PsFL,HL);
      /* Initialisierung - Ende */

      S = rneg(lthird(chP)); Sq = rexp(S,2);
      Q = rneg(lfourth(chP));

/*
 * s muss eine rationale Nullstelle des Polynoms
 * Ps = s^4 - 2*S*s^2 - 8*n*s + S^2 + 4*Q  sein
 * Erstelle Ps, faktorisiere und suche Nullstelle
 */
      cf[4] = list2(1,1);
      cf[3] = _0;
      cf[2] = rprod(list2((-2),1),S);
      cf[1] = rprod(list2((-8),1),n);
      cf[0] = rprod(list2(4,1),Q); cf[0] = rsum(cf[0],Sq);

      Ps = _0;
      for ( i=0; i<=4; i++ )
      {
        if ( cf[i] != _0 && cf[i] != 0 )  Ps = lcomp2(i,cf[i],Ps);
      }

      PsFL = uprfact(Ps);

      PsFL = lred(PsFL);
      do
      {
	HL = lfirst(PsFL); l = llength(HL);
	exp = lsecond(PsFL);
	if ( ( l == 2 || l == 4 ) && exp == 1 )
	{
	  if ( l == 2 )  s = 0;
	  else
	  {
	    /* Deklaration */
	    int sz,sn;
	    /* Deklaration - Ende */
	    /* Initialisierung */
	    init(sz,sn);
	    /* Initialisierung - Ende */

	    sz = lfourth(HL); sz = ineg(sz);
	    sn = lsecond(HL);
	    s = list2(sz,sn);
	  }
	  break;
	}
	else s = _0;
	PsFL = lred2(PsFL);
      }
      while ( PsFL != _0 );

      if ( s != _0 )
/*
 * Berechnung von s & 2. Test - Ende
 */
      {
/*
 * Berechnung von n - Anfang
 */
	/* Deklaration */
	int  zwel,nwel,FD,PwD,pQ;
	rat  zwei,sq,q;
	pol  Pw;
	list PwFL;
	nfel wel;
	/* Deklaration - Ende */
	/* Initialisierung */
	init(zwel,nwel,FD,PwD,pQ);
	init(zwei,sq,q);
	init(Pw);
	init(PwFL);
	init(wel);
	/* Initialisierung - Ende */

	zwei = list2(2,1);
	sq = rexp(s,2);

	q = rdif(S,sq); q = rquot(q,zwei);
/*
 * Berechnung von n - Ende
 * Erstellen des Polynoms der Quadratwurzel
 * Pw = y^3 - s*y^2 - q*y - n   - Anfang
 */
	s = rneg(s); q = rneg(q); n = rneg(n);

        Pw = _0;
	Pw = lcomp2(0,n,Pw);
	if ( q != 0 )  Pw = lcomp2(1,q,Pw);
	if ( s != 0 )  Pw = lcomp2(2,s,Pw);
	Pw = lcomp2(3,list2(1,1),Pw);
/*
 * Erstellen von Pw - Ende
 * Berechnung der Koeffizienten des charakteristischen
 * Polynoms der Wurzel, falls sie existiert - Ende
 * Berechnung der Darstellung von Pw bzgl. F - Anfang
 */
	Pw = cdprfupr(Pw);
	Pw = lred(Pw);
	PwFL = upifact(Pw);
	if ( lthird(PwFL) == 3 )
	{
	  zwel = lfourth(lsecond(PwFL)); zwel = ineg(zwel);
	  nwel = lsecond(lsecond(PwFL));
	  wel = list3(nwel,0,zwel);
	}
	else
	{
	  Pw = ptodp(1,Pw);
	  wel = isnf3eqnf3(F,Pw,&FD,&PwD,&pQ);
	}
/*
 * Berechnung der Darstellung - Ende
 * Rueckgabe, falls Wurzel existiert
 */
	return(wel);
      }
    }
  }
/*
 * Rueckgabe, falls Wurzel nicht existiert
 */
  return(_0);
}
