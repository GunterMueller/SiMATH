/*M
.SH NAME 
ecpcnflhnaav - elliptic curve over pure cubic number field local height at non archimedean absolute value

.SH SYNOPSIS
.nf
#include<_ec2.h>

floating ecqnflhnaav(D, a1, a2, a3, a4, a6, P, L)
int    D;
nfel   a1, a2, a3, a4, a6; 
list   P, L;

.SH DESCRIPTION
ecpcnflhnaav() returns the local height of a point P on an elliptic curve E over a pure cubic number field K = Q(D^(1/3)) at a non archimedean place (see J.H. Silverman: Math. of Comp., 51, 1988, p. 339-358).

.PP
.TP 4
.B D
is a non negative cubefree integer not equal to 0 or 1.
.TP 4
.B a_i
are the Weierstrass coefficients of E, where E is an elliptic curve in minimal Weierstrass equation.
.TP 4
.B P
is a list representing a point on E(K)\\{O}. \  \  \  \  \  P = ( xp, yp, zp )
\  nfel xp, yp, zp;   
.TP 4
.B L
is a list representing a prime ideal in the ring of integers O_K.\ \   \   \   \   \   \   \   \   \   \  \   \   \   \   L = ( Pi, e, f )  list Pi;  single e, f; \   \   \   \   \Pi is a prime ideal, e is the ramification index of Pi over the according prime number, f is the degree of the residue class field. 
M*/
/*H
        Version 1       20.02.1998      Andreas Heiser
   DATE ecpcnflhnaav  :  
H*/

	
#include<_ec2.h>
	
floating ecpcnflhnaav(D,a1,a2,a3,a4,a6,P,L)
int	D;
nfel	a1,a2,a3,a4,a6;
list	P,L;
{	floating	lh,hf1,n;
	nfel		b2,b4,b6,b8,c4,disc,h1,h2,xp,yp;
	list		L1,Pi;
	pol		F;
	single		A,B,C,N,e,f,bb,g,k,p;

	init(lh,b2,b4,b6,b8,disc,L1,Pi,F,A,B,C,N,e,f,h1,h2,xp,yp,bb,g);
	init(hf1,c4,n,k,p); 
	bind(D,a1,a2,a3,a4,a6,P,L);

	F=list5(3,1,0,0,-D);
	L1=ecnftavb8(F,a1,a2,a3,a4,a6);
	b2=lfirst(L1);b4=lsecond(L1);
	b6=lthird(L1);b8=lfourth(L1);
	
	L1=ecnftavc6(F,a1,a2,a3,a4,a6);
	c4=lfirst(L1);
	
	disc=ecnfdisc(F,a1,a2,a3,a4,a6);
	
	Pi=lfirst(L);e=lsecond(L);f=lthird(L);
	p=lfirst(Pi); 
	N=pcnfpiord(D,Pi,e,f,disc);
	
	xp=lfirst(P);yp=lsecond(P);
	h1=nfexp(F,xp,2);h1=nfeliprod(F,h1,3);
	h2=nfprod(F,a2,xp);h2=nfeliprod(F,h2,2);
	h1=nfsum(F,h1,h2);h1=nfsum(F,h1,a4);
	h2=nfprod(F,a1,yp);h1=nfdif(F,h1,h2);
	if(h1)
		A=pcnfpiord(D,Pi,e,f,h1);
	else
		A=1;

	h1=nfeliprod(F,yp,2);h2=nfprod(F,a1,xp);
	h1=nfsum(F,h1,h2);h1=nfsum(F,h1,a3);
	if(h1)
		B=pcnfpiord(D,Pi,e,f,h1);
	else
	{	B=1;
		bb=1;
	}
	
	h1=nfexp(F,xp,4);h1=nfeliprod(F,h1,3);
	h2=nfexp(F,xp,3);h2=nfprod(F,b2,xp);
	h1=nfsum(F,h1,h2);h2=nfexp(F,xp,2);
	h2=nfeliprod(F,h2,3);h2=nfprod(F,b4,xp);
	h1=nfsum(F,h1,h2);h2=nfprod(F,xp,b6);
	h2=nfeliprod(F,h2,3);h1=nfsum(F,h1,h2);
	h1=nfsum(F,h1,b8);
	
	if(h1)  
	{	C=pcnfpiord(D,Pi,e,f,h1);
		if(bb==1 && C>=0)
			B=isum(C,1);
	}
	else 
	{	bb=iprod(B,3);
		C=bb;
	}

	if(!(A>0 && B>0))
	/*      good reduction      */
	{	h1=xp;
		if(h1)
		{	g=pcnfpiord(D,Pi,e,f,h1);
			hf1=flquot(itofl(g),itofl(-1));
			if(flcomp(hf1,0)>0)
				lh=hf1;
			else	
				lh=0;
		}
		else	
			lh=0;
	}
	else
	{	if(c4)
			g=pcnfpiord(D,Pi,e,f,c4);
		else	
			g=1;
		if(!g)
		/*   multiplicative reduction   */
		{	hf1=flquot(itofl(N),itofl(2));
			if(flcomp(hf1,itofl(B))>0)
				n=itofl(B);
			else	
				n=hf1;	
			hf1=fldif(n,itofl(N));
			hf1=flprod(n,hf1);
			lh=flquot(hf1,itofl(N));
		}
		else
		/*      additive reduction      */
		{	k=iprod(B,3);
			if(C>=k)
			{	lh=flquot(itofl(B),itofl(-3));
				lh=flprod(lh,itofl(2)); 
			}
			else
				lh=flquot(itofl(C),itofl(-4));
		}
	}
	p=iexp(p,f);hf1=itofl(p);hf1=fllog(hf1);
	lh=flprod(lh,hf1);
	return(lh);
}

