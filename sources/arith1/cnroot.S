/*M
.SH NAME 
cnroot - complex number n-th root

.SH SYNOPSIS
.nf
#include<_arith1.h>

list cnroot( c, n )
complex	c;
single	n;

.SH DESCRIPTION
cnroot() returns a list of all n-th roots of a complex number c ( c^(1/n) ).
.PP
.TP 4
.B c
is a complex number.
.TP 4
.B n
is a single integer ( for the n-th root ).
M*/
/*H
        Version 1       24.04.1997      Andreas Heiser
   DATE cnroot   :  
H*/

#include<_arith1.h>

list cnroot(c,n)
complex	c;
single	n;
{	list		L;
	floating	a,b,arg,g,h;
	complex		z;
	single		i;
	
	init(L,a,b,arg,g,h,z,i);
	bind(c,n);

	L=_0;
	arg=carg(c);

	g=cabsv(c);
	h=flquot(itofl(1),itofl(n));
	g=flpow(g,h);
		
	for(i=0;i<n;i++)
	{	h=flprod(itofl(2),itofl(i));
		h=flprod(h,flPi());
		h=flsum(h,arg);
		h=flquot(h,itofl(n));
		a=flcos(h);a=flprod(a,g);
		b=flsin(h);b=flprod(b,g);
		z=ccri(a,b);
		L=lcomp(z,L);
	}
	L=linv(L);
	return(L);
}
