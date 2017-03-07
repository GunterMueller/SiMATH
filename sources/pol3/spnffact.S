/*M
.SH NAME
spnffact - squarefree polynomial over number field factorization

.SH SYNOPSIS
.nf
#include<_pol3.h>

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
.B P
is a monic polynomial in r variables over K. P is squarefree and primitive with regard to the main variable. 
.PP
spnffact returns a list, containig the coprime, monic and irreducible factors of P.
                     
M*/
                      
/*H	
	Version 1	15.03.95 	Wolfgang Schwarz
	Versin 2	07.07.95 	Fsp eingefuehrt  WS
   DATE spnffact      : 951201
H*/

#include <_pol3.h>

list spnffact( r, F, D, P)
single r;
pol F,P;
int D;
{
   pol Fs,Fsp,Zw,Zw1,Zw2,P_tf, PU,PU1,PU2,P1,P2,P1p,P2p,P1pp,P2pp,P_tfpp,PlP;
   list Faktoren,UFakt,A,AA,Anf,A_ms,LAL,LId,AL;
   int Nenner,M;
   rat Nennerinv;
   single a,i,degxP,degyP,rs,Fk_found,Fk_left,p,*nextprime;
   
   bind(F,P,D);
   init(Fs,Fsp,Zw,Zw1,Zw2,P_tf, PU,PU1,PU2,P1,P2,P1p,P2p,P1pp,P2pp,P_tfpp,PlP);
   init(Faktoren,UFakt,A,AA,Anf,A_ms,LAL,LId,AL);
   init(Nenner,M,Nennerinv);

/* P univariat. */

   if( r == 1 ) Faktoren = uspnffact(F,P);
   else
    {

/* Initialisierung */

	Fs = dptop(1,F);
	Faktoren = _0;

	Zw = pnftopr(r,P);
	prnumden(r+1,Zw,&Nenner);
	Nenner = iprod(Nenner, D); /* moeglicher Nenner der Faktoren */
	Nennerinv = list2(1,Nenner); 
	A = _0;
	for (i=1;i<r;i++) A = lcomp(0,A);
	degxP = pdegree(r,P);

/* P=P(Y1,...,Yr-1,X)  , A=(a1,...,ar-1)  
 PU(X)=P(a1,...,ar-1,X), P_tf(Y1,...,Yr-1,X)=P(Y1+a1,...,Yr-1+ar-1,X) 
*/
       do
         {
	  do {	AA = A;
         	PU = P;
		for (rs=r;rs>1;rs--)
        	{	a = lfirst(AA);
			AA = lred(AA);
			PU = pnfevalsv(rs,F,PU,1,itonf(a));
               		if (pdegree(rs-1,PU)<degxP || !issfpnf(rs-1,F,D,PU))
		  	{ A = lscountup(A,r-rs+1);
		    	  break;
		  	}
        	}
	     } while (rs>1);
	  Anf = _0; 
	  AA = A;
	  while (AA != _0)
		{a = lfirst(AA);
		 AA = lred(AA);
		 Anf = lcomp(itonf(a),Anf);
		}
	  Anf = lcomp(0,Anf); 
	  AA = Anf;
	  for (A_ms=_0; AA!=_0; AA=lred(AA))
		{a = lfirst(AA);
		 A_ms = lcomp(nfneg(F,a),A_ms);
		}
          A_ms = linv(A_ms);

	  P_tf = pnftransav(r,F,P,Anf);

	  PU = pnfmonic(1,F,PU);
	  UFakt = uspnffact(F,PU);
	  Fk_found = 0;
	  Fk_left = llength(UFakt);

/* teste alle irreduziblen Faktoren PU1 von PU */

	  while (UFakt!=_0 && Fk_left>=2)
 	   {PU1 = lfirst(UFakt);
	    UFakt = lred(UFakt);
	    if (Fk_left==2 && UFakt!=_0) 
		{PU2 = lfirst(UFakt); 
		 UFakt = lred(UFakt);
	        }
	    else PU2 = pnfquot(1,F,PU,PU1);
            Zw = plc(r,P_tf);
	    Zw1 = list2(0,Zw);
	    PlP = pnfprod(r,F,P_tf,Zw1);
            Zw = ptbc(r-1,Zw);
	    Zw = nfquot(F,Zw,plc(1,PU2));
	    PU2 = pnfnfprod(1,F,PU2,Zw);
	    degyP = ptdegree(r,P,1)+1;

/* ziehe Faktorisierung PU=PU1*PU2 mittels Hensel-Lifting hoch zu P=P1*P2   */	
	    
	    M = 1;
	    P1 = 0;
	    P2 = 0;
	    nextprime = LIST_GSP;
 spnf_neues_p:  if (*nextprime) p = *nextprime, nextprime++;
		else do p-=2; while (issprime(p,&i)!=1); 
		if (!mshom(p,Nenner)) goto spnf_neues_p;
		Fsp = pitopms(1,Fs,p);
		LAL = pmsalidpo(p,Fsp,&LId);
		if (LAL==ERROR) goto spnf_neues_p;
		P1p = 0; 
		P2p = 0;	
		while (LAL != _0)
		 { AL = lfirst(LAL);
		   LAL = lred(LAL);
		   P_tfpp = pnftopgfs(r,p,AL,P_tf);
		   if (pdegree(r,P_tfpp) < degxP) goto spnf_neues_p;
		   P1pp = pnftopgfs(1,p,AL,PU1);
		   if (P1pp == ERROR) goto spnf_neues_p; 
		   P2pp = pnftopgfs(1,p,AL,PU2);
		   if (P2pp == ERROR) goto spnf_neues_p;
		   if (pgfshlift(r,p,AL,P_tfpp,P1pp,P2pp,degyP,&P1pp,&P2pp)==ERROR)
				goto spnf_neues_p;;
		   Zw = plc(r,P_tfpp);
		   Zw = list2(0,Zw);
		   P1pp = pgfstrprod(r,p,AL,P1pp,Zw,1,degyP);
		   Zw2 = pgfsprod(r,p,AL,P1pp,P2pp);
		   Zw = pgfsprod(r,p,AL,P_tfpp,Zw);
		   if (!oequal(Zw,Zw2)) goto spnf_fak;  /* das war kein Faktor */      
		   Zw = lfirst(LId);
		   LId = lred(LId);
		   Zw2 = pmsupmsprod(r+1,p,P1pp,Zw); /*mit Idempotenten multiplizieren*/
		   P1p = pmssum(r+1,p,P1p,Zw2);
		   Zw2 = pmsupmsprod(r+1,p,P2pp,Zw);
		   P2p = pmssum(r+1,p,P2p,Zw2);
		 }

		
        	P1p = pmsupmsrem(r+1,p,P1p,Fsp);
        	P2p = pmsupmsrem(r+1,p,P2p,Fsp);
		a = mshom(p,Nenner);
		P1p = pmsmsprod(r+1,p,P1p,a);
		P2p = pmsmsprod(r+1,p,P2p,a);
		a = mshom(p,M);
		a = msinv(p,a); 
		P1 = picra(r+1,P1,P1p,M,p,a);
		P2 = picra(r+1,P2,P2p,M,p,a);
		M = isprod(M,p);
		Zw1 = pitopr(r+1,P1);
		Zw1 = prrprod(r+1,Zw1,Nennerinv);
	 	Zw1 = prtopnfdnv(r,F,Zw1);
		Zw2 = pitopr(r+1,P2);
		Zw2 = prrprod(r+1,Zw2,Nennerinv);
	 	Zw2 = prtopnfdnv(r,F,Zw2);
	 	Zw = pnfprod(r,F,Zw1,Zw2);
		if (!oequal(Zw,PlP)) goto spnf_neues_p; /* brauche weitere p's */

	    pnfcontpp(r,F,D,Zw1,&P1);
	    pnfcontpp(r,F,D,Zw2,&P2);
	    P1 = pnfmonic(r,F,P1);
	    P2 = pnfmonic(r,F,P2); 
	    Fk_found++;
	    Fk_left--;
	    Zw = pnftransav(r,F,P1,A_ms);
	    Faktoren = lcomp(Zw,Faktoren);
	    PU = PU2;
	    P_tf = P2;
	    degxP = pdegree(r,P_tf);
		
spnf_fak:; }
          if (Fk_found) P = pnftransav(r,F,P_tf,A_ms);
	  A = lscountup(A,1);
         } while (Fk_left > 3);
	Faktoren = lcomp(P,Faktoren);
    }
   return(Faktoren);
}


