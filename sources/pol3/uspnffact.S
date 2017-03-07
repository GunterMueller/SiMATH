/*M
.SH NAME
uspnffact - univariate squarefree polynomial over number field factorization

.SH SYNOPSIS
.nf
#include<_pol3.h>

list uspnffact(F, P) 
pol F, P;

.SH DESCRIPTION
.TP 4
.B F
is an irreducible, univariate polynomial in dense representation. F generates a number field, say K.
.TP 4
.B P
is a monic, squarefree and univariate polynomial over K.
.PP
uspnffact returns a list (P_1, ..., P_k), where the P_i's are univariate, irreducible and monic polynomials over K, such that
.PP
P = P_1 * ... * P_k.

.SH CAUTION
If P is not squarefree, the function will not stop.
  
M*/
       
/*H
						
	Version 1	08.09.1994	Wolfgang Schwarz
	Version 2 	16.03.1995   	1) prlcd, prtopi ersetzt durch prnumden.
				     	2) Probiere k=0,1,-1,... statt 	
					   k=1,2,3,...  WS
        Version 3      13.12.1995  	return(faktoren) ergaenzt.   WS 
   DATE uspnffact     : 951201
H*/

#include <_pol3.h>

list uspnffact(F,P)  
pol F,P;        /* P ist als quadratfrei vorausgesetzt                           */
                /* F: dense-Darstellung, P: sparse                               */  
{pol FF,G,H,N;
 int k;
 list L1,L2,L,V,VR,VRl,muell,fakZ,faktoren;
 init(FF,G,H,N,L1,L2,L,k,V,VR,VRl,muell,fakZ,faktoren);
 bind(F,P);

 G=pnftopr(1,P);                
 FF=dptop(1,F);
 FF=pvinsert(1,FF,1);
 VR=list2('X','X');
 VRl=list1(VR);
 L1 = list2('Y','Y'); 
 V=list2(L1,list2('X','X'));

 L1=list2(0,list2(1,1));  /* Y^0 */
 k=0;
 while (1)          /* Berechne Norm(G(X-kY,Y))  */
  {
   if (k) {L2=list2(1,list2(-k,1));   /* -kY */
           L=list4(1,L1,0,L2);       /* X-kY */
          }
   else L=list2(1,L1);
   H=prtransf(2,G,V,2,L,V,VR,&muell);
   H=prnumden(2,H,&muell);
   N=pirescoll(2,FF,H,2);    /* ergibt die Norm von P(X-k*alpha) */
   N=piprimpart(1,N);
   if (isuspi(N)) break;          /* probiere solange, bis quadratfrei */
   if (k>0) k=-k; else k=1-k;
  }
 fakZ=upifact(N);  
 L1=list3(1,0,1);   /* 1 im Zahlkoerper */
 L2=list3(1,1,k);
 if (k) L=list4(1,L1,0,L2); /* X+k*alpha */
 else L=list2(1,L1);
 faktoren=_0;
 fakZ=lred(fakZ);
 while (fakZ!=_0)
  {
   H=pitopr(1,lfirst(fakZ)); 
   H=prtopnf(1,H);
   H=pnftransf(1,F,H,VRl,1,L,VRl,VR,&muell); /* fakZ(X+k*alpha) */
   H=upnfgcd(F,P,H);
   faktoren=lsuffix(faktoren,H); 
   fakZ=lred2(fakZ);
 }
return(faktoren);
}

