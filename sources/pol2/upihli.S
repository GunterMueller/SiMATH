/*M
.SH NAME
upihli - univariate polynomial over integers, Hensel lemma initialization

.SH SYNOPSIS
.nf
#include<_pol2.h>

list upihli(p, P, L) 
single p; 
pol P; 
list L;

.SH DESCRIPTION
.TP 4                                                                           
.B p                                                                            
is a prime number, p < BASIS.                                                   
.TP 4                                                                           
.B P                                                                            
is an univariate polynomial over Z/pZ of degree > 1.
.TP 4                                                                           
.B L                                                                            
= ( P1, ..., Pr )                                                               
is a list, consisting of coprime univariate polynomials over Z/pZ, so that 
.IP                                                                             
P = P1 * ... * Pr.
.PP
upihli returns a list L1 = ( A1, ..., Ar), consisting of univariate polynomials over Z/pZ, so that for 1 <= i <= r
.PP
deg(Ai) < deg(Pi), 
.PP
and for Fi := P / Pi is
.PP
(Fi * Ai) + ... + (Fr * Ar) = 1.
 
M*/

/*H
	Version 1       24.02.88                                J.Schmitt
	Version 2       30.03.88  neu: L wird uebergeben, nicht berechnet
								J.Schmitt
	Version 3       10.05.88        P jetzt aus Z/pZ vorgeschrieben.RB
   DATE upihli        : 890501
H*/


# include <_pol2.h>

list upihli(p,P,L)
single p;
pol P;
list L;
{
   pol  Pred,P1,A1,A2;
   list H,La,L1,Li;

   bind (P,L);
   init(Pred,P1,A1,A2,H,La,L1,Li);

   if (lred(L)==_0) return(list1(list2(0,1)));

   La=L;
   H=_0;
   while (La!=_0) {
		    A1=pmsquot(1,p,P,lfirst(La));
		    La=lred(La);
		    H=lcomp(A1,H);
		  }

   La=linv(H);     /* La=(F_1,.......F_r) */

   Pred=lfirst(La);
   La=lred(La);
   L1=list1(list2(0,1));
   while (La!=_0) {
		    Pred=upmsegcd(p,Pred,lfirst(La),&A1,&A2);
		    La=lred(La);
		    Li=_0;
		    H=L;
		    while (L1!=_0) {
				     P1=pmsprod(1,p,lfirst(L1),A1);
				     L1=lred(L1);
				     P1=pmsrem(1,p,P1,lfirst(H));
				     H=lred(H);
				     Li=lcomp(P1,Li);
				   }
		    Li=lcomp(A2,Li);
		    L1=linv(Li);
		  }


   return(L1);
}
