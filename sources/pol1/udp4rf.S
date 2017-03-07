/*M
.SH NAME 
udp4rf - univariate dense polynomial degree 4 root finding

.SH SYNOPSIS
.nf
#include<_pol1.h>

list udp4rf( P )
pol    P;

.SH DESCRIPTION
udp4rf() computes all real and complex roots of a polynomial of degree 4, \  \  \   \   \   \   \   \   \   \   \   \   \   \  P(x) = a * x^4 + b * x^3 + c * x^2 +d * x + e , where a, b, c, d ,e are real numbers.
.TP 4 
udp4rf() returns a list L = ( L1, L2 ) of two lists, where L1 is the list of real roots and L2 is the list of complex roots of P.
.PP
.TP 4
.B P
is an univariate dense polynomial of degree 4.
M*/
/*H
        Version 1       24.04.1997      Andreas Heiser
   DATE udp4rf   :  
H*/

#include<_pol1.h>

list udp4rf(P)
pol	P;
{	list	 	L,L1,L2,H,H1,H2;
	single		i,j;
	pol		PP;
	floating	a,b,c,d,e,h1,h2,p,q,r,pp,qq,rr,gg,hh;
	complex		x1,x2,x3,x4,z1,z2,z3,z4;

	init(L,L1,L2,H,H1,H2,i,j,PP,a,b,c,d,e,h1,h2,p,q,r,pp,qq,rr,gg,hh);
	init(x1,x2,x3,x4,z1,z2,z3,z4);
	bind(P);

	L1=_0;L2=_0;
	a=lsecond(P);b=lthird(P);
	c=lfourth(P);d=lfifth(P);
	e=lsixth(P);

	/* Berechnung von p,q und r */

	h1=flprod(b,b);h1=flprod(h1,itofl(-3));
	h2=flprod(a,c);h2=flprod(h2,itofl(8));
	h1=flsum(h1,h2);h2=flprod(a,a);
	h2=flprod(h2,itofl(8));p=flquot(h1,h2);

	h1=flprod(b,b);h1=flprod(h1,b);
	h2=flprod(a,b);h2=flprod(h2,c);
	h2=flprod(h2,itofl(4));h1=fldif(h1,h2);
	h2=flprod(a,a);h2=flprod(h2,d);
	h2=flprod(h2,itofl(8));h1=flsum(h1,h2);
	h2=flprod(a,a);h2=flprod(h2,a);
	h2=flprod(h2,itofl(8));q=flquot(h1,h2);

	h1=flprod(b,b);h1=flprod(h1,h1);
	h1=flprod(h1,itofl(-3));h2=flprod(b,b);
	h2=flprod(h2,a);h2=flprod(h2,c);
	h2=flprod(h2,itofl(16));h1=flsum(h1,h2);
	h2=flprod(a,a);h2=flprod(h2,b);
	h2=flprod(h2,d);h2=flprod(h2,itofl(-64));
	h1=flsum(h1,h2);h2=flprod(a,a);
	h2=flprod(h2,a);h2=flprod(h2,e);
	h2=flprod(h2,itofl(256));h1=flsum(h1,h2);
	h2=flprod(a,a);h2=flprod(h2,h2);
	h2=flprod(h2,itofl(256));r=flquot(h1,h2);

	/* Berechnung von pp,qq und rr */

	pp=flprod(p,itofl(2));
	h1=flprod(p,p);h2=flprod(r,itofl(4));
	qq=fldif(h1,h2);
	h1=flprod(q,q);
	rr=flneg(h1);

	H=list2(itofl(1),3);
	if(flcomp(pp,itofl(0))!=0)
		H=lcomp2(pp,2,H);
	if(flcomp(qq,itofl(0))!=0)
		H=lcomp2(qq,1,H);
	if(flcomp(rr,itofl(0))!=0)
		H=lcomp2(rr,0,H);

	H=linv(H);PP=H;PP=ptodp(1,PP);
	H=udp3rf(PP);
	H1=lfirst(H);H2=lsecond(H);

	z1=fltoc(lfirst(H1));

	if(llength(H1)==1)
	{	z2=lfirst(H2);
		z3=lsecond(H2);
	}
	else
	{	z2=fltoc(lsecond(H1));
		z3=fltoc(lthird(H1));
	}

	x1=csqrt(z1);x2=csqrt(z2);x3=csqrt(z3);
	
	i=flsign(q);

	hh=fltoc(q);
	gg=cprod(x1,x2);gg=cprod(gg,x3);j=flsign(creal(gg));
	if(flcomp(q,itofl(0))!=0)
		if(idif(i,j))
		  	x3=cneg(x3);
	gg=csum(x1,x2);gg=cdif(gg,x3);z1=cquot(gg,itoc(2));
	gg=cdif(x1,x2);gg=csum(gg,x3);z2=cquot(gg,itoc(2));
	gg=csum(x2,x3);gg=cdif(gg,x1);z3=cquot(gg,itoc(2));
	gg=csum(x1,x2);gg=csum(gg,x3);z4=cquot(gg,itoc(-2));

	gg=cquot(fltoc(b),fltoc(a));gg=cquot(gg,itoc(-4));
	x1=csum(z1,gg);x2=csum(z2,gg);
	x3=csum(z3,gg);x4=csum(z4,gg);
	
	L=list4(x1,x2,x3,x4);
	a=flsexp(itofl(10),-10);
	while(L!=_0)
	{	x4=lfirst(L);
		b=flabs(cimag(x4));
		if(flcomp(a,b)>0)
			L1=lcomp(creal(x4),L1);
		else
			L2=lcomp(x4,L2);
		L=lred(L);
	}
	if(L1!=0) lflbsort(L1);

	L=list2(L1,L2);
	return(L);
}
