/*M
.SH NAME 
ecpcnflhaav - elliptic curve over pure cubic number field local height at the archimedean absolute value

.SH SYNOPSIS
.nf
#include<_ec2.h>

floating ecpcnflhaav(D, a1, a2, a3, a4, a6, P)
int      D;
nfel     a1, a2, a3, a4, a6; 
list     P;

.SH DESCRIPTION
ecpcnflhaav() returns the local archimedean height of a point P on an elliptic curve E over a pure cubic number field K = Q(D^(1/3)) (see J.H. Silverman: Math. of Comp., 51, 1988, p. 339-358).

.PP
.TP 4
.B D
is a non negative cubefree integer not equal to 0 or 1.
.TP 4
.B a_i
are the Weierstrass coefficients of E, where E is an elliptic curve in Weierstrass equation over K.
.TP 4
.B P
is a list representing a point on E(K)\\{O}. \  \  \  \  \  P = ( xp, yp, zp )\  nfel xp, yp, zp;     

M*/
/*H
        Version 1      20.02.1998      Andreas Heiser
   DATE ecpcnflhaav :
H*/


#include<_ec2.h>
	
floating  ecpcnflhaav(D,a1,a2,a3,a4,a6,P)
int	D;	
nfel	a1,a2,a3,a4,a6;
list	P;
{	floating	l,b2,b4,b6,b8,bb2,bb4,bb6,bb8,h,xp,t,mu,w,z,h1,h2,h3;
	single		N,beta,n;
	list		L;
	pol		F;

	init(l,N,b2,b4,b6,b8,bb2,bb4,bb6,bb8,h,xp,t,L,F,beta,n,mu,w,z,h1,h2);
	init(h3);
	bind(D,a1,a2,a3,a4,a6,P);

	N=50;
	F=list5(3,1,0,0,-D);
	L=ecnftavb8(F,a1,a2,a3,a4,a6);
	b2=pcnftofl(D,lfirst(L));b4=pcnftofl(D,lsecond(L));
	b6=pcnftofl(D,lthird(L));b8=pcnftofl(D,lfourth(L));

	bb2=fldif(b2,itofl(12));
	h=fldif(b4,b2);bb4=flsum(h,itofl(6));
	h=flprod(b4,itofl(2));h=fldif(b6,h);
	h=flsum(h,b2);bb6=fldif(h,itofl(4));	
	h=fldif(b4,b6);h=flprod(h,itofl(3));
	h=flsum(b8,h);h=fldif(h,b2);
	bb8=flsum(h,itofl(3));
	xp=pcnftofl(D,lfirst(P));
	h=rtofl(rcons(1,2));
	if(flcomp(flabs(xp),h)>=0)
		beta=1;
	else
	{	xp=flsum(xp,itofl(1));
		beta=0;
	}
	t=flquot(itofl(1),xp);

	l=flabs(t);l=fllog(l);
	l=flneg(l);
	n=0;
	mu=0;
	while(n<=N)
	{	if(beta)
		{	w=flprod(t,itofl(4));h=flsexp(t,2);
			h=flprod(h,b2);w=flsum(w,h);
			h=flsexp(t,3);h=flprod(h,b4);
			h=flprod(h,itofl(2));w=flsum(w,h);
			h=flsexp(t,4);h=flprod(h,b6);
			w=flsum(w,h);
			h=flsexp(t,2);h=flprod(h,b4);
			z=fldif(itofl(1),h);h=flsexp(t,3);
			h=flprod(h,b6);h=flprod(h,itofl(2));
			z=fldif(z,h);h=flsexp(t,4);
			h=flprod(h,b8);
			z=fldif(z,h);
			h1=flabs(w);h2=flabs(z);
			h2=flprod(h2,itofl(2));
			if(flcomp(h1,h2)<=0)
			{	h=flabs(z);h=fllog(h);
				h3=flsexp(itofl(4),n);
				h=flquot(h,h3);
				mu=flsum(mu,h);
				t=flquot(w,z);
			}
			else
			{	h=flsum(z,w);h=flabs(h);
				h=fllog(h);h3=flsexp(itofl(4),n);
				h=flquot(h,h3);
				mu=flsum(mu,h);
				h=flsum(z,w);
				t=flquot(w,h);
				beta=0;
			}
		}
		else
		{	w=flprod(t,itofl(4));h=flsexp(t,2);
			h=flprod(h,bb2);w=flsum(w,h);
			h=flsexp(t,3);h=flprod(h,bb4);
			h=flprod(h,itofl(2));w=flsum(w,h);
			h=flsexp(t,4);h=flprod(h,bb6);
			w=flsum(w,h);
			h=flsexp(t,2);h=flprod(h,bb4);
			z=fldif(itofl(1),h);h=flsexp(t,3);
			h=flprod(h,bb6);h=flprod(h,itofl(2));
			z=fldif(z,h);h=flsexp(t,4);
			h=flprod(h,bb8);
			z=fldif(z,h);
			h1=flabs(w);h2=flabs(z);
			h2=flprod(h2,itofl(2));
			if(flcomp(h1,h2)<=0)
			{	h=flabs(z);h=fllog(h);
				h3=flsexp(itofl(4),n);
				h=flquot(h,h3);
				mu=flsum(mu,h);
				t=flquot(w,z);
			}
			else
			{	h=fldif(z,w);h=flabs(h);
				h=fllog(h);h3=flsexp(itofl(4),n);
				h=flquot(h,h3);
				mu=flsum(mu,h);
				h=fldif(z,w);
				t=flquot(w,h);
				beta=1;
			}
		}
		n++;
	}
	h=flquot(mu,itofl(4));
	l=flsum(l,h);

	return(l);
}




