/*M
.SH NAME
upqnfzero - univariate polynomial over quadratic number field, zeros

.SH SYNOPSIS
.nf
#include<_pol3.h>

list upqnfzero (d,P)
int d;
pol P;

.SH DESCRIPTION
upqnfzero() computes the roots of the polynomial P in Q(sqrt(d)). 

.PP
.TP 4
.B d
is a squarefree integer not equal to 0 and 1.
.TP 4
.B P
is a polynomial in one variable over Q(sqrt(d)).
M*/
/*H
        Version 1       31.07.1998      Susanne Schmitt
   DATE isqnfelsqu     : 980731
H*/

# include <_pol3.h>


list upqnfzero(d,P)
int d;
list P;
{
	list Nx,L,Pd;
	nfel a;
	
	init(Nx,L,Pd,a);
	bind(d,P);

	Pd = list4(2,1,0,ineg(d));
	Pd = ptodp(1,Pd);

	L = upnffact(Pd,P);
	L = lred(L);
	Nx = _0;

	while(L!=_0)
	{
		Pd = lfirst(L);
		if(lfirst(Pd)==1)	/** Pd = x-a = (1 (101) 0 a) **/
		{			/** falls a=0: x = (1 0) **/
			if(llength(Pd)==2) a = itonf(0);
			else
			{
				a = lfourth(Pd);
				a = qnfneg(d,a);
			}
			Nx = lcomp(a,Nx);
			
		}
		L = lred2(L);
	}

	return(Nx);

}

