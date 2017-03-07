/*M
.SH NAME
upmsrf - univariate polynomial over modular singles, root finding (recursive)

.SH SYNOPSIS
.nf
#include<_pol2.h>

list upmsrf(p, P)      
single p; 
pol P;
           
.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B P
is an univariate monic polynomial over Z/pZ,     deg(P) >= 1.
.PP
upmsrf returns a list L consisting of all roots of P.

.SH CAUTION
The program should only be used for polynomials which completely splitt into factors of degree 1. Otherwise the program needs disproportionate much running time, so it is better to call 'upmscfact'.

.SH SEE ALSO
upmscfact

M*/

/*H
	Version 1       09.12.87                        J.Schmitt
	Version 2       07.02.88        neu : upmsmprem J.Schmitt
	Version 3	30.11.89	c=-1 -> c=(-1)  J.Schmitt		
   DATE upmsrf        : 890501.900101
H*/


#include <_pol2.h>

list upmsrf(m,P)
single m;
pol P;
{
	list L,L1,L2;
	pol P1,Q1,Q2,GCD1,GCD2,Zw,Zw2;
	single a,c,i,s;
	bind(P);
	init(L,L1,L2,P1,Q1,Q2,GCD1,GCD2,Zw,Zw2);

	L=_0;

	a=msneg(m,1);	
	Q1=list2(0,a);
	Q2=list2(1,1);
	P1=list4(1,Q1,0,Q2);

/*  Abspalten reiner X Potenzen */
	Q1=P;
	while ( Q1 != _0 ) {
		a  = lfirst(Q1);
		Q1 = lred2(Q1);	
	}
	if (a) {
		P=ppmvquot(1,P,a);
		for (i=1;i<=a;i++) L=lcomp(0,L);
	}
	if (pdegree(1,P)==0) return(L);

/*  m==2 gesondert betrachten */
	if (m==2) {
		Q1=list4(1,1,0,1);
		while (pmseval(1,m,P,1)==0) {
			P=pmsquot(1,m,P,Q1);
			L=lcomp(1,L);
		}
		return(L);
	}
/*  P ist schon Linearfaktor  */
	if (pdegree(1,P)==1) {
		c=pmseval(1,m,P,0);
		c=msneg(m,c);
		L=lcomp(c,L);
		return(L);
	}
/*  eigentliche Faktorisierung */
	a=pdegree(1,P);
	i=(m-1)/2;
	Zw2=list2(0,1);
	c=(-1); 
	
	do {
		c++;
		if (c==1) Q1=upmstransf(m,P,2,P1);
		if (c>=1) Q2=pmseval(2,m,Q1,c);
		if (c==0) Q2=P;
		Zw=upmsmprem(m,1,i,Q2);
		Zw=pmssum(1,m,Zw,Zw2);
		GCD1=upmsgcd(m,Q2,Zw);
	}
	while ((c!=m) && ((pdegree(1,GCD1)==0)||(pdegree(1,GCD1)==a)));
	if (c==m) return(L);
	GCD2=pmsquot(1,m,Q2,GCD1);

	if (pdegree(1,GCD1)==1) {
		a=pmseval(1,m,GCD1,0);
		a=msneg(m,a);
		L1=list1(a);
	}
	if (pdegree(1,GCD2)==1) {
		a=pmseval(1,m,GCD2,0);
		a=msneg(m,a);
		L2=list1(a);
	}             
	if (lfirst(GCD1)> 1) L1=upmsrf(m,GCD1);
	if (lfirst(GCD2)> 1) L2=upmsrf(m,GCD2);
	while (L1!=_0) {
		a=msdif(m,lfirst(L1),c);
		L1=lred(L1);
		L=lcomp(a,L);
	}
	while (L2!=_0) {
		a=msdif(m,lfirst(L2),c);
		L2=lred(L2);
		L=lcomp(a,L);
	}
	return(L);
}
