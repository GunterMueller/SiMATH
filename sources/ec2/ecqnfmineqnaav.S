/*M
.SH NAME 
ecqnfmineqnaav - elliptic curve over quadratic number field minimal equation at non archimedean absolute value

.SH SYNOPSIS
.nf
#include<_ec2.h>

list  ecqnfmineqnaav(D, E, P, L)
int    D;
list   E, P, L;

.SH DESCRIPTION
ecqnfmineqnaav() returns the minimal equation of an elliptic curve E over a quadratic number field K = Q(D^(1/2)) with respect to a non archimedean absolute value and the transformed point to a given point P.
.TP 3 
ecqnfmineqnaav() returns:
L = ( a1m, a2m, a3m, a4m, a6m, Pm ), where a1m, a2m, a3m, a4m and a6m are the minimal Weierstrass coefficients with respect to the given non archimedean absolute value, and Pm = ( xm, ym ) is the transformed point to the given Point P.
.PP
.TP 4
.B D
is a squarefree integer not equal to 0 or 1.
.TP 4
.B E
is a list containing all information about the elliptic curve defined over K (see 'ecqnfinit').
.TP 4
.B P
is a list representing a point on E(K)\\{O}. \  \  \  \  \  P = ( xp, yp )\  nfel xp, yp;   
.TP 4
.B L
is a list representing a prime ideal in the ring of integers O_K (see 'qnfpifact').                     \  L = ( Pi, fi, pi, zi )  list  Pi; single  fi, zi; \  \   \                        nfel pi;\   \   \   \   \                     \Pi is the prime ideal, pi is a prime element of Pi and zi = 0, 1 or 2, if the prime ideal Pi divides an inert, ramified or split prime number in Q. 
M*/
/*H
        Version 1       03.01.1997      Andreas Heiser
   DATE ecqnfmineqnaav   :  
H*/

#include<_ec2.h>

list  ecqnfmineqnaav(D,E,P,L)
int	D;
list 	E,P,L;
{	nfel	a1,a2,a3,a4,a6,xp,yp;
	nfel	a1m,a2m,a3m,a4m,a6m,xpm,ypm,h1,dis,c4,c6,pi,u;
	nfel	aa1,aa2,aa3,aa4,aa6,xx,yy;
	single	fi,gi,zi,n;
	list	L1,L2,Pi;
	int	p;

	init(a1m,a2m,a3m,a4m,a6m,xpm,ypm,h1,dis,c4,c6,fi,gi,pi,zi,Pi,u,n);
	init(aa1,aa2,aa3,aa4,aa6,xx,yy,p,a1,a2,a3,a4,a6,xp,yp,L1,L2);

	bind(D,E,P,L);
	
	L1=lfirst(E);
	L2=lfirst(L1);
	a1=lfirst(L2);
	a2=lsecond(L2);
	a3=lthird(L2);
	a4=lfourth(L2);	
	a6=lfifth(L2);
	xp=lfirst(P);yp=lsecond(P);	
	dis=ecqnfacdisc(E);
	Pi=lfirst(L);p=lfirst(Pi);
	p=iprod(p,lsecond(Pi));
	p=iquot(p,lfourth(Pi));
	pi=lthird(L);zi=lfourth(L);	
	fi=qnfpiord(D,Pi,pi,zi,dis);
	fi=iquot(fi,12);	
	c4=ecqnfacc4(E);
	c6=ecqnfacc6(E);
	
	if(c4)
	{	gi=qnfpiord(D,Pi,pi,zi,c4);
		gi=iquot(gi,4);
		fi=smin(fi,gi);
		if(c6)
		{	gi=qnfpiord(D,Pi,pi,zi,c6);
			gi=iquot(gi,6);
			fi=smin(fi,gi);
		}
	}
	else
	{	gi=qnfpiord(D,Pi,pi,zi,c6);
		gi=iquot(gi,6);
		fi=smin(fi,gi);
	}
	if(fi)
	{	u=qnfexp(D,pi,fi);n=1;
		a1m=qnfquot(D,a1,u);
		if(a1m)
		{	gi=qnfpiord(D,Pi,pi,zi,a1m);
			if(gi<0)
				n=0;
		}
		if(n)
		{	h1=qnfexp(D,u,2);a2m=qnfquot(D,a2,h1);
			xpm=qnfquot(D,xp,h1);
			if(a2m)
			{	gi=qnfpiord(D,Pi,pi,zi,a2m);
				if(gi<0)
					n=0;
			}
		}
		if(n)
		{	h1=qnfexp(D,u,3);a3m=qnfquot(D,a3,h1);
			ypm=qnfquot(D,yp,h1);
			if(a3m)
			{	gi=qnfpiord(D,Pi,pi,zi,a3m);
				if(gi<0)
					n=0;
			}
		}
		if(n)
		{	h1=qnfexp(D,u,4);a4m=qnfquot(D,a4,h1);
			if(a4m)
			{	gi=qnfpiord(D,Pi,pi,zi,a4m);
				if(gi<0)
					n=0;
			}
		}
		if(n)
		{	h1=qnfexp(D,u,6);a6m=qnfquot(D,a6,h1);
			if(a6m)
			{	gi=qnfpiord(D,Pi,pi,zi,a6m);
				if(gi<0)
					n=0;
			}
		}
		if(n)
		{	a1=a1m;a2=a2m;a3=a3m;a4=a4m;a6=a6m;
			xp=xpm;yp=ypm;
		}
	}
	L1=list2(xp,yp);
	L1=lcomp5(a1,a2,a3,a4,a6,L1);
	
	return(L1);
}





