/*M
.SH NAME
upcabslc - univariate polynomial over the complex numbers, absolute value of the largest coefficient

.SH SYNOPSIS
.nf
#include<_pol1.h>

floating upcabslc (P)  
pol P;

.SH DESCRIPTION
.TP 4
.B P
is an univariate polynomial over the complex numbers.
.PP
upcabslc returns the maximum of the absolute values of the coefficients of the polynomial P.

M*/

/*H
        Version 1       15.01.1994	Georg J. Lay
   DATE upcabslc      : 941201
H*/

#include <_pol1.h>

floating upcabslc (P)
pol		   P;
 {
 floating max,a;
 init    (max,a);

 for (max = 0; P != _0; P = lred2 (P))
   {
   a = csabsv (lsecond (P));
   if (flcomp (a,max) > 0)	max = a;
   }

 return (flsqrt (max));
 }
