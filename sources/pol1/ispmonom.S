/*M
.SH NAME
ispmonom - is polynomial monomial ?

.SH SYNOPSIS
.nf
#include<_pol1.h>

single ispmonom(r, P) 
single r; 
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P
is a polynomial in r variables.
.PP
ispmonom returns
.TP 4
1,
if P is a monomial,
.TP 4
0,
else.
 
M*/

/*H
	Version 1       29.03.1988      B. Weis
   DATE ispmonom      : 890501
H*/


#include <_pol1.h>

single ispmonom(r,P)
single r;
pol P;
{
	single a=1;

	if (r  &&  P) for ( ; r; r--) {
			if (lred2(P) != _0) {a = 0; break;}
			P = lsecond(P);
			}

	return(a);
}
