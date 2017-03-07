/*M
.SH NAME
vncomp - variable name comparison

.SH SYNOPSIS
.nf
#include<_pol1.h>

single vncomp(Vn1, Vn2) 
list Vn1, Vn2;
  
.SH DESCRIPTION
.TP 4
.B Vn1, Vn2
are lists of variables names.
.PP
vncomp returns 
.IP
  0, for Vn1 = Vn2,
  1, for Vn1 < Vn2 (in alphanumerical order),
 -1, for Vn1 > Vn2 (in alphanumerical order).
.PP
vncomp uses following relations:
.PP
 'digit' < 'capital' < 'small letter'.

M*/

/*H
	Version 1       24.02.1988      B. Weis
   DATE vncomp        : 890501
H*/


#include <_pol1.h>

single vncomp(Vn1,Vn2)
list Vn1, Vn2;
{
	single n=0, z1, z2;

/* Vergleich der Variablennamen */

	while (Vn1 != _0  &&  Vn2 != _0) {
		z1 = lfirst(Vn1);
		Vn1 = lred(Vn1);
		z2 = lfirst(Vn2);
		Vn2 = lred(Vn2);
		if (z1 < z2) {n = 1; break;}
		if (z1 > z2) {n = -1; break;}
		}
	if (!n) {
		if (Vn1 != _0) n = -1;
		else if (Vn2 != _0) n = 1;
		}

/* Ausgabe */

	return(n);
}
