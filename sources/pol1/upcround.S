/*M
.SH NAME
upcround - univariate polynomial over the complex numbers, round

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol upcround(P, eps)  
pol P; 
floating eps;
     
.SH DESCRIPTION
.TP 4
.B P
is a polynomial over the complex numbers.
.PP
Let [x] be the integer number, which is nearest to x.
.PP
upcround returns the polynomial F with the same monomials as P and coefficients given by below.
.PP
Let p_i be the i-th coefficient of P, then the i-th coefficient of F will be given by:
 f_i = [Real(p_i)], if for all i
.IP
|f_i - p_i | < eps        (*)
.PP
holds.
Did (*) not hold for at least one i, then F = 0.
.PP
eps = -1 will be seen as infinity.
  
M*/

/*H
        Version 1       15.01.1994	Georg J. Lay
   DATE upcround      : 941201
H*/

#include <_pol1.h>

pol upcround (P,eps)
pol	      P;
floating        eps;
 {
 single i;
 pol W;
 complex around,ar;

 bind (P,eps);
 init (W);
 init (around,ar);

 for (W = _0; P != _0; P = lred2 (P))
   {
   around = creal (lsecond (P));
   around = flround (around);
   ar = itofl (around);     
   ar = ccri (ar,0);

   if (eps == -1)
     { if (around != 0) 	W = lcomp2 (around,lfirst(P),W);}
   else
     if (iscinball (lsecond (P),ar,eps) == 1)	
        { if (around != 0) 	W = lcomp2 (around,lfirst(P),W);}
     else  return (_0);
   }

 W = linv (W);

 if (W == _0) W = 0;

 return (W);
 }
