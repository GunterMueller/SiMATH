/*M
.SH NAME 
isqnfpihom0 - is quadratic number field element prime ideal homomorphism zero
.SH SYNOPSIS
.nf
#include<_arith2.h>

single isqnfpihom0(D, P, pi, z, a)
int      D;
list     P;
nfel     pi, a;
single   z;

.SH DESCRIPTION

.TP 3 
isqnfpihom0() returns:
1, if a is congruent 0 modulo P, \   \    \    \    \   \  \  
0, if a is not congruent 0 modulo P, \   \    \    \    \  \ 
where P is a prime ideal in the ring of integers O_K of a quadratic number field K = Q(D^(1/2)).

.PP
.TP 4
.B D
is a squarefree integer not equal to 0 or 1.
.TP 4
.B P
is a prime ideal in the ring of integers O_K of K (see 'qnfidprod').
.TP 4
.B pi
is a prime element of the prime ideal P.
.TP 4
.B z
is 0, 1 or 2, if the prime ideal P divides an inert, ramified or split prime number in Q.
.TP 4
.B a
is an element of K. 
M*/

#include<_arith2.h>

single isqnfpihom0(D,P,pi,z,a)
int	D;
list	P;
nfel	pi,a;
single	z;
{	single	e;
	int	c,d,x,y,m,n,p;
	rat	r,s;
	nfel	h;
	list	L;
	
	init(c,d,x,y,L,m,n,p,e,r,s,h);
	bind(D,P,pi,z,a);

	p=lfirst(P);p=iprod(p,lsecond(P));
	p=iquot(p,lfourth(P));

	if(z==2)
	{
	if(isqnfiel(D,a))
	{	L=qnfielbasvec(D,pi);
		c=lfirst(L);d=lsecond(L);
		L=qnfielbasvec(D,a);
		x=lfirst(L);y=lsecond(L);
		y=iprod(y,c);y=iprod(y,d);
		x=idif(x,y);
		x=mihom(p,x);
	}
	else
	{	n=lfirst(a);m=mihom(p,n);h=qnfiprod(D,a,n);
		if(m)
		{	L=qnfielbasvec(D,pi);
			c=lfirst(L);d=lsecond(L);
			L=qnfielbasvec(D,h);
			x=lfirst(L);y=lsecond(L);
			y=iprod(y,c);y=iprod(y,d);
			x=idif(x,y);
			x=mihom(p,x);
			n=miinv(p,m);
			x=iprod(n,x);x=mihom(p,x);
		}
		else
		{	r=qnfnorm(D,h);
			s=qnftrace(D,h);	
			s=rprod(s,itor(n));
			r=rquot(r,s);
			c=rnum(r);d=rden(r);
			c=mihom(p,c);d=mihom(p,d);
			d=miinv(p,d);
			c=iprod(c,d);x=mihom(p,c);
		}
	}
	if(!x)
		e=1;
	}
	else
	{	r=qnfnorm(D,a);
		if(!mihom(p,rnum(r)))
			e=1;
		else
			e=0;
	}
	return(e);
}