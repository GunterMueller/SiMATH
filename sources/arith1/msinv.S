/*M
.SH NAME
msinv - modular single inverse

.SH SYNOPSIS
.nf
#include<_arith1.h>

single msinv(m,a)
single m,a;

.SH DESCRIPTION
msinv() returns a^(-1) for m>0 and a from Z/mZ in case gcd(a,m)=1,
and 0 otherwise.
M*/
/*H
	Version 1        2.12.1986      B. Weis
	Version 2	14.02.1992	(a,m) > 1 => Rueckgabe 0.  MC
   DATE msinv         : 890501.8910__.920331
H*/

#include <_arith1.h>

single msinv(m,a)
single m,a;
{
	single a1, a3, v1=0, v2=1, v3, q;
/* Initialisierung */
	a1 = m; 
/* Berechnung von a^(-1) */
	while (a > 1)
	{
		q = a1/a; 
		a3 = a1%a; 
		v3 = v1-q*v2;
		a1 = a; 
		a = a3; 
		v1 = v2; 
		v2 = v3;
	}      
	if (!a) return (0);
	if (v2 < 0)  v2 += m;
/* Ausgabe */
	return(v2);
}
