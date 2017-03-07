/*M
.SH NAME
sclfupi - special coefficient list from univariate polynomial over the integers

.SH SYNOPSIS
.nf
#include<_pol2.h>

list sclfupi(P,n) 
pol P; 
single n;
 
.SH DESCRIPTION
.TP 4
.B P
is an univariate polynomial over the integer numbers.
.TP 4
.B n
is an integer number, deg(P) < n < BASIS.
.PP
sclfupi returns the 'special coefficient list' (s.upifscl) of P with lenght n.

.SH SEE ALSO
upifscl

M*/
                                 
/*H
	Version 1       15.05.89        J.Schmitt
	Version 2	30.12.90	J.Schmitt
					return(lcinv(P)) geaendert;	
   DATE sclfupi       : 891101.900101
H*/

#include<_pol2.h>

list sclfupi(P,n)
pol P;
single n;
{
	single m,i;                 
	pol P1;
	init(P1);
	bind(P);

	if ( P == 0) {
		P = _0;
		for (i=0;i<n;i++) { P = lcomp(0,P); }
		return(P);
	}
	P = ptodp(1,P);
	m = lfirst(P);
	m = m + 1;
	P = lred(P);
	for (i=(n - m); i>0; i--) { P = lcomp(0,P); }
	P1 = lcinv(P);
	return(P1);
}
