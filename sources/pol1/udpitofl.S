/*M
.SH NAME
udpitofl - univariate dense polynomial over integers to univariate dense polynomial over floatings
.SH SYNOPSIS
#include <_pol1.h>

pol udpitofl( P )
pol    P;

.SH DESCRIPTION
udpitofl() converts an univariate dense polynomial over the integers to an univariate dense polynomial over floating point numbers. 
M*/
/*H
        Version 1       19.06.1997      Andreas Heiser
   DATE udpitofl      : 970619
H*/

#include<_pol1.h>

pol udpitofl(P)
pol	P;
{	pol		L;
	floating	a;
	int		i;

	init(L,a,i);
	bind(P);

	i=lfirst(P);
	L=list1(i);
	P=lred(P);

	while(P!=_0)
	{	i=lfirst(P);
		a=itofl(i);
		L=lcomp(a,L);
		P=lred(P);
	}
	L=linv(L);
	return(L);
}