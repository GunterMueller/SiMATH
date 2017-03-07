/*M
.SH NAME
pnfgcdcf - polynomial over number field greatest common divisor and cofactors

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pnfgcdcf(r, F, D, P1, P2, pQ1, pQ2)
single r; 
int D; 
pol F, P1, P2, *pQ1, *pQ2;
 
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B F
is a monic polynomial in dense representation.
.PP
Let t denote a zero of F, then t generates a number field, say K.
.TP 4
.B D
is a natural number, such that the ring of integers of K is in 1/D * Z[t] (s. ouspidenic).
.TP 4
.B P1, P2
are polynomials in r variables over K.
.TP 4
.B pQ1, pQ2
point on two polynomials.
.PP         
pnfgcdcf returns the (monic) greatest common divisor, say Q, of P1 and P2.
pnfgcdcf writes two polynomials, say *pQ1, *pQ2 to pQ1 and pQ2 respectively, where
.IP
.nf
*pQ1 = P1/Q, *pQ2 = P2/Q, if Q != 0
*pQ1 = *pQ2 = 0, else.
 
.SH NOTES
Generally,for univariate polynomials pnfgcdcf is faster than upnfgcd.

.SH SEE ALSO
ouspidenic

M*/                                                        

/*H
	Version 1	03.05.95	Wolfgang Schwarz
	Version 1	07.07.95	Fsp eingefuehrt.  WS
   DATE pnfgcdcf      : 951201
H*/

#include <_pol3.h>

pol pnfgcdcf(r,F,D,P1,P2,pQ1,pQ2)
single r;
int D;
pol F,P1,P2,*pQ1,*pQ2;
{  
   pol P3,Q1,Q2,P3p,Q1p,Q2p,P3pp,Q1pp,Q2pp;
   pol Fs,Fsp,Zw,Zw1,Zw2,Zw3;
   int M,Nenner1,Nenner2,Nenner3;
   list AL,LAL,LId,degP3,deg;
   single p,*nextprime,a;
   nfel c1,c2;
   rat inv1,inv2,inv3;
   bind(D,F,P1,P2);
   init(P3,Q1,Q2,P3p,Q1p,Q2p,P3pp,Q1pp,Q2pp,Fs,Fsp,Zw,Zw1,Zw2,Zw3);
   init(M,Nenner1,Nenner2,Nenner3,AL,LAL,LId,degP3,deg);
   init(c1,c2,inv1,inv2,inv3);

/* P1 oder P2 gleich 0 */

   if (!P1) {*pQ1 = 0; *pQ2 = pvinsert(0,plbc(r,P2),r); 
	     P3 = pnfmonic(r,F,P2);
	    }
   else if (!P2) {*pQ2 = 0; *pQ1 = pvinsert(0,plbc(r,P1),r);
             	  P3 = pnfmonic(r,F,P1);
            	 } 

/* r = 0 */

   else if (!r) {*pQ1 = P1; *pQ2 = P2; P3 = itonf(1);}

/* allgemeiner Fall */

   else
   { 	Fs = dptop(1,F);
	c1 = plbc(r,P1);
	c2 = plbc(r,P2);
	P1 = pnfmonic(r,F,P1);
	P2 = pnfmonic(r,F,P2);
	Zw = pnftopr(r,P1);
	prnumden(r+1,Zw,&Nenner1);
	Zw = pnftopr(r,P2);
        prnumden(r+1,Zw,&Nenner2);
	Nenner3 = igcd(Nenner1,Nenner2);
	Nenner3 = iprod(Nenner3,D); /* moegl.Nenner von P3 */
	Nenner1 = iprod(Nenner1,D); /* moegl.Nenner von Q1 */
 	Nenner2 = iprod(Nenner2,D);	/*...	von Q2 */	
	inv1 = list2(1,Nenner1);
	inv2 = list2(1,Nenner2);
	inv3 = list2(1,Nenner3);

	degP3 = list1(pdegree(r,P1)+1);
	nextprime = LIST_GSP;
pnfgcd_neu_p: 
	if (*nextprime) p = *nextprime, nextprime++;
        else do p-=2; while (issprime(p,&a)!=1);	
	if (!(mshom(p,Nenner1) && mshom(p,Nenner2) && mshom(p,D))) goto pnfgcd_neu_p;
	Fsp = pitopms(1,Fs,p);
	LAL = pmsalidpo(p,Fsp,&LId);
	if (LAL == ERROR) goto pnfgcd_neu_p;
	P3p = 0;
	Q1p = 0;
	Q2p = 0;

/* ggT modulo der Primideale ueber p bestimmen */

	while (LAL != _0)
	 { AL = lfirst(LAL);
	   LAL = lred(LAL);
	   Zw1 = pnftopgfs(r,p,AL,P1);
	   Zw2 = pnftopgfs(r,p,AL,P2);
	   P3pp = pgfsgcdcf(r,p,AL,Zw1,Zw2,&Q1pp,&Q2pp);
	   if (P3pp == ERROR) goto pnfgcd_neu_p;
	   if (ispconst(r,P3pp,&Zw)) {P3=pitopnf(r,itopi(r,1));Zw1=P1;Zw2=P2;goto pnfgcd_fertig;} 
	   deg = plexvec(r,P3pp);
	   a = lscomp(degP3,deg);
	   if (a>0)
		{degP3 = deg;
		 M = 1;
		 Q1 = 0;
		 Q2 = 0;
		 P3 = 0;
		 if (P3p) goto pnfgcd_neu_p;
		}
	   if (a<0) goto pnfgcd_neu_p;

/* modulo p hochziehen (Chines.Restsatz) */

 	   Zw = lfirst(LId);
           LId = lred(LId);
           Zw3 = pmsupmsprod(r+1,p,P3pp,Zw); /*mit Idempotenten multiplizieren*/
           P3p = pmssum(r+1,p,P3p,Zw3);      /*und aufaddieren                */
	   Zw1 = pmsupmsprod(r+1,p,Q1pp,Zw); /*dasselbe fuer Q1p, Q2p */
           Q1p = pmssum(r+1,p,Q1p,Zw1);
	   Zw2 = pmsupmsprod(r+1,p,Q2pp,Zw); 
           Q2p = pmssum(r+1,p,Q2p,Zw2);
         }

        P3p = pmsupmsrem(r+1,p,P3p,Fsp);
        Q1p = pmsupmsrem(r+1,p,Q1p,Fsp);
        Q2p = pmsupmsrem(r+1,p,Q2p,Fsp);

 /* modulo M hochziehen (Chines.Restsatz) */

	a = mshom(p,Nenner3);
	P3p = pmsmsprod(r+1,p,P3p,a);
	a = mshom(p,Nenner1);
	Q1p = pmsmsprod(r+1,p,Q1p,a);
	a = mshom(p,Nenner2);
	Q2p = pmsmsprod(r+1,p,Q2p,a);
	a = mshom(p,M);
	a = msinv(p,a);
	P3 = picra(r+1,P3,P3p,M,p,a);
	Q1 = picra(r+1,Q1,Q1p,M,p,a);
	Q2 = picra(r+1,Q2,Q2p,M,p,a);
	M = isprod(M,p);

/* Teste durch Probe-Multiplikation, ob schon fertig */

	Zw3 = pitopr(r+1,P3);
	Zw3 = prrprod(r+1,Zw3,inv3);
	Zw3 = prtopnfdnv(r,F,Zw3);
	Zw1 = pitopr(r+1,Q1);
	Zw1 = prrprod(r+1,Zw1,inv1);
	Zw1 = prtopnfdnv(r,F,Zw1);
	Zw = pnfprod(r,F,Zw3,Zw1);
	if (!oequal(Zw,P1)) goto pnfgcd_neu_p;
	
	Zw2 = pitopr(r+1,Q2);
	Zw2 = prrprod(r+1,Zw2,inv2);
	Zw2 = prtopnfdnv(r,F,Zw2);
	Zw = pnfprod(r,F,Zw3,Zw2);
	if (!oequal(Zw,P2)) goto pnfgcd_neu_p;

	P3 = Zw3;
pnfgcd_fertig:	
	*pQ1 = pnfnfprod(r,F,Zw1,c1);
	*pQ2 = pnfnfprod(r,F,Zw2,c2);
   }
   
   return(P3);
} 
