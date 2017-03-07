/*M
.SH NAME 
ecqnflhaav - elliptic curve over quadratic number field local height(s) at the archimedean absolute value(s)

.SH SYNOPSIS
.nf
#include<_ec2.h>

floating ecqnflhaav(D, E, P, d)
int      D;
list     E, P;
single   d;

.SH DESCRIPTION
ecqnflhaav() returns the local archimedean height of a point P on an elliptic curve E over a quadratic number field K = Q(D^(1/2)). In the case D > 0 it returns the two archimedean heights summed up as one value (see J.H. Silverman: Math. of Comp., 51, 1988, p. 339-358).

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
.B d
the number of correct decimal places.
M*/
/*H
        Version 1      03.02.1997      Andreas Heiser
   DATE ecqnflhaav   :
H*/


#include<_ec2.h>

floating  ecqnflhaav(D,E,P,d)
int	D;	
list	E, P;
single	d;

{	floating	lh;
	single		n;

	init(lh,n);

	bind(D,E,P,d);

	n=flinit(d);

	if(D<0)
	{	lh=ecqnflhaavimag(D,E,P,d);
		lh=flprod(itofl(2),lh);
	}
	else
		lh=ecqnflhaavreal(D,E,P,d);

	return(lh);
}

/*         case 1: D > 0 , i.e. K = (Q(D^{1/2))         */
/*         is  a  real  quadratic  number field         */

floating  ecqnflhaavreal(D,E,P,d)
int	D;	
list	E,P;
single	d;

{	nfel		hnf,tp,h3,h4,b2a,b4a,b6a,b8a,xp;
	single		b,n,N;
	floating	l,l1,l2,g,h,h1,xa,ta,wa,za,mu;
	list		b2,bb2,b4,bb4,b6,bb6,b8,bb8,hh,hh1;
	list		x,xc,t,tc,w,wc,z,zc,L;
	init(hnf,tp);
	init(b,n);
	init(l,l1,l2,g,h,h1,xa,ta,wa,za,mu,N,L,h3,h4,b2a,b4a,b6a,b8a);
	init(x,xc,xp,t,tc,w,wc,z,zc,b2,bb2,b4,bb4,b6,bb6,b8,bb8,hh,hh1);
	bind(D,E,P,d);

	L=ecqnflhaavnterm(D,E,d);
	N=lfirst(L);xp=lfirst(P);
	
	b2a=ecqnfacb2(E);b2=qnftoqnffl(D,b2a);	
	b4a=ecqnfacb4(E);b4=qnftoqnffl(D,b4a);	
	b6a=ecqnfacb6(E);b6=qnftoqnffl(D,b6a);
	b8a=ecqnfacb8(E);b8=qnftoqnffl(D,b8a);
	
	bb2=qnfflisum(D,b2,-12);
	hh=qnffldif(D,b4,b2);bb4=qnfflisum(D,hh,6);
	hh=qnffliprod(D,b4,-2);hh=qnfflsum(D,b6,hh);
	hh=qnfflsum(D,hh,b2);bb6=qnfflisum(D,hh,-4);
	hh=qnffliprod(D,b6,-3);bb8=qnfflsum(D,b8,hh);
	hh=qnffliprod(D,b4,3);bb8=qnfflsum(D,bb8,hh);
	hh=qnffldif(D,bb8,b2);bb8=qnfflisum(D,hh,3);
	
	xa=qnfabs(D,xp);
	h=flquot(itofl(1),itofl(2));
	if(flcomp(xa,h)>=0)
	{	tp=qnfinv(D,xp);
		b=1;
	}
	else
	{	tp=qnfisum(D,xp,1);
		tp=qnfinv(D,tp);
		b=0;	
	}
	ta=qnfabs(D,tp);t=qnftoqnffl(D,tp);
	l1=fllog(ta);
	l1=flneg(l1);
	n=0;mu=itofl(0);
	while(n<=N)
	{	if(b)
		{	hh=qnffliprod(D,t,4);hh1=qnfflexp(D,t,2);
			hh1=qnfflprod(D,hh1,b2);hh=qnfflsum(D,hh,hh1);
			hh1=qnfflexp(D,t,3);hh1=qnfflprod(D,hh1,b4);
			hh1=qnffliprod(D,hh1,2);hh=qnfflsum(D,hh,hh1);
			hh1=qnfflexp(D,t,4);hh1=qnfflprod(D,hh1,b6);
			w=qnfflsum(D,hh,hh1);
			hh=qnfflexp(D,t,2);hh=qnfflprod(D,hh,b4);
			hh1=qnfflexp(D,t,3);hh1=qnfflprod(D,hh1,b6);
			hh1=qnffliprod(D,hh1,2);hh=qnfflsum(D,hh,hh1);
			hh1=qnfflexp(D,t,4);hh1=qnfflprod(D,hh1,b8);
			hh=qnfflsum(D,hh,hh1);hh=qnfflneg(D,hh);
			z=qnfflisum(D,hh,1);
			wa=qnfflabs(D,w);za=qnfflabs(D,z);
			h=flprod(za,itofl(2));
			if(flcomp(wa,h)<=0)
			{	za=fllog(za);
				h1=flsexp(itofl(4),-n);
				h1=flprod(h1,za);
				mu=flsum(mu,h1);
				t=qnfflquot(D,w,z);
			}
			else
			{	z=qnfflsum(D,z,w);
				za=qnfflabs(D,z);
				za=fllog(za);
				h1=flsexp(itofl(4),-n);
				h1=flprod(h1,za);
				mu=flsum(mu,h1);
				t=qnfflquot(D,w,z);
				b=0;
			}
		}
		else
		{	hh=qnffliprod(D,t,4);hh1=qnfflexp(D,t,2);
			hh1=qnfflprod(D,hh1,bb2);hh=qnfflsum(D,hh,hh1);
			hh1=qnfflexp(D,t,3);hh1=qnfflprod(D,hh1,bb4);
			hh1=qnffliprod(D,hh1,2);hh=qnfflsum(D,hh,hh1);
			hh1=qnfflexp(D,t,4);hh1=qnfflprod(D,hh1,bb6);
			w=qnfflsum(D,hh,hh1);
			hh=qnfflexp(D,t,2);hh=qnfflprod(D,hh,bb4);
			hh1=qnfflexp(D,t,3);hh1=qnfflprod(D,hh1,bb6);
			hh1=qnffliprod(D,hh1,2);hh=qnfflsum(D,hh,hh1);
			hh1=qnfflexp(D,t,4);hh1=qnfflprod(D,hh1,bb8);
			hh=qnfflsum(D,hh,hh1);hh=qnfflneg(D,hh);
			z=qnfflisum(D,hh,1);
			wa=qnfflabs(D,w);za=qnfflabs(D,z);
			h=flprod(za,itofl(2));
			if(flcomp(wa,h)<=0)
			{	za=fllog(za);
				h1=flsexp(itofl(4),-n);
				h1=flprod(h1,za);
				mu=flsum(mu,h1);
				t=qnfflquot(D,w,z);
			}
			else
			{	z=qnffldif(D,z,w);
				za=qnfflabs(D,z);
				za=fllog(za);
				h1=flsexp(itofl(4),-n);
				h1=flprod(h1,za);
				mu=flsum(mu,h1);
				t=qnfflquot(D,w,z);
				b=1;
			}
		}
		n++;
	}
	h=flquot(mu,itofl(4));
	l1=flsum(l1,h);
	
	N=lsecond(L);
	hnf=qnfconj(D,xp);xa=qnfabs(D,hnf);
	h=flquot(itofl(1),itofl(2));
	if(flcomp(xa,h)>=0)
	{	tp=qnfinv(D,xp);
		b=1;
	}
	else
	{	tp=qnfisum(D,xp,1);
		tp=qnfinv(D,tp);
		b=0;	
	}
	hnf=qnfconj(D,tp);ta=qnfabs(D,hnf);
	t=qnftoqnffl(D,tp);
	l2=fllog(ta);
	l2=flneg(l2);
	n=0;mu=itofl(0);
	while(n<=N)
	{	if(b)
		{	hh=qnffliprod(D,t,4);hh1=qnfflexp(D,t,2);
			hh1=qnfflprod(D,hh1,b2);hh=qnfflsum(D,hh,hh1);
			hh1=qnfflexp(D,t,3);hh1=qnfflprod(D,hh1,b4);
			hh1=qnffliprod(D,hh1,2);hh=qnfflsum(D,hh,hh1);
			hh1=qnfflexp(D,t,4);hh1=qnfflprod(D,hh1,b6);
			w=qnfflsum(D,hh,hh1);
			hh=qnfflexp(D,t,2);hh=qnfflprod(D,hh,b4);
			hh1=qnfflexp(D,t,3);hh1=qnfflprod(D,hh1,b6);
			hh1=qnffliprod(D,hh1,2);hh=qnfflsum(D,hh,hh1);
			hh1=qnfflexp(D,t,4);hh1=qnfflprod(D,hh1,b8);
			hh=qnfflsum(D,hh,hh1);hh=qnfflneg(D,hh);
			z=qnfflisum(D,hh,1);
			wc=qnfflconj(D,w);wa=qnfflabs(D,wc);
			zc=qnfflconj(D,z);za=qnfflabs(D,zc);
			h=flprod(za,itofl(2));
			if(flcomp(wa,h)<=0)
			{	za=fllog(za);
				h1=flsexp(itofl(4),-n);
				h1=flprod(h1,za);
				mu=flsum(mu,h1);
				t=qnfflquot(D,w,z);
			}
			else
			{	z=qnfflsum(D,z,w);
				zc=qnfflconj(D,z);
				za=qnfflabs(D,zc);
				za=fllog(za);
				h1=flsexp(itofl(4),-n);
				h1=flprod(h1,za);
				mu=flsum(mu,h1);
				t=qnfflquot(D,w,z);
				b=0;
			}
		}
		else
		{	hh=qnffliprod(D,t,4);hh1=qnfflexp(D,t,2);
			hh1=qnfflprod(D,hh1,bb2);hh=qnfflsum(D,hh,hh1);
			hh1=qnfflexp(D,t,3);hh1=qnfflprod(D,hh1,bb4);
			hh1=qnffliprod(D,hh1,2);hh=qnfflsum(D,hh,hh1);
			hh1=qnfflexp(D,t,4);hh1=qnfflprod(D,hh1,bb6);
			w=qnfflsum(D,hh,hh1);
			hh=qnfflexp(D,t,2);hh=qnfflprod(D,hh,bb4);
			hh1=qnfflexp(D,t,3);hh1=qnfflprod(D,hh1,bb6);
			hh1=qnffliprod(D,hh1,2);hh=qnfflsum(D,hh,hh1);
			hh1=qnfflexp(D,t,4);hh1=qnfflprod(D,hh1,bb8);
			hh=qnfflsum(D,hh,hh1);hh=qnfflneg(D,hh);
			z=qnfflisum(D,hh,1);
			wc=qnfflconj(D,w);wa=qnfflabs(D,wc);
			zc=qnfflconj(D,z);za=qnfflabs(D,zc);
			h=flprod(za,itofl(2));
			if(flcomp(wa,h)<=0)
			{	za=fllog(za);
				h1=flsexp(itofl(4),-n);
				h1=flprod(h1,za);
				mu=flsum(mu,h1);
				t=qnfflquot(D,w,z);
			}
			else
			{	z=qnffldif(D,z,w);
				zc=qnfflconj(D,z);
				za=qnfflabs(D,zc);
				za=fllog(za);
				h1=flsexp(itofl(4),-n);
				h1=flprod(h1,za);
				mu=flsum(mu,h1);
				t=qnfflquot(D,w,z);
				b=1;
			}
		}
		n++;
	}
	h=flquot(mu,itofl(4));
	l2=flsum(l2,h);	
	l=flsum(l1,l2);
	return(l);
}

/*         case 2: D < 0 ,    i.e. K = (Q(D^{1/2))         */
/*         is an imaginary quadratic number field          */

floating  ecqnflhaavimag(D,E,P,d)
int	D;	
list	E,P;
single	d;
{	nfel		hnf,xp;
	single		b,n,N;
	floating	l,h,h1,g,xa,ta,wa,za,mu;
	complex		x,t,w,z,b2,bb2,b4,bb4,b6,bb6,b8,bb8,c,hh,hh1;
	list		L;

	init(hnf);
	init(b,n,N);
	init(l,h,h1,g,xa,ta,wa,za,mu);
	init(x,xp,t,w,z,b2,bb2,b4,bb4,b6,bb6,b8,bb8,c,hh,hh1,L);
	bind(D,E,P,d);
	
	L=ecqnflhaavnterm(D,E,d);
	N=lfirst(L);xp=lfirst(P);

	x=qnftoc(D,xp);
	hnf=ecqnfacb2(E);b2=qnftoc(D,hnf);
	hnf=ecqnfacb4(E);b4=qnftoc(D,hnf);
	hnf=ecqnfacb6(E);b6=qnftoc(D,hnf);
	hnf=ecqnfacb8(E);b8=qnftoc(D,hnf);
	
	bb2=cisum(b2,-12);
	hh=cdif(b4,b2);bb4=cisum(hh,6);
	hh=ciprod(b4,-2);hh=csum(b6,hh);
	hh=csum(hh,b2);bb6=cisum(hh,-4);
	hh=ciprod(b6,-3);bb8=csum(b8,hh);
	hh=ciprod(b4,3);bb8=csum(bb8,hh);
	hh=cdif(bb8,b2);bb8=cisum(hh,3);
	
	xa=cabsv(x);h=flquot(itofl(1),itofl(2));
	g=itofl(1);hh1=fltoc(g);
	if(flcomp(xa,h)>=0)
	{	t=cquot(hh1,x);
		b=1;
	}
	else
	{	hh=cisum(x,1);t=cquot(hh1,hh);
		b=0;	
	}
	ta=cabsv(t);
	l=fllog(ta);
	l=flneg(l);
	n=0;mu=itofl(0);
	while(n<=N)
	{	if(b)
		{	hh=ciprod(t,4);hh1=csexp(t,2);
			hh1=cprod(hh1,b2);hh=csum(hh,hh1);
			hh1=csexp(t,3);hh1=cprod(hh1,b4);
			hh1=ciprod(hh1,2);hh=csum(hh,hh1);
			hh1=csexp(t,4);hh1=cprod(hh1,b6);
			w=csum(hh,hh1);
			hh=csexp(t,2);hh=cprod(hh,b4);
			hh1=csexp(t,3);hh1=cprod(hh1,b6);
			hh1=ciprod(hh1,2);hh=csum(hh,hh1);
			hh1=csexp(t,4);hh1=cprod(hh1,b8);
			hh=csum(hh,hh1);hh=cneg(hh);
			z=cisum(hh,1);
			wa=cabsv(w);za=cabsv(z);h=flprod(za,itofl(2));
			if(flcomp(wa,h)<=0)
			{	za=fllog(za);
				h1=flsexp(itofl(4),-n);
				h1=flprod(h1,za);
				mu=flsum(mu,h1);
				t=cquot(w,z);
			}
			else
			{	z=csum(z,w);
				za=cabsv(z);
				za=fllog(za);
				h1=flsexp(itofl(4),-n);
				h1=flprod(h1,za);
				mu=flsum(mu,h1);
				t=cquot(w,z);
				b=0;
			}
		}
		else
		{	hh=ciprod(t,4);hh1=csexp(t,2);
			hh1=cprod(hh1,bb2);hh=csum(hh,hh1);
			hh1=csexp(t,3);hh1=cprod(hh1,bb4);
			hh1=ciprod(hh1,2);hh=csum(hh,hh1);
			hh1=csexp(t,4);hh1=cprod(hh1,bb6);
			w=csum(hh,hh1);
			hh=csexp(t,2);hh=cprod(hh,bb4);
			hh1=csexp(t,3);hh1=cprod(hh1,bb6);
			hh1=ciprod(hh1,2);hh=csum(hh,hh1);
			hh1=csexp(t,4);hh1=cprod(hh1,bb8);
			hh=csum(hh,hh1);hh=cneg(hh);
			z=cisum(hh,1);
			wa=cabsv(w);za=cabsv(z);h=flprod(za,itofl(2));
			if(flcomp(wa,h)<=0)
			{	za=fllog(za);
				h1=flsexp(itofl(4),-n);
				h1=flprod(h1,za);
				mu=flsum(mu,h1);
				t=cquot(w,z);
			}
			else
			{	z=cdif(z,w);
				za=cabsv(z);
				za=fllog(za);
				h1=flsexp(itofl(4),-n);
				h1=flprod(h1,za);
				mu=flsum(mu,h1);
				t=cquot(w,z);
				b=1;
			}
		}
	n++;
	}
	h=flquot(mu,itofl(4));
	l=flsum(l,h);
	return(l);
}

/*   qnftofl() computes for an element a=x+y*D^(1/2)   */
/*   of  the real quadratic number field  K(D^(1/2))   */
/*   the real number x+y*D^(1/2).                      */

floating qnftofl(D,a)
int	D;
nfel	a;
{	floating f,n,z,h,DD;
	bind(D,a);
	init(f,n,z,h,DD);
	
	if(qnfnorm(D,a))
	{	if(!lsecond(a))
		{	n=itofl(lfirst(a));
			z=itofl(lthird(a));
			f=flquot(z,n);
		}
		else
		{	n=itofl(lfirst(a));h=itofl(lthird(a));
			z=itofl(lfourth(a));
			DD=itofl(D);DD=flsqrt(DD);
			h=flprod(h,DD);h=flsum(h,z);
			f=flquot(h,n);
		}
	}
	else
		f=0;
	return(f);
}

/*   qnfabs() computes for an element a=x+y*D^(1/2)   */
/*   of the quadratic number field  K(D^(1/2))  the   */
/*   absolute values  |x+y*D^(1/2)|, if D > 0,  and   */
/*   (x^2-y^2D)^(1/2), if D < 0.                      */

floating qnfabs(D,a)
int	D;
nfel	a;
{	floating f;
	rat	r;
	bind(D,a);
	init(f,r);
	if(D<0)
	{	r=qnfnorm(D,a);
		r=rabs(r);
		f=rtofl(r);
		f=flsqrt(f);
	}
	else
	{	f=qnftofl(D,a);
		f=flabs(f);
	}
	return(f);
}

/*   qnftoqnffl() converts an element a=x+y*D^(1/2)   */
/*   of  the real quadratic number field K(D^(1/2))   */
/*   into a list  ( x y )  with real entries x,y.     */

list qnftoqnffl(D,a)
int	D;
nfel	a;
{	floating	c,d,x,y,n;
	list		L;
	init(c,d,x,y,n,L);
	bind(D,a);
	
	if(qnfnorm(D,a))
	{	n=itofl(lfirst(a));
		if(!lsecond(a))
		{	x=itofl(lthird(a));
			c=flquot(x,n);
			d=itofl(0);
		}
		else
		{	x=itofl(lfourth(a));
			y=itofl(lthird(a));
			c=flquot(x,n);
			d=flquot(y,n);
		}
	}
	else
	{	c=itofl(0);
		d=itofl(0);
	}
	L=list2(c,d);
	return(L);
}

/*   qnfflneg() computes for the given list ( x y )   */
/*   representing  the  element   a=x+y*D^(1/2)  of   */ 
/*   K=Q(D^(1/2))  the additive inverse -a ,   i.e.   */
/*   the list ( -x -y ).                              */

list qnfflneg(D,aa)
int	D;
list	aa;
{	floating	c,d;
	list		L;
	init(c,d,L);
	bind(D,aa);
	c=lfirst(aa);d=lsecond(aa);
	c=flneg(c);d=flneg(d);
	L=list2(c,d);
	return(L);
}

/*   qnfflsum() computes for ( x1 y1 ) and ( x2 y2 ) the   */
/*   sum  ( x1+x2  y1+y2 ) ,  i.e. the list representing   */
/*   the element  (x1+x2)+(y1+y2)*D^(1/2) of K(D^(1/2)).   */

list qnfflsum(D,aa,bb)
int	D;
list	aa,bb;
{	floating	c,d,x,y;
	list		L;
	init(c,d,x,y,L);
	bind(D,aa,bb);
	x=lfirst(aa);y=lfirst(bb);
	c=flsum(x,y);
	x=lsecond(aa);y=lsecond(bb);
	d=flsum(x,y);
	L=list2(c,d);
	return(L);
}

/*   qnfflexp() computes for the list ( x y ) representing   */ 
/*   the element a=x+y*D^(1/2)  of the real quadratic num-   */
/*   ber field K=Q(D^(1/2)) and for n in N the list repre-   */
/*   senting the power a^n.                                 */

list qnfflexp(D,aa,n)
int	D;
list	aa;
single	n;
{	floating	x,y;
	list		bb,L;
	single		e;
	init(x,y,bb,L,e);
	bind(D,aa,n);
	bb=aa;
	for(e=1;e<n;e++)
		bb=qnfflprod(D,aa,bb);
	return(bb);
}

/*   qnfflabs() computes for the list ( x y ) represen-   */
/*   ting the element a=x+y*D^(1/2) of the real quadra-   */
/*   tic number field  K=Q(D^(1/2))  the absolute value   */
/*   |x+y*D^(1/2)|.		            		  */

floating qnfflabs(D,aa)
int	D;
list	aa;
{	floating	a,b,c;
	init(a,b,c);
	bind(D,aa);
	a=lfirst(aa);b=lsecond(aa);
	c=flsqrt(itofl(D));
	b=flprod(b,c);
	a=flsum(a,b);
	a=flabs(a);
	return(a);
}

/*   qnffliprod() computes for the list ( x1 y1 ) repre-   */
/*   senting the element a=x+y*D^(1/2)  of the real qua-   */
/*   dratic number field K=Q(D^(1/2)) and for m in Z the   */
/*   product m*a, i.e. the list ( m*x m*y ).	           */

list qnffliprod(D,aa,m)
int	D,m;
list	aa;
{	floating	c,d;
	list		L;
	init(c,d,L);
	bind(D,aa,m);
	c=lfirst(aa);
	d=lsecond(aa);
	c=flprod(c,itofl(m));
	d=flprod(d,itofl(m));
	L=list2(c,d);
	return(L);
}

/*   qnfflquot() computes for ( x1 y1 ) and  (x2 y2 )   */
/*   representing  the  elements a and b  of the real   */
/*   quadratic number field K=Q(D^(1/2)) the quotient   */
/*   a/b, i.e. the list representing a/b.               */

list qnfflquot(D,aa,bb)
int	D;
list	aa,bb;
{	floating	a,b,c,d,x,y,h1,h2,n;
	list		L;
	init(a,b,c,d,x,y,h1,h2,n,L);
	bind(D,aa,bb);
	a=lfirst(aa);b=lsecond(aa);
	c=lfirst(bb);d=lsecond(bb);
	h1=flsexp(c,2);h2=flsexp(d,2);
	h2=flprod(h2,itofl(D));
	n=fldif(h1,h2);
	h1=flprod(a,c);h2=flprod(b,d);
	h2=flprod(h2,itofl(D));
	h1=fldif(h1,h2);
	x=flquot(h1,n);
	h1=flprod(b,c);h2=flprod(a,d);
	h1=fldif(h1,h2);
	y=flquot(h1,n);
	L=list2(x,y);
	return(L);
}

/*   fltoqnffl() converts a real number f into a   */
/*   list ( f 0 ).				   */

list fltoqnffl(D,f)
int		D;
floating	f;
{	list	L;
	init(L);
	bind(D,f);
	L=list2(f,itofl(0));
	return(L);
}

/*   qnffldif() computes for ( x1 y1 ) and ( x2 y2 ) the   */
/*   difference  ( x1-x2  y1-y2 ) , i.e. the list repre-   */
/*   senting  the  element   (x1-x2)+(y1-y2)*D^(1/2)  of   */
/*   K(D^(1/2)).                                           */

list qnffldif(D,aa,bb)
int	D;
list	aa,bb;
{	floating	c,d,x,y;
	list		L;
	init(c,d,x,y,L);
	bind(D,aa,bb);
	x=lfirst(aa);y=lfirst(bb);
	c=fldif(x,y);
	x=lsecond(aa);y=lsecond(bb);
	d=fldif(x,y);
	L=list2(c,d);
	return(L);
}

/*   qnfflprod() computes for  ( x1 y1 )  and  (x2 y2 )   */
/*   representing the elements  a  and  b  of the  real   */
/*   quadratic  number field  K=Q(D^(1/2))  the product   */
/*   a*b, i.e. the list ( x1*x2+y1*y2*D  x1*y2+x2*y1 ).   */

list qnfflprod(D,aa,bb)
int	D;
list	aa,bb;
{	floating	a,b,c,d,x,y,h;
	list		L;
	init(a,b,c,d,x,y,h,L);
	bind(D,aa,bb);
	a=lfirst(aa);b=lsecond(aa);
	c=lfirst(bb);d=lsecond(bb);
	x=flprod(a,c);h=flprod(b,d);
	h=flprod(h,itofl(D));
	x=flsum(x,h);
	y=flprod(a,d);h=flprod(b,c);
	y=flsum(y,h);	
	L=list2(x,y);
	return(L);
}

/*   qnfflisum() computes for the list ( x1 y1 ) repre-   */
/*   senting the element a=x+y*D^(1/2) of the real qua-   */
/*   dratic  number field K=Q(D^(1/2)) and for  m  in Z   */
/*   the sum a+m, i.e. the list ( x+m y ).     	          */

list qnfflisum(D,aa,m)
int	D,m;
list	aa;
{	floating	c,d;
	list		L;
	init(c,d,L);
	bind(D,aa,m);
	c=lfirst(aa);
	d=lsecond(aa);
	c=flsum(c,itofl(m));
	L=list2(c,d);
	return(L);
}

/*   qnfflconj() computes for the list ( x y ) repre-   */
/*   senting the real quadratic number field  element   */
/*   a=x+y*D^(1/2)  of  K=Q(D^(1/2))  the  conjugated   */
/*   element, i.e. the list ( x -y ).                   */

list qnfflconj(D,aa)
int	D;
list	aa;
{	floating	x,y;
	list		L;
	init(x,y,L);
	bind(D,aa);
	x=lfirst(aa);y=lsecond(aa);
	y=flneg(y);
	L=list2(x,y);
	return(L);
}

/*   qnftoc() converts an element  a=x+y*D^(1/2) of the   */
/*   imaginary quadratic number field K=Q(D^(1/2)) into   */
/*   a complex element ( x y*(-D)^(1/2) ).                */

complex qnftoc(D,a)
int	D;
nfel	a;
{	complex		c;
	floating	cr,ci,n,z,d;

	bind(D,a);
	init(c,cr,ci,n,z,d);

	if(qnfnorm(D,a))
	{	if(!lsecond(a))
		{	n=itofl(lfirst(a));
			z=itofl(lthird(a));
			cr=flquot(z,n);
			ci=itofl(0);
		}
		else
		{	d=itofl(ineg(D));
			d=flsqrt(d);
			n=itofl(lfirst(a));
			z=itofl(lthird(a));
			z=flprod(z,d);
			ci=flquot(z,n);
			z=itofl(lfourth(a));
			cr=flquot(z,n);
		}
	}
	else
	{	cr=itofl(0);
		ci=itofl(0);
	}
	c=ccri(cr,ci);
	return(c);
}

/*   ecqnflhaavnterm() computes the number of needed  loops   */
/*   for the computation of the local  archimedean  heights   */
/*   to achieve an exactness of more than d decimal places.   */  

list ecqnflhaavnterm(D,E,d)
int	D;
list	E;
single	d;
{	rat		r;
	floating	f,g;
	nfel		b;
	single		n,m;
	list		L;

	init(r,f,g,b,n,m,L);
	bind(D,E,d);

	if(D<0)
	{	b=ecqnfacb2(E);
		r=qnfnorm(D,b);f=rtofl(r);f=flsqrt(f);
		if(flcomp(itofl(4),f)>0)
			f=itofl(4);
		b=ecqnfacb4(E);
		r=qnfnorm(D,b);g=rtofl(r);g=flsqrt(g);
		g=flprod(itofl(2),g);
		if(flcomp(g,f)>0)
			f=g;
		b=ecqnfacb6(E);
		r=qnfnorm(D,b);g=rtofl(r);g=flsqrt(g);
		g=flprod(itofl(2),g);
		if(flcomp(g,f)>0)
			f=g;
		b=ecqnfacb8(E);
		r=qnfnorm(D,b);
		g=rtofl(r);g=flsqrt(g);
		if(flcomp(g,f)>0)
			f=g;
		f=fllog(f);f=flprod(itofl(4),f);
		f=flquot(f,itofl(3));f=flsum(itofl(7),f);
		b=ecqnfacdisc(E);
		r=qnfnorm(D,b);g=rtofl(r);g=flsqrt(g);
		g=flquot(itofl(1),g);
		if(flcomp(g,itofl(1))>0)
		{	g=fllog(g);
			g=flquot(g,itofl(3));
			f=flsum(f,g);
		}
		f=fllog(f);f=flprod(itofl(3),f);
		f=flquot(f,itofl(4));
		g=flquot(itofl(1),itofl(2));
		f=flsum(f,g);
		g=flquot(itofl(5),itofl(3));g=flprod(g,itofl(d));
		f=flsum(f,g);
		n=flfloor(f);
		if(flcomp(f,itofl(n))>0)
				n++;
		L=list1(n);
	}
	else
	{	m=1;L=_0;
		while(m<3)
		{	b=ecqnfacb2(E);
			if(m==2)
				b=qnfconj(D,b);
			f=qnftofl(D,b);f=flabs(f);
			if(flcomp(itofl(4),f)>0)
				f=itofl(4);
			b=ecqnfacb4(E);		
			if(m==2)
				b=qnfconj(D,b);
			g=qnftofl(D,b);g=flabs(g);g=flprod(itofl(2),g);
			if(flcomp(g,f)>0)
				f=g;
			b=ecqnfacb6(E);					
			if(m==2)
				b=qnfconj(D,b);
			g=qnftofl(D,b);g=flabs(g);g=flprod(itofl(2),g);
			if(flcomp(g,f)>0)
				f=g;
			b=ecqnfacb8(E);					
			if(m==2)
				b=qnfconj(D,b);
			g=qnftofl(D,b);g=flabs(g);
			if(flcomp(g,f)>0)
				f=g;
			
			f=fllog(f);f=flprod(itofl(4),f);
			f=flquot(f,itofl(3));f=flsum(itofl(7),f);
			b=ecqnfacdisc(E);
			if(m==2)
				b=qnfconj(D,b);
			g=qnftofl(D,b);g=flabs(g);
			g=flquot(itofl(1),g);
			if(flcomp(g,itofl(1))>0)
			{	g=fllog(g);
				g=flquot(g,itofl(3));
				f=flsum(f,g);
			}
			f=fllog(f);f=flprod(itofl(3),f);
			f=flquot(f,itofl(4));
			g=flquot(itofl(1),itofl(2));
			f=flsum(f,g);
			g=flquot(itofl(5),itofl(3));g=flprod(g,itofl(d));
			f=flsum(f,g);
			n=flfloor(f);
			if(flcomp(f,itofl(n))>0)
				n++;
			L=lcomp(n,L);
			m++;
		}		
		L=linv(L);		
	}
	return(L);
}	



