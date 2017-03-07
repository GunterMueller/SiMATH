/*M
.SH NAME 
ecqnflhnaav - elliptic curve over quadratic number field local height at non archimedean absolute value

.SH SYNOPSIS
.nf
#include<_ec2.h>

floating ecqnflhnaav(D, E, P, L)
int    D;
list   E, P, L;

.SH DESCRIPTION
ecqnflhnaav() returns the local height of a point P on an elliptic curve E over a quadratic number field K = Q(D^(1/2)) at a non archimedean place (see J.H. Silverman: Math. of Comp., 51, 1988, p. 339-358).

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
   DATE ecqnflhnaav   :  
H*/

#include<_ec2.h>

floating ecqnflhnaav(D,E,P,L)
int	D;
list	E,P,L;

{	nfel		a1,a2,a3,a4,a6,b2,b4,b6,b8,c4,dis,xp,yp,h1,h2,pi;
	single		f,z,N,A,B,C,bb,k;
	int		p;
	list		Pi,L1;
	floating	lh,hf1,n;
	
	init(a1,a2,a3,a4,a6,b2,b4,b6,b8,c4,dis,xp,yp,h1,h2,pi);
	init(f,z,N,A,B,C,bb,k);
	init(p);
	init(Pi,L1);
	init(lh,hf1,n);
	bind(D,E,P,L);
	
	xp=lfirst(P);
	yp=lsecond(P);
	L1=lfirst(E);
	L1=lfirst(L1);
	a1=lfirst(L1);
	a2=lsecond(L1);
	a3=lthird(L1);
	a4=lfourth(L1);	
	a6=lfifth(L1);
	b2=ecqnfacb2(E);
	b4=ecqnfacb4(E);
	b6=ecqnfacb6(E);
	b8=ecqnfacb8(E);
	c4=ecqnfacc4(E);
	dis=ecqnfacdisc(E);
	Pi=lfirst(L);
	p=lfirst(Pi);p=iprod(p,lsecond(Pi));
	p=iquot(p,lfourth(Pi));
	pi=lthird(L);z=lfourth(L);
	
	N=qnfpiord(D,Pi,pi,z,dis);
	
	h1=qnfexp(D,xp,2);h1=qnfiprod(D,h1,3);
	h2=qnfprod(D,a2,xp);h2=qnfiprod(D,h2,2);
	h1=qnfsum(D,h1,h2);h1=qnfsum(D,h1,a4);
	h2=qnfprod(D,a1,yp);h1=qnfdif(D,h1,h2);
	
	if(h1) 
		A=qnfpiord(D,Pi,pi,z,h1);
	else
		A=1;
	
	h1=qnfiprod(D,yp,2);h2=qnfprod(D,a1,xp);
	h1=qnfsum(D,h1,h2);h1=qnfsum(D,h1,a3);

	bb=0;
	if(h1)
		B=qnfpiord(D,Pi,pi,z,h1);
	else
	{	B=1;
		bb=1;
	}

	h1=qnfexp(D,xp,4);h1=qnfiprod(D,h1,3);
	h2=qnfexp(D,xp,3);h2=qnfprod(D,h2,b2);
	h1=qnfsum(D,h1,h2);h2=qnfexp(D,xp,2);
	h2=qnfprod(D,h2,b4);h2=qnfiprod(D,h2,3);
	h1=qnfsum(D,h1,h2);h2=qnfprod(D,b6,xp);
	h2=qnfiprod(D,h2,3);
	h1=qnfsum(D,h1,h2);
	h1=qnfsum(D,h1,b8);
	
	if(h1)  
	{	C=qnfpiord(D,Pi,pi,z,h1);
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
		{	f=qnfpiord(D,Pi,pi,z,h1);
			hf1=flquot(itofl(f),itofl(-2));
			if(flcomp(hf1,itofl(0))>0)
				lh=hf1;
			else	
				lh=itofl(0);
		}
		else	
			lh=itofl(0);
	}
	else
	{	if(c4)
			f=qnfpiord(D,Pi,pi,z,c4);
		else	
			f=1;
		if(!f)
		/*   multiplicative reduction   */
		{	hf1=flquot(itofl(N),itofl(2));
			if(flcomp(hf1,itofl(B))>0)
				n=itofl(B);
			else	
				n=hf1;	
			hf1=fldif(n,itofl(N));
			hf1=flprod(n,hf1);
			hf1=flquot(hf1,itofl(2));
			lh=flquot(hf1,itofl(N));
		}
		else
		/*      additive reduction      */
		{	k=iprod(B,3);
			if(C>=k)
				lh=flquot(itofl(B),itofl(-3));
			else
				lh=flquot(itofl(C),itofl(-8));
		}
	}
	L1=qnfdegrescf(D,p);f=lfirst(L1);
	p=iexp(p,f);hf1=itofl(p);hf1=fllog(hf1);
	lh=flprod(lh,hf1);
	lh=flprod(lh,itofl(2));
	return(lh);
}





