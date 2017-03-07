/*M
.SH NAME
isqnfelsqu - is quadratic number field element square

.SH SYNOPSIS
.nf
#include<_arith2.h>

single isqnfelsqu(d,y1,y2,z1,z2)
int d;
rat y1,y2;
rat *z1,*z2;

.SH DESCRIPTION
isqnfelsqu() tests, if the number y1+sqrt(d)*y2 is a square in Q(sqrt(d)).
If this is a square, isqnfelsqu() returns 1 and 
y1+sqrt(d)*y2 = (z1+sqrt(d)*z2)^2. Else, isqnfelsqu() returns 0.
M*/
/*H
        Version 1       31.07.1998      Susanne Schmitt
   DATE isqnfelsqu     : 980731
H*/


# include <_arith2.h>

single isqnfelsqu(d,y1,y2,u,v)
int d;
rat y1,y2,*u,*v;
{
	rat w,h,k,rd;
	
	init(w,h,k,rd);
	bind(d,y1,y2,*u,*v);

	*u = itor(0);
	*v = itor(0);
	rd = itor(d);
	if(!y2)
	{	if(isrsqr(y1)==1)
		{	*u = rsqrt(y1);
			return(1);
		}
		y1 = rquot(y1,rd);
	 	if(isrsqr(y1)==1)
		{	*v = rsqrt(y1);
			return(1);
		}
		return(0);
	}

	w = rprod(y1,y1);
	h = rprod(y2,y2);
	h = rprod(h,rd);
	w = rdif(w,h);

	if(isrsqr(w)!=1) return(0);
	w = rsqrt(w);
	k = rsum(rd,rd);

	h = rdif(y1,w);
	h = rquot(h,k);
	if(isrsqr(h)==1)
	{	h = rsqrt(h);
		*v = h;
		h = rsum(h,h);
		h = rquot(y2,h);
		*u = h;
		return(1);
	}

	h = rsum(y1,w);
	h = rquot(h,k);
	if(isrsqr(h)==1)
	{	h = rsqrt(h);
		*v = h;
		h = rsum(h,h);
		h = rquot(y2,h);
		*u = h;
		return(1);
	}
	
	return(0);
}

