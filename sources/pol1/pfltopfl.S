/*M
.SH NAME
pfltopfl - polynomial over floating point numbers to polynomial over floating point numbers  

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol pfltopfl(r, P)
single r;
pol P;

.SH DESCRIPTION
pfltopfl() returns the polynomial P in r variables over
floating point numbers as a new polynomial over floating point numbers
with the coefficients represented according to the actual value of FL_EPS.

.SH SEE ALSO
fltofl, pctopc
M*/


/*H
	Version  1      02.03.1995      S.Schmitt
   DATE pfltopfl      : 951201
H*/

#include<_pol1.h>

pol pfltopfl(r,P)
single r;
pol P;
{
	floating A;
	list E;
	pol PS;
	bind(P);
	init(A,E,PS);

	if (!r)  P=fltofl(P);
	else if(P)
	{	PS = ptodip(r,P);
		P = _0;
		while (PS != _0) 
		{	A = lfirst(PS);
			E = lsecond(PS);
			PS = lred2(PS);
			A=fltofl(A);
			P = lcomp2(E,A,P);	
		}
		P = linv(P);
		P = diptop(r,P);
	}

	return(P);
}
