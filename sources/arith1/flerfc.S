/*M
.SH NAME
flerfc - complementary error function

.SH SYNOPSIS
.nf
#include<_arith1.h>   

floating flerfc( x, g ) 
floating x, 
int g;
      
.SH DESCRIPTION
flerfc computes the value of the complementary error function at x with precision 1/g.

M*/

/*H
	Version 1	01.01.1997	Sascha Kessler
H*/
	
#include <_arith1.h>

double fltoCfl();

floating flipow(b,e)
	floating b;
	int e;  
{
	floating p;
	int i;
	init(p,i);
	bind(b,e);
	if (e==0) return 1;
	p=itofl(1);
	for (i=1; (icomp(i,e)<1); i=isum(i,1))
		p=flprod(p,b);
	return p;
};
	
floating erfc1(x,genau)
	floating x;
	int      genau;
{
	floating s,z,flk,eps;
	int i,fak,k,kk;
	bind(x,genau);
	init(i,fak,k,kk,s,z,flk,eps);
	s=itofl(0);
	z=itofl(1);
	eps=flquot(z,itofl(genau));
	
	for (k=0; (flcomp(eps,flabs(z))<0); k=isum(k,1))  
	{
		kk=isum(1,iprod(2,k));
		flk=itofl(kk);
		z=flk;
		z=flipow(x,kk);
		fak=1;
		for (i=1; (icomp(i,k)!=1); i=isum(i,1) ) fak=iprod(fak,i); 
		z=flquot(z,itofl(fak));
		z=flquot(z,flk);
		if (mihom(2,k)) z=flneg(z);
		s=flsum(s,z);
	};
	s=flprod(s,itofl(2));
	s=flquot(s,flsqrt(flPi()));
	s=flneg(s);
	s=flsum(itofl(1),s);
	return s;
};

floating erfc2(x,genau)
	floating x;
	int      genau;
{
	single i;
	int schranke;
	floating X,s,quadx,fl2,z;

	init(X,s,quadx,fl2,z,schranke);
	bind(x,genau);
	
	quadx=flprod(x,x);
	X=quadx;
	X=fldif(X,Cfltofl(0.5));
	fl2=itofl(2);
	
	s=itofl(0);
	
  	/*schranke=flround(flquot(itofl(ilog2(genau)),Cfltofl(1.3)));*/
	z=Cfltofl(1.3);
	schranke=flround(flquot(itofl(ilog2(genau)),z));

	for (i=10; i>=2; i--) 
	{
		/*
		s=i*2+X-s;
		s=(i-1)*(2*i-1)/2/s;
		*/
		z=flsum(itofl(i*2),X);
		s=fldif(z,s);
		z=flquot(itofl((i-1)*(2*i-1)),fl2);
		s=flquot(z,s);
	};
	s=fldif(X,s);
	s=flsum(fl2,s);
	s=flquot(Cfltofl(0.5),s);
	s=flneg(s);
	s=flsum(itofl(1),s);
	X=flexp(flneg(quadx));
	X=flquot(X,flprod(x,flsqrt(flPi())));
	X=flprod(X,s);
	return X;
};
	
	
floating flerfc(x,genau)
	floating x;
	int      genau;
{
	bind(x,genau);
	if (flcomp(x,Cfltofl(2.0))<0)  
				return erfc1(x,genau);
		else		return erfc2(x,genau);
};










































































































