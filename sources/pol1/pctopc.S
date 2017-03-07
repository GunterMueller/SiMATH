/*M
.SH NAME
pctopc - polynomial over the complex numbers to polynomial over the complex numbers  

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol pctopc(r, P)
single r;
pol P;

.SH DESCRIPTION
pctopc() returns the polynomial P in r variables over
the complex numbers as a new polynomial over the complex numbers
with the coefficients represented according to the actual value of FL_EPS.

.SH SEE ALSO
fltofl, pfltopfl
M*/


/*H
	Version  1      02.03.1995      S.Schmitt
   DATE pctopc        : 951201
H*/

#include<_pol1.h>

pol pctopc(r,P)
single r;
pol P;
{
	complex A;
	list E;
	pol PS;
	bind(P);
	init(A,E,PS);

	if (!r)  P=ctoc(P);
	else 
	{	PS = ptodip(r,P);
		P = _0;
		while (PS != _0) 
		{	A = lfirst(PS);
			E = lsecond(PS);
			PS = lred2(PS);
			A=ctoc(A);
			P = lcomp2(E,A,P);	
		}
		P = linv(P);
		P = diptop(r,P);
	}

	return(P);
}
