/*M
.SH NAME
udprtofl - univariate dense polynomial over rationals to univariate dense polynomial over floatings
.SH SYNOPSIS
#include <_pol1.h>

pol udprtofl( P )
pol    P;

.SH DESCRIPTION
udprtofl() converts an univariate dense polynomial over rational numbers to an univariate dense polynomial over floating point numbers. 
M*/
/*H
        Version 1       19.06.1997      Andreas Heiser
   DATE udprtofl      : 970619
H*/

#include<_pol1.h>

pol udprtofl(P)
pol	P;
{	pol		L;
	floating	a;
	rat		r;
	int		i;

	init(L,a,r,i);
	bind(P);

	i=lfirst(P);
	L=list1(i);
	P=lred(P);

	while(P!=_0)
	{	r=lfirst(P);
		a=rtofl(r);
		L=lcomp(a,L);
		P=lred(P);
	}
	L=linv(L);
	return(L);
}