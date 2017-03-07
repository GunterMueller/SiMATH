/*M
.SH NAME
iqfroot - integer quadratic form, root

.SH SYNOPSIS
.nf
#include<_arith1.h>

complex iqfroot(a,b,c)
int a,b,c;

.SH DESCRIPTION
iqfroot() returns a complex number t which is associated
to the quadratic form Q(x, y) = a*x^2 + b*x*y + c*y^2.
It holds that Q(t, 1) = 0 and Imag(t) >= 0.
Let D = b*b - 4*a*c, then the exact value returned is t = (-b+-sqrt(D))/2a
M*/
/*H
        Version 1       15.01.1993	Georg J. Lay
   DATE iqfroot       : 941201
H*/

#include <_arith1.h>

complex iqfroot (a,b,c)
int a,b,c;
 {
 int D;
 complex tau;

 bind (a,b,c);
 init (D);
 init (tau);

 c = iprod (a,c);
 c = iprod (4,c);
 D = iprod (b,b);
 D = idif  (D,c);			/* D = b^2 - 4*a*c		*/
 a = isum  (a,a);
 b = ineg  (b);

 if (icomp (D,0) < 0)
   {
   D = ineg   (D);
   D = itofl  (D);
   D = flsqrt (D);
   D = ccri (0,D);
   }
 else
   {
   D = itofl  (D);
   D = flsqrt (D);
   D = ccri (D,0);
   }

 if (icomp (a,0) < 0)	D = cneg (D);

 tau = cisum (D,b);
 tau = ciquot (tau,a);

 return (tau);
 } 
