/*M
.SH NAME
isnf3eqnf3 - is number field of degree 3 equal to number field of degree 3

.SH SYNOPSIS
.nf
#include<_arith2.h>

nfel isnf3eqnf3(F, P, pFD, pPD, pQ)  
pol F, P; 
int *pFD, *pPD, *pQ;
 
.SH DESCRIPTION
.TP 4
.B F
is a monic, irreducible and univariate polynomial of degree 3 over the integer numbers in dense representation.
.TP 4
.B P
is an irreducible and univariate polynomial of degree 3 over the integer numbers in dense representation.
.PP
isnf3eqnf3 writes the polynomial discriminant of F, P to *pFD, *pPD, respectively. 
.PP
Furthermore, if F and P generate the same number field, isnf3eqnf3 returns the representation of P with regard to the number field's basis generated by F (and the empty list else). In that case, isnf3eqnf3 also writes the square factor, *pFD and *pPD differs from, to *pQ (*pQ = 0 else).
 
.SH CAUTION
isnf3eqnf3 does not work, if both F and P are given by purely cubic equations, e.g. for F = x^3 - 5 and P = y^3 + 4, isnf3eqnf3 does not give a result.
 
M*/
                                 
/*H
	Version 1	20.08.1991	Th. Weis
   DATE isnf3eqnf3    : 921130
H*/

#include <_arith2.h>

static list issnf3(int,int,int,int,int,int,int);

nfel isnf3eqnf3(F,P,pFD,pPD,pQ)
pol  F,P;
int  *pFD,*pPD,*pQ;
{
/*
 * Deklaration, Binden & Initialisieren - Anfang
 */
  single SCH1,SCH2;
  int    k10,k11,k12,k13; /* Koeffizienten der Uebergabepolynome F */
  int    k20,k21,k22,k23; /* und P				 */
  int    k10q,k11q,k11h3,k12q,k12h3,k13q;
  int    k20q,k21q,k21h3,k22q,k22h3,k23q;
  int    hk;
  int    q1,q2,n1,n2;
  int    hq1,hq2,hn1,hn2;
  int    D1,D11,Q1,D2,D21,Q2;
  int    Dsf1,Dsf11,Qsf1,Dsf2,Dsf21,Qsf2;
  int    h0D1,h1D1,h0D2,h1D2;
  int    hQ,phQ,pR;
  rat  alpha,beta,gamma;
  rat  kTp0,kTp1,kTp2,hkTp; 
  list Tp;

  bind(F,P);
  init(k10,k11,k12,k13);
  init(k20,k21,k22,k23);
  init(k10q,k11q,k11h3,k12q,k12h3,k13q);
  init(k20q,k21q,k21h3,k22q,k22h3,k23q);
  init(hk);
  init(q1,q2,n1,n2);
  init(hq1,hq2,hn1,hn2);
  init(D1,D11,Q1,D2,D21,Q2);
  init(Dsf1,Dsf11,Qsf1,Dsf2,Dsf21,Qsf2);
  init(h0D1,h1D1,h0D2,h1D2);
  init(hQ,phQ,pR);
  init(alpha,beta,gamma);
  init(kTp0,kTp1,kTp2,hkTp);
  init(Tp);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Vorbesetzen - Anfang
 */
  k13 = lsecond(F);			    k23 = lsecond(P);
  k12 = lthird(F);  k12 = ineg(k12);        k22 = lthird(P);  k22 = ineg(k22);
  k11 = lfourth(F); k11 = ineg(k11);        k21 = lfourth(P); k21 = ineg(k21);
  k10 = lfifth(F);  k10 = ineg(k10);        k20 = lfifth(P);  k20 = ineg(k20);

   k10q = iexp(k10,2);                        k20q = iexp(k20,2);
   k11q = iexp(k11,2); k11h3 = iexp(k11,3);   k21q = iexp(k21,2); k21h3 = iexp(k21,3);
   k12q = iexp(k12,2); k12h3 = iexp(k12,3);   k22q = iexp(k22,2); k22h3 = iexp(k22,3);
   k13q = iexp(k13,2);			      k23q = iexp(k23,2);
/*
 * Vorbesetzen - Ende
 * Fallunterscheidung - Anfang
 */
  if ( k13 == 1 )
  {
    if ( k12 == 0 )
    {
      if ( k23 == 1 )
      {
	if ( k22 == 0 ) { SCH1 = 1; SCH2 = 1; }
                        /* x^3 = k11*x + k10; u^3 = k21*u + k20 */
	else { SCH1 = 1; SCH2 = 2; }
	     /* x^3 = k11*x + k10; u^3 = k22*u^2 + k21*u + k20 */
      }
      else
      {
	if ( k22 == 0 ) { SCH1 = 1; SCH2 = 3; }
			/* x^3 = k11*x + k10; k23*u^3 = k21*u + k20 */
	else { SCH1 = 1; SCH2 = 4; }
	     /* x^3 = k11*x + k10; k23*u^3 = k22*u^2 + k21*u + k20 */
      }
    }
    else
    {
      if ( k23 == 1 )
      {
	if ( k22 == 0 ) { SCH1 = 2; SCH2 = 1; }
                        /* x^3 = k12*x^2 + k11*x + k10; u^3 = k21*u + k20 */
	else { SCH1 = 2; SCH2 = 2; }
	     /* x^3 = k12*x^2 + k11*x + k10; u^3 = k22*u^2 + k21*u + k20 */
      }
      else
      {
	if ( k22 == 0 ) { SCH1 = 2; SCH2 = 3; }
			/* x^3 = k12*x^2 + k11*x + k10; k23*u^3 = k21*u + k20 */
	else { SCH1 = 2; SCH2 = 4; }
	     /* x^3 = k12*x^2 + k11*x + k10; k23*u^3 = k22*u^2 + k21*u + k20 */
      }
    }
  }
  else
  {
    if ( k12 == 0 )
    {
      if ( k23 == 1 )
      {
	if ( k22 == 0 ) { SCH1 = 3; SCH2 = 1; }
                        /* k13*x^3 = k11*x + k10; u^3 = k21*u + k20 */
	else { SCH1 = 3; SCH2 = 2; }
	     /* k13*x^3 = k11*x + k10; u^3 = k22*u^2 + k21*u + k20 */
      }
      else
      {
	if ( k22 == 0 ) { SCH1 = 3; SCH2 = 3; }
			/* k13*x^3 = k11*x + k10; k23*u^3 = k21*u + k20 */
	else { SCH1 = 3; SCH2 = 4; }
	     /* k13*x^3 = k11*x + k10; k23*u^3 = k22*u^2 + k21*u + k20 */
      }
    }
    else
    {
      if ( k23 == 1 )
      {
	if ( k22 == 0 ) { SCH1 = 4; SCH2 = 1; }
                        /* k13*x^3 = k12*x^2 + k11*x + k10; u^3 = k21*u + k20 */
	else { SCH1 = 4; SCH2 = 2; }
	     /* k13*x^3 = k12*x^2 + k11*x + k10; u^3 = k22*u^2 + k21*u + k20 */
      }
      else
      {
	if ( k22 == 0 ) { SCH1 = 4; SCH2 = 3; }
			/* k13*x^3 = k12*x^2 + k11*x + k10; k23*u^3 = k21*u + k20 */
	else { SCH1 = 4; SCH2 = 4; }
	     /* k13*x^3 = k12*x^2 + k11*x + k10; k23*u^3 = k22*u^2 + k21*u + k20 */
      }
    }
  }
/*
 * Fallunterscheidung - Ende
 * Berechnung der Diskriminanten von P1 und P2 - Anfang
 * Berechnung der Diskriminante von P1 - Anfang
 */
  switch( SCH1 )
  {
    case 1: D1 = isprod(k10q,(-27));
	     hk = isprod(k11h3,4);
	    D1 = isum(D1,hk);
	    *pFD = D1;
	    break;
    case 2: D1 = isprod(k10q,(-27));
	     hk = isprod(k12,(-18)); hk = iprod(hk,k11); hk = iprod(hk,k10);
	    D1 = isum(D1,hk);
	     hk = isprod(k11h3,4);
            D1 = isum(D1,hk);
       	     hk = isprod(k12h3,(-4)); hk = iprod(hk,k10);
            D1 = isum(D1,hk);
	     hk = iprod(k12q,k11q);
            D1 = isum(D1,hk);
            *pFD = D1;
	    break;
    case 3: D1 = isprod(k10q,(-27)); D1 = iprod(D1,k13q);
	     hk = isprod(k11h3,4); hk = iprod(hk,k13);
	    D1 = isum(D1,hk);
	    *pFD = D1;
	    break;
    case 4: D1 = isprod(k10q,(-27)); D1 = iprod(D1,k13q);
	     hk = isprod(k13,(-18)); hk = iprod(hk,k12); hk = iprod(hk,k11); hk = iprod(hk,k10);
	    D1 = isum(D1,hk);
	     hk = isprod(k11h3,4); hk = iprod(hk,k13);
            D1 = isum(D1,hk);
       	     hk = isprod(k12h3,(-4)); hk = iprod(hk,k10);
            D1 = isum(D1,hk);
	     hk = iprod(k12q,k11q);
            D1 = isum(D1,hk);
            *pFD = D1;
	    break;
    default: exit(1);
  }
/*
 * Berechnung der Diskriminante von P1 - Ende
 * Berechnung der Diskriminante von P2 - Anfang
 */
  switch( SCH2 )
  {
    case 1: D2 = isprod(k20q,(-27));
	     hk = isprod(k21h3,4);
	    D2 = isum(D2,hk);
	    *pPD = D2;
	    break;
    case 2: D2 = isprod(k20q,(-27));
	     hk = isprod(k22,(-18)); hk = iprod(hk,k21); hk = iprod(hk,k20);
	    D2 = isum(D2,hk);
	     hk = isprod(k21h3,4);
            D2 = isum(D2,hk);
       	     hk = isprod(k22h3,(-4)); hk = iprod(hk,k20);
            D2 = isum(D2,hk);
	     hk = iprod(k22q,k21q);
            D2 = isum(D2,hk);
            *pPD = D2;
	    break;
    case 3: D2 = isprod(k20q,(-27)); D2 = iprod(D2,k23q);
	     hk = isprod(k21h3,4); hk = iprod(hk,k23);
	    D2 = isum(D2,hk);
	    *pPD = D2;
	    break;
    case 4: D2 = isprod(k20q,(-27)); D2 = iprod(D2,k23q);
	     hk = isprod(k23,(-18)); hk = iprod(hk,k22); hk = iprod(hk,k21); hk = iprod(hk,k20);
	    D2 = isum(D2,hk);
	     hk = isprod(k21h3,4); hk = iprod(hk,k23);
            D2 = isum(D2,hk);
       	     hk = isprod(k22h3,(-4)); hk = iprod(hk,k20);
            D2 = isum(D2,hk);
	     hk = iprod(k22q,k21q);
            D2 = isum(D2,hk);
            *pPD = D2;
	    break;
    default: exit(1);
  }
/*
 * Berechnung der Diskriminante von P2 - Ende
 * Berechnung der Polynomdiskriminanten - Ende
 * Berechnung des quadratfreien Anteils der Diskriminanten - Anfang
 */
  D11 = isfp(D1);
  D21 = isfp(D2);
/*
 * Berechnung des quadratfreien Anteils der Diskriminanten - Ende
 * 1. Test, ob gleicher Zahlkoerper - Anfang
 * D.h.: Untersuche, ob sich die Polynomdisk. um einen quadrat. Faktor unterscheiden
 */
  if ( icomp(D11,D21) == 0 )
  {
/*
 * Berechnung des quadratischen Faktors - Anfang
 */
    Q1 = iquot(D1,D11);
    Q2 = iquot(D2,D21);
    if ( icomp(Q1,Q2) >= 0 )
    {
      iqrem(Q1,Q2,&phQ,&pR);
      if ( pR == 0 ) *pQ = phQ;
      else
      {
	*pQ = 0;
	Tp = _0;
	return(Tp);
      }
    }
    else
    {
      iqrem(Q2,Q1,&phQ,&pR);
      if ( pR == 0 ) *pQ = phQ;
      else
      {
	*pQ = 0;
	Tp = _0;
	return(Tp);
      }
    }
/*
 * Berechnung des quadratischen Faktors - Ende
 * Berechnung der qi und ni i=1,2 - Anfang
 *  q1,n1 - Anfang
 */
    switch( SCH1 )
    {
      case 1: q1 = k11;
	      n1 = k10;
              break;
      case 2: q1 = isprod(k12q,3);
	       hq1 = isprod(k11,9); 
    	      q1 = isum(q1,hq1);
              n1 = isprod(k12h3,2);
	       hn1 = isprod(k12,9); hn1 = iprod(hn1,k11);
	      n1 = isum(n1,hn1);
               hn1 = isprod(k10,27);
              n1 = isum(n1,hn1);
 	      break;
      case 3: q1 = iprod(k13,k11);
	      n1 = iprod(k13q,k10);
	      break;
      case 4: q1 = isprod(k12q,3);
	       hq1 = isprod(k13,9); hq1 = iprod(hq1,k11); 
    	      q1 = isum(q1,hq1);
              n1 = isprod(k12h3,2);
	       hn1 = isprod(k13,9); hn1 = iprod(hn1,k12); hn1 = iprod(hn1,k11);
	      n1 = isum(n1,hn1);
               hn1 = isprod(k13q,27); hn1 = iprod(hn1,k10);
              n1 = isum(n1,hn1);
 	      break;
       default: exit(1);
     }
/*
 *  q1,n1 - Ende
 *  q2,n2 - Anfang
 */
    switch( SCH2 )
    {
      case 1: q2 = k21;
	      n2 = k20;
              break;
      case 2: q2 = isprod(k22q,3);
	       hq2 = isprod(k21,9); 
    	      q2 = isum(q2,hq2);
              n2 = isprod(k22h3,2);
	       hn2 = isprod(k22,9); hn2 = iprod(hn2,k21);
	      n2 = isum(n2,hn2);
               hn2 = isprod(k20,27);
              n2 = isum(n2,hn2);
 	      break;
      case 3: q2 = iprod(k23,k21);
	      n2 = iprod(k23q,k20);
	      break;
      case 4: q2 = isprod(k22q,3);
	       hq2 = isprod(k23,9); hq2 = iprod(hq2,k21); 
    	      q2 = isum(q2,hq2);
              n2 = isprod(k22h3,2);
	       hn2 = isprod(k23,9); hn2 = iprod(hn2,k22); hn2 = iprod(hn2,k21);
	      n2 = isum(n2,hn2);
               hn2 = isprod(k23q,27); hn2 = iprod(hn2,k20);
              n2 = isum(n2,hn2);
 	      break;
       default: exit(1);
     }
/*
 *  q2,n2 - Ende
 * Berechnung der qi und ni i=1,2 - Ende
 * Berechnung der Diskriminanten der kurzen Polynome - Anfang
 */
	h0D1 = iexp(q1,3); h0D1 = isprod(h0D1,4);
	h1D1 = iexp(n1,2); h1D1 = isprod(h1D1,(-27));
    Dsf1 = isum(h0D1,h1D1);

	h0D2 = iexp(q2,3); h0D2 = isprod(h0D2,4);
	h1D2 = iexp(n2,2); h1D2 = isprod(h1D2,(-27));
    Dsf2 = isum(h0D2,h1D2); *pPD = D2;
/*
 * Berechnung der Diskriminanten der kurzen Polynome - Ende
 * Berechnung des quadratischen Anteils der Diskriminanten der kurzen Polynome - Anfang
 */
    Dsf11 = isfp(Dsf1); Qsf1 = iquot(Dsf1,Dsf11);
    Dsf21 = isfp(Dsf2); Qsf2 = iquot(Dsf2,Dsf21);
/*
 * Berechnung des quadratischen Anteils der Diskriminanten der kurzen Polynome - Ende
 * 2. Test, ob gleicher Zahlkoerper - Anfang
 * D.h.: Berechne die Transformationsfunktion PHI(z) = alpha*z^2 + beta*z + gamma
 * siehe dazu Delone & Faddeev Seite 95ff
 */
    Tp = _0;
    Tp = issnf3(q1,n1,q2,n2,Dsf11,Qsf1,Qsf2);
/*
 * 2. Test, ob gleicher Zahlkoerper - Ende
 * Umkehrung der Transformationen der beiden Polynome an der Transformationsfunktion - Anfang
 */
    if ( Tp != _0 )
    {
	alpha = lfirst(Tp); beta = lsecond(Tp); gamma = lthird(Tp);

      switch( SCH1 )
      {
	case 1: kTp2 = alpha;
	        kTp1 = beta;
	        kTp0 = gamma;
		break;
	case 2: kTp2 = rprod(list2(9,1),alpha);
	        kTp1 = rprod(list2((-6),1),alpha); kTp1 = rprod(itor(k12),kTp1);
	         hkTp = rprod(list2(3,1),beta);
                kTp1 = rsum(kTp1,hkTp);
		kTp0 = rprod(itor(k12q),alpha);
		 hkTp = rneg(beta); hkTp = rprod(itor(k12),hkTp);
                kTp0 = rsum(kTp0,hkTp);
                kTp0 = rsum(kTp0,gamma);
		break;
	case 3: kTp2 = rprod(itor(k13q),alpha);
		kTp1 = rprod(itor(k13),beta);
		kTp0 = gamma;
		break;
	case 4: kTp2 = rprod(list2(9,1),alpha); kTp2 = rprod(itor(k13q),kTp2);
	        kTp1 = rprod(list2((-6),1),alpha); kTp1 = rprod(itor(k12),kTp1);
		kTp1 = rprod(itor(k13),kTp1);
	         hkTp = rprod(list2(3,1),beta); hkTp = rprod(itor(k13),hkTp);
                kTp1 = rsum(kTp1,hkTp);
		kTp0 = rprod(itor(k12q),alpha);
		 hkTp = rneg(beta); hkTp = rprod(itor(k12),hkTp);
                kTp0 = rsum(kTp0,hkTp);
                kTp0 = rsum(kTp0,gamma);
		break;
        default: exit(1);
       }

       switch( SCH2 )
       {
         case 1: break;
         case 2: kTp2 = rprod(list2(1,3),kTp2);
		 kTp1 = rprod(list2(1,3),kTp1);
		 kTp0 = rsum(itor(k22),kTp0); kTp0 = rprod(list2(1,3),kTp0);
		 break;
         case 3: hkTp = itor(k23); hkTp = rinv(hkTp);
		 kTp2 = rprod(hkTp,kTp2);
		 kTp1 = rprod(hkTp,kTp1);
		 kTp0 = rprod(hkTp,kTp0);
		 break;
         case 4: hkTp = itor(k23); hkTp = rprod(list2(3,1),hkTp); hkTp = rinv(hkTp);
		 kTp2 = rprod(hkTp,kTp2);
		 kTp1 = rprod(hkTp,kTp1);
		 kTp0 = rsum(itor(k22),kTp0); kTp0 = rprod(hkTp,kTp0);
		 break;
         default: exit(1);
      } 
/*
 * Erstellen von Tp - Anfang
 */
      Tp = _0;
      if ( kTp0 != 0 ) Tp = lcomp2(0,kTp0,Tp);
      if ( kTp1 != 0 ) Tp = lcomp2(1,kTp1,Tp);
      if ( kTp2 != 0 ) Tp = lcomp2(2,kTp2,Tp);

      Tp = ptodp(1,Tp);
      Tp = udprtonfel(Tp);
/*
 * Erstellen von Tp - Ende
 */
    }
/*
 * Umkehrung der Transformationen der beiden Polynome an der Transformationsfunktion - Ende
 */
  }
  else
  {
    *pQ = 0;
    Tp = _0;
  }
/*
 * 1. Test, ob gleicher Zahlkoerper - Ende
 */
  return(Tp);
}



/*c
		issnf3( q1, n1, q2, n2, D11, Q1, Q2 )

	"is same number field of degree 3"
	static list issnf3(q1,n1,q2,n2,D11,Q1,Q2)  int q1,n1,q2,n2,D11,Q1,Q2;
	Tp = issnf3(q1,n1,q2,n2,D11,Q1,Q2);
	Vorgehensweise wie in:
	  The Theory of Irrationalities  of the Third Degree
	von B.N. Delone und D.K. Faddeev
	  Kapitel II, Paragraph 13, Seite 95-97
	wobei: q1 = q, n1 = n,
	       q2 = q_quer, n2 = n_quer,
	       D11 = D1,
	       Q1 = DELTA^2, Q2 = DELTA_quer^2.
	Tp ist die Liste { alpha, beta, gamma }, falls die beiden Polynome
	den gleichen Zahlkoerper erzeugen, und {} sonst.
c*/
/*H
	Version 1	20.08.1991	Th. Weis
H*/

static list issnf3(q1,n1,q2,n2,D11,Q1,Q2)
int q1,n1,q2,n2,D11,Q1,Q2;
{
/*
 * Deklaration, Binden & Initialisieren - Anfang
 */
  single SCH;
  single i,li;
  int    k[4];
  int    W1,W2;
  int    u1;
  int    H0,H1,H2,H3,H4,H5,H6;
  int    vZ,vN,v;
  list   Pu1,Pu1FL;
  list   HL0,HL1,HL2;
  list   Tp;
  rat    alpha,beta,gamma;

  bind(q1,n1,q2,n2,D11,Q1,Q2);
  init(k[0..3]);
  init(W1,W2);
  init(u1);
  init(H0,H1,H2,H3,H4,H5,H6);
  init(vZ,vN,v);
  init(Pu1,Pu1FL);
  init(HL0,HL1,HL2);
  init(Tp);
  init(alpha,beta,gamma);
/*
 * Deklaration, Binden & Initialisieren - Ende
 * Vorbesetzen - Anfang
 */
  SCH = 0;
  li  = 0;
/*
 * Vorbesetzen - Ende
 * Erstelle Polynom Pu1 ( siehe Delone && Faddeev Seite 96 (*) ) - Anfang
 */
  W1 = isqrt(Q1); W2 = isqrt(Q2);
  k[3] = D11; k[2] = 0; k[1] = ineg(iprod(q1,q2));
  H0 = iprod(W1,n2); H1 = iprod(W2,n1);
anfang:	H2 = isum(H0,H1);
  HL0 = _0;
  HL0 = rcons(H2,2);
  if ( HL0 == 0 && li <= 1 ) k[0] = 0;
  else
  if ( lsecond(HL0) == 1 && li <= 1 ) k[0] = lfirst(HL0);
  else if ( li == 0 )
  {
    H1 = ineg(H1);
    li = li+1;
    goto anfang;
  }
  else
  {
    Tp = _0;
    return(Tp);
  }
  Pu1 = _0;
  for ( i = 0; i <= 3; i++ ) if ( k[i] ) Pu1 = lcomp2(i,k[i],Pu1);
/*
 * Erstelle Polynom Pu1 ( siehe Delone & Faddeev Seite 96 (*) ) - Ende
 * Berechnung von u1 - Anfang
 */
  Pu1FL = upifact(Pu1);
  HL0 = _0;
  HL0 = lred(Pu1FL);
  do
  {
    HL1 = lfirst(HL0);
    if ( ( llength(HL1) == 4 && lfirst(HL1) == 1 && lsecond(HL1) == 1 && lsecond(HL0) != 2 ) ||
         ( llength(HL1) == 2 && lfirst(HL1) == 1 && lsecond(HL1) == 1 && lsecond(HL0) != 2 ) )
    {
      if ( llength( HL1 ) == 4 )
      {
        u1 = lfourth(HL1); u1 = ineg(u1);
      }
      else u1 = 0;
      SCH = 1;
    }
    HL0 = lred2(HL0);
  }
  while ( HL0 != _0 );
  if ( SCH == 0 )
  {
    H1 = ineg(H1);
    li = li+1;
    goto anfang;
  }
/*
 * Berechnung von u1 - Ende
 * Berechnung von alpha - Anfang
 */
  H3 = isprod(u1,3);
  alpha = rcons(H3,W1);
/*
 * Berechnung von alpha - Ende
 * Berechnung von beta - Anfang
 * Berechnung von v - Anfang
 */
  H4 = isprod(n1,(-9)); H4 = iprod(H4,q2); H4 = iprod(H4,u1);
  H5 = iexp(q1,2); H5 = iprod(H5,W2);
  if ( li == 0 ) vZ = isum(H4,H5);
  else vZ = idif(H4,H5);
  H4 = iexp(u1,2); H4 = isprod(H4,3); H4 = iprod(H4,D11);
  H5 = iprod(q1,q2);
  vN = idif(H4,H5);
  if ( vN != 0 )
  {
    HL2 = rcons(vZ,vN);
    if ( HL2 == 0 )  v = 0;
    else  if ( lsecond(HL2) == 1 )  v = lfirst(HL2);
    else
    {
      H1 = ineg(H1);
      li = li+1;
      goto anfang;
    }
  }
  else
  {
    H1 = ineg(H1);
    li = li+1;
    goto anfang;
  }
/*
 * Berechnung von v - Ende
 */
  beta = rcons(v,W1);
/*
 * Berechnung von beta - Ende
 * Berechnung von gamma - Anfang
 */
  H6 = isprod(q1,2); H6 = iprod(H6,u1); H6 = ineg(H6);
  gamma = rcons(H6,W1);
/*
 * Berechnung von gamma - Ende
 * Erstellen von Tp - Anfang
 */
  Tp = _0;
  Tp = lcomp(gamma,Tp);
  Tp = lcomp(beta,Tp);
  Tp = lcomp(alpha,Tp);
/*
 * Erstellen von Tp  - Ende
 * Rueckgabe von Tp
 */
  return(Tp);
}
